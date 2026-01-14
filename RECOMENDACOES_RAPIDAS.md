# 🚀 Recomendações Rápidas - Reseller App

## ✅ Correções Já Implementadas

### 1. Dashboard - Contador de Ingredientes
**Problema:** Valor hardcoded "1" ao invés de valor dinâmico  
**Solução:** Conectado ao IngredientsProvider  
**Arquivo:** `lib/src/modules/home/presentation/pages/home.dart`

```dart
// ❌ Antes
value: "1",

// ✅ Agora
value: context.watch<IngredientsProvider>().count.toString(),
```

---

## 🎯 Próximas Vitórias Rápidas (Quick Wins)

### 1. Implementar Tab "Informações" da Receita ⏱️ 2-3 horas

**Localização:** `lib/src/modules/recipes/presentation/pages/recipe_info.dart` linha 142

**Código Atual:**
```dart
Text("EM construction"),
```

**Implementação Sugerida:**
```dart
Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 16,
    children: [
      _InfoCard(
        title: 'Rendimento',
        value: '${recipe.yieldRecipe} unidades',
        icon: Icons.production_quantity_limits,
      ),
      _InfoCard(
        title: 'Custo Total',
        value: 'R\$ ${_calculateTotalCost(recipe).toStringAsFixed(2)}',
        icon: Icons.attach_money,
      ),
      _InfoCard(
        title: 'Custo por Unidade',
        value: 'R\$ ${(_calculateTotalCost(recipe) / recipe.yieldRecipe).toStringAsFixed(2)}',
        icon: Icons.calculate,
      ),
      _InfoCard(
        title: 'Total de Ingredientes',
        value: '${recipe.items.length}',
        icon: Icons.format_list_numbered,
      ),
    ],
  ),
)

// Método auxiliar
double _calculateTotalCost(Recipe recipe) {
  return recipe.items.fold(0.0, (sum, item) => sum + item.totalCost);
}

// Widget do card
class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 32, color: AppColors.brandAccent),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTexts.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    value,
                    style: AppTexts.titleLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Benefícios:**
- ✅ Informações úteis para o usuário
- ✅ Cálculo de custo total e unitário
- ✅ UI consistente com o resto do app

---

### 2. Configurar Assets no pubspec.yaml ⏱️ 15 minutos

**Problema:** Referências a assets que não existem

**Arquivo:** `pubspec.yaml`

```yaml
flutter:
  uses-material-design: true
  
  # Adicionar:
  assets:
    - assets/images/
    - assets/icons/
```

**Criar estrutura de diretórios:**
```bash
mkdir -p assets/images
mkdir -p assets/icons

# Adicionar imagem placeholder
# (baixar uma imagem genérica de comida/receita)
```

**Atualizar recipe_mock.dart:**
```dart
// Remover referências a assets inexistentes ou usar URLs
imagePath: "https://picsum.photos/400/280?random=2",
```

---

### 3. Adicionar Validação de Quantidade > 0 ⏱️ 30 minutos

**Localização:** `lib/src/modules/ingredients/presentation/widgets/ingredient_edit_sheet.dart`

**Adicionar validador:**
```dart
FormBuilderTextField(
  name: 'quantity',
  decoration: const InputDecoration(labelText: 'Quantidade'),
  keyboardType: TextInputType.number,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Quantidade é obrigatória';
    }
    final qty = double.tryParse(value);
    if (qty == null || qty <= 0) {
      return 'Quantidade deve ser maior que zero';
    }
    return null;
  },
)
```

**Aplicar em:**
- `ingredient_edit_sheet.dart` (quantidade e custo total)
- `recipe_edit_sheet.dart` (rendimento)
- `recipe_item_edit_sheet.dart` (quantidade)

---

### 4. Melhorar Mensagens de Erro ⏱️ 1 hora

**Exemplos de melhorias:**

```dart
// ❌ Antes
throw Exception('Recipe with id $id not found');

// ✅ Depois
class RecipeNotFoundException implements Exception {
  final String id;
  RecipeNotFoundException(this.id);
  
  @override
  String toString() => 'Receita não encontrada (ID: $id)';
}
```

**Uso em UI:**
```dart
try {
  await provider.deleteById(id);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Receita excluída com sucesso'),
      backgroundColor: AppColors.success,
    ),
  );
} on RecipeNotFoundException {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Receita não encontrada'),
      backgroundColor: AppColors.error,
    ),
  );
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Erro ao excluir receita: $e'),
      backgroundColor: AppColors.error,
    ),
  );
}
```

---

### 5. Adicionar Loading States ⏱️ 1 hora

**Problema:** Operações assíncronas sem feedback visual

**Implementação em RecipesProvider:**

```dart
class RecipesProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _error;
  String? get error => _error;
  
  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _recipes = await repository.getAll();
    } catch (e) {
      _error = 'Erro ao carregar receitas: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

**Uso em RecipeList:**

```dart
@override
Widget build(BuildContext context) {
  return Consumer<RecipesProvider>(
    builder: (context, provider, _) {
      if (provider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      
      if (provider.error != null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text(provider.error!),
              ElevatedButton(
                onPressed: provider.load,
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        );
      }
      
      // Lista normal...
    },
  );
}
```

---

### 6. Padronizar Providers (Async) ⏱️ 30 minutos

**Problema:** IngredientsProvider é síncrono, RecipesProvider é assíncrono

**Solução:** Tornar IngredientsProvider assíncrono para facilitar migração futura

```dart
class IngredientsProvider with ChangeNotifier {
  // Adicionar métodos async
  Future<void> createOrUpdateAsync(Ingredient ingredient) async {
    // Simular delay (remover quando implementar BD real)
    await Future.delayed(const Duration(milliseconds: 100));
    
    if (ingredient.id != null &&
        ingredient.id!.isNotEmpty &&
        _ingredients.containsKey(ingredient.id)) {
      _ingredients[ingredient.id!] = ingredient;
    } else {
      final id = const Uuid().v4();
      _ingredients[id] = Ingredient(
        id: id,
        name: ingredient.name,
        quantity: ingredient.quantity,
        unitLabel: ingredient.unitLabel,
        costPerUnit: ingredient.costPerUnit,
        totalCost: ingredient.totalCost,
      );
    }
    notifyListeners();
  }
  
  Future<void> deleteByIdAsync(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (_ingredients.containsKey(id)) {
      _ingredients.remove(id);
      notifyListeners();
    }
  }
}
```

---

## 📝 Checklist de Implementação

### Esta Semana
- [ ] Implementar Tab Informações (2-3h)
- [ ] Adicionar validações de quantidade > 0 (30min)
- [ ] Configurar assets (15min)
- [ ] Melhorar mensagens de erro (1h)

### Próxima Semana
- [ ] Adicionar loading states (1h)
- [ ] Padronizar providers para async (30min)
- [ ] Criar primeiros testes unitários (2-3h)
- [ ] Refatorar arquivos grandes (recipe_edit_sheet, etc.) (2-4h)

### Próximo Mês
- [ ] Implementar persistência (Hive ou Drift) (1-2 dias)
- [ ] Funcionalidade de escalabilidade de receitas (1 dia)
- [ ] Adicionar cálculo de markup e preço sugerido (4h)
- [ ] Exportar receitas em PDF (1 dia)

---

## 🎓 Recursos Úteis

### Documentação
- [Flutter Testing](https://docs.flutter.dev/testing)
- [Provider Package](https://pub.dev/packages/provider)
- [Hive Database](https://docs.hivedb.dev/)
- [Form Validation](https://docs.flutter.dev/cookbook/forms/validation)

### Packages Recomendados
```yaml
dependencies:
  # Persistência
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Exportação PDF
  pdf: ^3.10.4
  printing: ^5.11.0
  
  # Formatação de moeda
  intl: ^0.18.1

dev_dependencies:
  # Geração de código para Hive
  hive_generator: ^2.0.1
  build_runner: ^2.4.6
  
  # Testes
  mockito: ^5.4.2
```

---

**Última atualização:** 2026-01-14  
**Próxima revisão:** Implementar itens da checklist e atualizar este documento
