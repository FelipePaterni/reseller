# Arquitetura em Camadas - Guia Completo

## 📐 Estrutura de Módulos

Cada módulo (ex: `recipes`, `ingredients`) segue a Clean Architecture com 3 camadas:

```
lib/src/modules/recipes/
├── domain/          ← Lógica de negócio pura
│   ├── entities/    ← Objetos de negócio (Recipe, RecipeItem)
│   └── repositories/← Contratos (interfaces) de acesso a dados
├── data/            ← Implementação de acesso a dados
│   ├── datasource/  ← Onde os dados vêm (local, remoto, API)
│   ├── models/      ← DTOs para serialização/deserialização
│   └── repositories/← Implementações concretas
└── presentation/    ← UI e State Management
    ├── pages/       ← Telas completas
    ├── widgets/     ← Componentes reutilizáveis
    └── provider/    ← State management (Provider, BLoC, etc)
```

---

## 🎯 Responsabilidades de Cada Camada

### **DOMAIN** (Camada Mais Interna)
**Propósito**: Define regras de negócio, independente de tecnologia

#### ✅ O que DEVE ter:
- **Entities**: Objetos puros de negócio (`Recipe`, `Ingredient`)
  - Sem dependências externas
  - Métodos de lógica pura
  - Exemplo: `recipe.totalCost`, `recipe.copyWith()`
  
- **Repositories (Abstratos)**: Contratos de acesso a dados
  - Apenas interfaces/abstract classes
  - Define "O QUÊ" fazer (não "COMO")
  - Exemplo:
    ```dart
    abstract class RecipesRepository {
      Future<List<Recipe>> getAll();
      Future<Recipe?> getById(String id);
      Future<void> save(Recipe recipe);
      Future<void> delete(String id);
    }
    ```

- **Use Cases** (Opcional): Lógica complexa de negócio
  - Encapsula fluxos de operações
  - Exemplo: `CalculateRecipeCostUseCase`

#### ❌ O que NÃO DEVE ter:
- Widgets, UI, temas
- Banco de dados, API, HTTP
- Dependências do Flutter
- Serializadores (json, etc)
- Estado mutável

#### 📋 Exemplo: `Recipe` (Entity)
```dart
// lib/src/modules/recipes/domain/entities/recipe.dart
class Recipe {
  final String? id;
  final String name;
  final List<RecipeItem> items;
  final double yieldRecipe;
  
  // Lógica pura de negócio
  double get totalCost => items.fold(0, (sum, item) => sum + item.totalCost);
  
  Recipe copyWith({...}) { ... }
}
```

---

### **DATA** (Camada do Meio)
**Propósito**: Implementar acesso aos dados, mapear entre camadas

#### ✅ O que DEVE ter:

1. **DataSource (Abstrato)**: Define contrato de acesso
   - Trabalha com **RecipeModel** (DTOs)
   - Exemplo:
     ```dart
     abstract class RecipesDataSource {
       Future<List<RecipeModel>> getAll();
       Future<RecipeModel> getById(String id);
       Future<RecipeModel> save(RecipeModel recipe);
     }
     ```

2. **DataSource (Implementações)**:
   - `RecipesLocalDataSourceImpl` → Banco de dados local, hive, sqflite
   - `RecipesRemoteDataSourceImpl` → API REST, Firebase
   - `RecipesCacheDataSourceImpl` → Cache em memória
   
   Exemplo:
   ```dart
   class RecipesLocalDataSourceImpl implements RecipesDataSource {
     final Box<RecipeModel> box; // Hive, Drift, etc
     
     @override
     Future<List<RecipeModel>> getAll() async {
       return box.values.toList();
     }
   }
   ```

3. **Models (DTOs)**: Representação de dados
   - Copias "planas" das Entities
   - Inclui serialização (toJson, fromJson)
   - Mapea para Entity: `model.toEntity()`
   - Exemplo:
     ```dart
     class RecipeModel {
       final String? id;
       final String name;
       final List<RecipeItemModel> items;
       
       // DTO para serialização
       factory RecipeModel.fromJson(Map<String, dynamic> json) { ... }
       Map<String, dynamic> toJson() { ... }
       
       // Mapeamento para Entity
       Recipe toEntity() { ... }
     }
     ```

4. **Repository (Implementação Concreta)**:
   - Implementa interface do Domain
   - Orquestra qual DataSource usar
   - Mapeia Models ↔ Entities
   - Exemplo:
     ```dart
     class RecipesRepositoryImpl implements RecipesRepository {
       final RecipesDataSource dataSource;
       
       @override
       Future<List<Recipe>> getAll() async {
         final models = await dataSource.getAll();
         return models.map((m) => m.toEntity()).toList();
       }
     }
     ```

#### ❌ O que NÃO DEVE ter:
- Lógica de negócio complexa
- Widgets ou UI
- Gerenciar estado de aplicação
- Validações de regra de negócio (isso é Domain)

#### 📋 Estrutura esperada:
```
data/
├── datasource/
│   ├── recipes_datasource.dart           # Abstract
│   ├── recipes_local_datasource_impl.dart
│   └── recipes_remote_datasource_impl.dart
├── models/
│   └── recipe_model.dart                 # DTOs
└── repositories/
    └── recipes_repository_impl.dart      # Implementação concreta
```

---

### **PRESENTATION** (Camada Externa)
**Propósito**: Gerenciar UI e estado visível

#### ✅ O que DEVE ter:

1. **Pages**: Telas completas
   - Combinam múltiplos widgets
   - Coordenam navegação
   - Exemplo: `RecipeListPage`, `RecipeDetailPage`

2. **Widgets**: Componentes reutilizáveis
   - Cards, botões, formulários
   - Sem lógica de negócio
   - Recebem dados via parâmetros
   - Exemplo: `RecipeCard`, `RecipeItemForm`

3. **Provider/State Management**: Gerencia estado
   - Mantém lista de receitas em memória
   - Notifica UI de mudanças
   - Chama Repository
   - **NÃO contém lógica de negócio**
   
   Exemplo:
   ```dart
   class RecipesProvider with ChangeNotifier {
     final RecipesRepository repository;
     List<Recipe> _recipes = [];
     bool _isLoading = false;
     
     Future<void> load() async {
       _isLoading = true;
       notifyListeners();
       
       _recipes = await repository.getAll();
       
       _isLoading = false;
       notifyListeners();
     }
   }
   ```

#### ❌ O que NÃO DEVE ter:
- DataSource ou acesso direto a banco de dados
- DTOs ou Models de serialização
- Lógica complexa de negócio
- Dependências que devem estar no Domain

#### 📋 Estrutura esperada:
```
presentation/
├── pages/
│   ├── recipes_list_page.dart
│   └── recipe_detail_page.dart
├── widgets/
│   ├── recipe_card.dart
│   └── recipe_item_form.dart
└── provider/
    └── recipes_provider.dart
```

---

## 🔄 Fluxo de Dados

```
┌─────────────────────────────────────────────────────┐
│                  PRESENTATION                        │
│  Widget → Provider (State Manager)                   │
│         ↓                                            │
│  Chamada: provider.load(), provider.save()          │
└─────────────┬───────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────────────────┐
│                    DOMAIN                           │
│  Repository (Interface)                             │
│  Entity: Recipe, RecipeItem (Objetos puros)         │
└─────────────┬───────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────────────────┐
│                     DATA                            │
│  Repository (Implementação) coordena:              │
│  - Qual DataSource usar (local, remoto)            │
│  - Mapeia RecipeModel ↔ Recipe                      │
│         ↓                                            │
│  DataSource: LocalDataSourceImpl                     │
│  - Acessa banco de dados                           │
│  - Trabalha com RecipeModel (DTO)                   │
│         ↓                                            │
│  [Banco de Dados, API, Cache]                       │
└─────────────────────────────────────────────────────┘
```

---

## 📝 Exemplo Completo: Criar Receita

### 1️⃣ **Widget chama Provider**
```dart
// presentation/pages/recipes_list_page.dart
ElevatedButton(
  onPressed: () {
    context.read<RecipesProvider>().createOrUpdate(newRecipe);
  },
)
```

### 2️⃣ **Provider coordena estado**
```dart
// presentation/provider/recipes_provider.dart
Future<void> createOrUpdate(Recipe recipe) async {
  _isLoading = true;
  notifyListeners();
  
  try {
    await repository.save(recipe);  // ← Chama Domain
    await load();
  } catch (e) {
    _error = e.toString();
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
```

### 3️⃣ **Repository implementa contrato**
```dart
// data/repositories/recipes_repository_impl.dart
Future<void> save(Recipe recipe) async {
  final model = RecipeModel.fromEntity(recipe);  // ← Mapeia
  await dataSource.save(model);                   // ← Delega
}
```

### 4️⃣ **DataSource acessa dados**
```dart
// data/datasource/recipes_local_datasource_impl.dart
Future<RecipeModel> save(RecipeModel recipe) async {
  final id = recipe.id ?? Uuid().v4();
  _recipes[id] = recipe.copyWith(id: id);
  return recipe;
}
```

---

## 🎓 Regras SOLID na Prática

### **S - Single Responsibility**
- `RecipeModel` → apenas DTO
- `RecipesLocalDataSourceImpl` → apenas acesso local
- `RecipesProvider` → apenas estado
- `RecipeCard` → apenas renderizar um card

### **O - Open/Closed**
- Interface `RecipesDataSource` aberta para novas implementações
- Código fechado para modificação: `RecipesRepositoryImpl` não muda

### **L - Liskov Substitution**
- `RecipesLocalDataSourceImpl` e `RecipesRemoteDataSourceImpl` substituem `RecipesDataSource`

### **I - Interface Segregation**
- `RecipesRepository` tem métodos bem definidos
- Não força implementações com métodos desnecessários

### **D - Dependency Inversion**
- `RecipesRepositoryImpl` depende de `RecipesDataSource` (abstração)
- Não depende de implementação concreta

---

## 🚀 Checklist para Novo Módulo

- [ ] **Domain/entities**: Classes puras, sem dependências
- [ ] **Domain/repositories**: Interfaces abstratas
- [ ] **Data/models**: DTOs com serialização
- [ ] **Data/datasource**: Interface + implementações (local, remoto)
- [ ] **Data/repositories**: Implementação concreta, mapeia Model ↔ Entity
- [ ] **Presentation/provider**: State manager, sem lógica de negócio
- [ ] **Presentation/widgets**: Componentes reutilizáveis
- [ ] **Presentation/pages**: Telas que combinam widgets

---

## 🔗 Referências

- [Clean Architecture - Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture Guide](https://resocoder.com/flutter-clean-architecture-tdd)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
