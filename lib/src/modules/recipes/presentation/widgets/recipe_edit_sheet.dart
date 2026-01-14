import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/core/theme/app_colors.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/presentation/provider/recipes_provider.dart';

class RecipeEditSheet extends StatefulWidget {
  final Recipe? recipe;

  const RecipeEditSheet({super.key, this.recipe});

  @override
  State<RecipeEditSheet> createState() => _RecipeEditSheetState();
}

class _RecipeEditSheetState extends State<RecipeEditSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  late String _recipeName;
  late double _yieldRecipe;
  late String _imagePath;
  bool _isLoading = false;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _recipeName = widget.recipe!.name;
      _yieldRecipe = widget.recipe!.yieldRecipe;
      _imagePath = widget.recipe!.imagePath;
    } else {
      _recipeName = '';
      _yieldRecipe = 1.0;
      _imagePath = '';
    }
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _imagePath = image.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao selecionar imagem: $e')),
        );
      }
    }
  }

  Future<void> _saveRecipe() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final recipesProvider = Provider.of<RecipesProvider>(
          context,
          listen: false,
        );

        final newRecipe = Recipe(
          id: widget.recipe?.id,
          name: _recipeName,
          yieldRecipe: _yieldRecipe,
          imagePath: _imagePath,
          items: widget.recipe?.items ?? [],
        );

        await recipesProvider.createOrUpdate(newRecipe);

        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.recipe != null
                    ? 'Receita atualizada com sucesso'
                    : 'Receita criada com sucesso',
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Erro ao salvar receita: $e')));
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  widget.recipe != null ? 'Editar Receita' : 'Nova Receita',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: Icon(Icons.close, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            // Image Picker Section
            GestureDetector(
              onTap: _isLoading ? null : _pickImage,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: colorScheme.outline, width: 1.5),
                ),
                child: _selectedImage != null || _imagePath.isNotEmpty
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(11),
                            ),
                            child: Image.file(
                              _selectedImage ?? File(_imagePath),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: FloatingActionButton.small(
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                      setState(() {
                                        _selectedImage = null;
                                        _imagePath = '';
                                      });
                                    },
                              backgroundColor: AppColors.brandAccent,
                              child: const Icon(Icons.close),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 48,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap para adicionar foto',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            FormBuilderTextField(
              name: 'recipe_name',
              initialValue: _recipeName,
              decoration: const InputDecoration(
                labelText: 'Nome da Receita',
                hintText: 'Ex: Bolo de Chocolate',
              ),
              onChanged: (value) => setState(() => _recipeName = value ?? ''),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome da receita';
                }
                if (value.length < 3) {
                  return 'Nome deve ter pelo menos 3 caracteres';
                }
                return null;
              },
            ),
            FormBuilderTextField(
              name: 'yield_recipe',
              initialValue: _yieldRecipe.toString(),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Rendimento (porções)',
                hintText: '1.0',
              ),
              onChanged: (value) => setState(
                () => _yieldRecipe = double.tryParse(value ?? '') ?? 1.0,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o rendimento';
                }
                final yield_ = double.tryParse(value);
                if (yield_ == null || yield_ <= 0) {
                  return 'Rendimento deve ser maior que zero';
                }
                return null;
              },
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () => Navigator.of(context).maybePop(),
                    child: const Text('Cancelar'),
                  ),
                ),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _isLoading ? null : _saveRecipe,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.check, size: 18),
                    label: Text(widget.recipe != null ? 'Atualizar' : 'Criar'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
