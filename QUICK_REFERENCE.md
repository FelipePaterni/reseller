# 🚀 Quick Reference - O Que Cada Camada Faz

## TL;DR (Muito Longo; Não Leu)

```
┌─────────────────────────────────────────────┐
│ PRESENTATION (pages + widgets + provider)    │
│ ↓ UI and State Management only              │
├─────────────────────────────────────────────┤
│ DOMAIN (entities + abstract repositories)    │
│ ↓ Business Logic - Pure & Independent        │
├─────────────────────────────────────────────┤
│ DATA (datasources + models + repositories)   │
│ ↓ Data Access - Talk to DB/API/Memory       │
├─────────────────────────────────────────────┤
│ [Banco de Dados / API / Cache / Arquivo]    │
└─────────────────────────────────────────────┘
```

---

## 📋 Checklist ao Criar Novo Módulo

### ✅ Domain
- [ ] Criar `entities/` - classes puras do negócio
- [ ] Criar `repositories/` - interfaces abstratas (sem implementação)
- [ ] Sem dependências do Flutter ou externas

### ✅ Data
- [ ] Criar `datasource/` - interface + implementações
- [ ] Criar `models/` - DTOs com `toEntity()` e `fromEntity()`
- [ ] Criar `repositories/` - implementação concreta que mapeia Model ↔ Entity

### ✅ Presentation
- [ ] Criar `pages/` - telas completas
- [ ] Criar `widgets/` - componentes reutilizáveis
- [ ] Criar `provider/` - state management

---

## 🔍 Quando Adicionar Código, Pergunta-se

### "Isso é lógica de NEGÓCIO?" 
- Sim → **DOMAIN** (Entities, Use Cases)
- Não → próxima pergunta

### "Isso é sobre ACESSO a dados?"
- Sim → **DATA** (DataSource, Repository, Models)
- Não → próxima pergunta

### "Isso é sobre UI/STATE?"
- Sim → **PRESENTATION** (Widget, Provider)
- Não → Provavelmente está no lugar errado

---

## 💾 Estrutura de Arquivo - Copie & Cole

```
modules/novomodulo/
├── domain/
│   ├── entities/
│   │   └── minha_entidade.dart
│   ├── repositories/
│   │   └── minha_repository.dart
│   └── usecases/                    # Optional, para lógica complexa
│       └── meu_usecase.dart
│
├── data/
│   ├── datasource/
│   │   ├── minha_datasource.dart    # Abstract
│   │   └── minha_local_datasource_impl.dart
│   ├── models/
│   │   └── minha_model.dart
│   └── repositories/
│       └── minha_repository_impl.dart
│
└── presentation/
    ├── pages/
    │   └── minha_page.dart
    ├── widgets/
    │   └── meu_widget.dart
    └── provider/
        └── minha_provider.dart
```

---

## 🎯 Exemplos Rápidos

### Domain - Entity (Pura)
```dart
// ✅ BOM
class Recipe {
  final String id;
  final String name;
  final List<RecipeItem> items;
  
  double get totalCost => items.fold(0, (s, i) => s + i.totalCost);
}

// ❌ RUIM - não mexer
class Recipe {
  List<Recipe> fromJson(String json) { ... } // DataSource, não aqui!
  void saveToDatabase() { ... } // Data, não aqui!
  Widget buildWidget() { ... } // Presentation, não aqui!
}
```

### Data - DataSource (Acesso)
```dart
// ✅ BOM
abstract class RecipesDataSource {
  Future<List<RecipeModel>> getAll();
  Future<RecipeModel> getById(String id);
  Future<RecipeModel> save(RecipeModel recipe);
}

class RecipesLocalDataSourceImpl implements RecipesDataSource {
  // Implementa: SQLite, Hive, In-Memory, etc
}

// ❌ RUIM
class RecipesDataSource {
  Recipe getRecipe() { ... } // Retorna Entity! Deve retornar Model
  void validateRecipe(Recipe r) { ... } // Lógica de negócio aqui? Não!
}
```

### Data - Model (DTO)
```dart
// ✅ BOM
class RecipeModel {
  final String id;
  final String name;
  
  // Para ir para DB/JSON
  factory RecipeModel.fromJson(Map json) => RecipeModel(...);
  Map toJson() => {...};
  
  // Para ir para Entidade
  Recipe toEntity() => Recipe(...);
  factory RecipeModel.fromEntity(Recipe r) => RecipeModel(...);
}

// ❌ RUIM
class RecipeModel {
  Recipe toEntity() { ... } // OK
  // Mas sem fromJson/toJson - como serializa?
}
```

### Data - Repository (Orquestrador)
```dart
// ✅ BOM
class RecipesRepositoryImpl implements RecipesRepository {
  final RecipesDataSource dataSource;
  
  @override
  Future<List<Recipe>> getAll() async {
    final models = await dataSource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }
}

// ❌ RUIM
class RecipesRepositoryImpl implements RecipesRepository {
  // Implementa lógica de negócio aqui:
  Future<void> calculateTotalCost(String recipeId) async { ... }
  // Isso é Domain, não Data!
}
```

### Presentation - Provider (State)
```dart
// ✅ BOM
class RecipesProvider with ChangeNotifier {
  final RecipesRepository repository; // Apenas Repository!
  
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  
  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _recipes = await repository.getAll();
    } catch (e) {
      // Error handling
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// ❌ RUIM
class RecipesProvider with ChangeNotifier {
  final RecipesLocalDataSourceImpl dataSource; // Dependência muito específica!
  
  Future<void> load() async {
    _recipes = await dataSource.getAll().cast<Recipe>(); // Cast perigoso!
    notifyListeners(); // Sem tratamento de erro
  }
}
```

---

## 🔗 Regra de Ouro

**Dependências sempre apontam PARA DENTRO** (de fora para dentro):

```
Presentation → Domain ✅
Presentation → Data ❌ (Apresentação não conhece camada Data!)

Data → Domain ✅
Data → Presentation ❌ (Data não conhece UI!)

Domain → qualquer coisa ❌ (Domain é independente!)
```

---

## 📞 Conversão Entre Camadas

```
Presentation ←→ Domain
- Widget chama: provider.load()
- Provider retorna: List<Recipe> (Entity do Domain)

Domain ←→ Data
- Repository (Domain) define: Future<List<Recipe>> getAll()
- Repository (Data) implementa: receebe RecipeModel, mapeia para Recipe

Data ←→ Banco/API
- DataSource acessa: Database, API, Cache
- DataSource retorna: RecipeModel (DTO)
```

---

## 🚨 Erros Comuns a Evitar

| ❌ ERRADO | ✅ CORRETO |
|----------|----------|
| Provider acessa DataSource | Provider acessa Repository |
| Repository retorna Model | Repository retorna Entity |
| DataSource recebe Entity | DataSource recebe Model |
| Domain importa flutter | Domain é 100% Dart puro |
| Widget contém lógica complexa | Widget delega para Provider |
| Múltiplas responsabilidades | Uma classe = uma responsabilidade |

---

## 🎓 Próximas Coisas para Aprender

1. **Use Cases** - Para lógica de negócio complexa
2. **Dependency Injection** - Injetar Repository/DataSource
3. **Testing** - Unit tests, widget tests
4. **Error Handling** - Custom exceptions
5. **Caching Strategies** - Múltiplos DataSources

---

## 📚 Onde Procurar Código

```
Preciso mudar:        Olho em:
─────────────────────────────────────
Regra de negócio      domain/entities/
                      domain/usecases/

Acesso a dados        data/datasource/
                      data/models/

Estado/UI             presentation/provider/
                      presentation/widgets/

Interface repository  domain/repositories/
                      data/repositories/ (impl)
```

---

## 💡 Mentalidade

```
"Será que isso pertence aqui?"

Se sim → Ótimo! 🎉
Se não → Mova para a camada correta 📦
Se está no meio → Divida em 2 classes 🔀
```
