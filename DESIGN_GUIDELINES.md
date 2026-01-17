# Design System Guidelines — Reseller App

## 🎨 Paleta de Cores (AppColors + ColorScheme)

### Colors Disponíveis (AppColors)
```dart
// Brand (Warm Palette)
AppColors.brandBackground   // F6EFE7 (soft cream)
AppColors.brandAccent       // C78B54 (warm terracotta)
AppColors.brandAccentDark   // A0673D (darker terracotta)

// Semantic (Text)
AppColors.textPrimary       // 6B4A2A (dark brown)
AppColors.textSecondary     // 8C6A4A (lighter brown)
AppColors.textTertiary      // B8A89D (very light)
AppColors.textInverted      // FAFAF5 (light for dark bg)

// Surface
AppColors.surface           // FFFFFF (white)
AppColors.surfaceVariant    // FAF8F5 (subtle alternative)

// Semantic States
AppColors.error             // B3261E (destructive)
AppColors.success           // 2E7D32 (success)
AppColors.warning           // F57C00 (warning)
AppColors.info              // 1976D2 (info)

// Utility
AppColors.shadowDark        // 1A6B4A2A (shadow tint)
AppColors.scrim             // 1F000000 (overlay)
AppColors.divider           // E8DDD2 (border)
AppColors.disabled          // CCC2B8 (inactive)
```

### ColorScheme Disponível (Material 3)
```dart
// Light Theme
colorScheme.primary         // C78B54 (brand accent)
colorScheme.onPrimary       // FAFAF5 (text on primary)
colorScheme.primaryContainer // Shade light
colorScheme.onPrimaryContainer

colorScheme.secondary       // Derivado de primary
colorScheme.onSecondary
colorScheme.secondaryContainer

colorScheme.error           // B3261E
colorScheme.onError         // FFFFFF (use, não Colors.white)

colorScheme.surface         // FFFFFF
colorScheme.onSurface       // 6B4A2A (texto primário)
colorScheme.surfaceContainer
colorScheme.surfaceContainerHighest
colorScheme.onSurfaceVariant // 8C6A4A (texto secundário)

colorScheme.outline         // Bordas padrão
colorScheme.outlineVariant  // Bordas sutis
colorScheme.scrim           // Overlay/gradient
colorScheme.shadow          // Sombras

colorScheme.inverseSurface  // Para inversão
colorScheme.onInverseSurface
```

---

## 📐 Espaçamento (Grid 8px)

### Tokens Disponíveis (AppSpacing)
```dart
AppSpacing.xs   = 4px   // Micro spacing (icon gaps)
AppSpacing.sm   = 8px   // Small spacing (tight groups)
AppSpacing.md   = 16px  // Medium (default padding)
AppSpacing.lg   = 24px  // Large (section separation)
AppSpacing.xl   = 32px  // Extra large (major gaps)
AppSpacing.xxl  = 48px  // Double XL (screen padding)
```

### Espaçamento Prático
```dart
// Páginas e Scaffolds
padding: const EdgeInsets.all(16),                      // 16px
padding: const EdgeInsets.symmetric(horizontal: 16),    // 16px horizontal

// Cards e Containers
padding: const EdgeInsets.all(16),                      // 16px (padrão)
padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

// DialogsScaffolds
padding: EdgeInsets.only(
  left: 24,
  right: 24,
  top: 32,
  bottom: MediaQuery.of(context).viewInsets.bottom + 32,
),

// Spacing entre elementos em Row/Column
spacing: 8,   // Ícones e linhas simples
spacing: 12,  // Elementos de interface
spacing: 16,  // Seções maiores

// SizedBox (quando spacing não disponível)
const SizedBox(height: 12),   // Entre campos
const SizedBox(width: 8),     // Entre ícone e texto
```

---

## 🔤 Tipografia (TextTheme)

### Hierarquia de Tipos
```dart
// Display (Grandes títulos)
textTheme.displayLarge      // Headlines muito grandes
textTheme.displayMedium     // Headlines grandes
textTheme.displaySmall      // Headlines (use aqui)

// Headline (Títulos de seção)
textTheme.headlineLarge     // Títulos principais de página
textTheme.headlineMedium    // Títulos de seção
textTheme.headlineSmall     // Títulos menores

// Title (Títulos pequenos)
textTheme.titleLarge        // ❌ Evitar
textTheme.titleMedium       // ✅ Títulos em cards
textTheme.titleSmall        // ✅ Subtítulos

// Body (Corpo)
textTheme.bodyLarge         // ❌ Raramente usar
textTheme.bodyMedium        // ✅ Descrições, corpo normal
textTheme.bodySmall         // ✅ Texto secundário

// Label (Rótulos)
textTheme.labelLarge        // ✅ Botões, labels grandes
textTheme.labelMedium       // ✅ Chips, labels normais
textTheme.labelSmall        // ✅ Hints, texto muito pequeno
```

### Exemplos de Uso
```dart
// Título de página
Text(
  'Resumo',
  style: textTheme.headlineLarge?.copyWith(
    fontWeight: FontWeight.bold,
  ),
),

// Título de card
Text(
  recipe.name,
  style: textTheme.titleMedium?.copyWith(
    color: colorScheme.primary,
    fontWeight: FontWeight.w600,
  ),
),

// Valor principal (grande)
Text(
  '42',
  style: textTheme.displaySmall?.copyWith(
    color: colorScheme.primary,
    fontWeight: FontWeight.bold,
  ),
),

// Texto secundário
Text(
  'Descrição',
  style: textTheme.bodySmall?.copyWith(
    color: colorScheme.onSurfaceVariant,
  ),
),

// Label/Chip
Text(
  'Qtd: 100 kg',
  style: textTheme.labelMedium?.copyWith(
    color: colorScheme.onSurface,
  ),
),
```

### Font Weights
```dart
FontWeight.bold         // ❌ Evitar (use .w700 ou w600)
FontWeight.w600         // ✅ Semi-bold (títulos refinados)
FontWeight.w500         // ✅ Medium (destaque)
FontWeight.normal       // ✅ Regular (corpo padrão)
```

---

## 🎯 Componentes Padronizados

### Cards
```dart
Card(
  // Elevação automática: 2
  // Radius automática: 22px
  // Cor automática: colorScheme.surfaceContainer
  child: InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(16),  // ✅ Padrão
      child: Column(
        spacing: 12,  // ✅ Entre elementos
        children: [
          // Conteúdo
        ],
      ),
    ),
  ),
)
```

### Buttons
```dart
// Ação Primária (preferência)
FilledButton(
  onPressed: () {},
  child: const Text('Ação Primária'),
  // Padding automático: horizontal 24, vertical 12
  // Radius automático: 12px
  // Cor automática: primary
)

// Ação Secundária
OutlinedButton(
  onPressed: () {},
  child: const Text('Ação Secundária'),
  // Estilo automático do tema
)

// Ação Terciária
TextButton(
  onPressed: () {},
  child: const Text('Ação Terciária'),
  // Estilo automático do tema
)

// Ícone
FilledButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.add),
  label: const Text('Novo'),
)
```

### Chips
```dart
Chip(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  label: Text(
    'Label',
    style: textTheme.labelSmall?.copyWith(
      color: colorScheme.onSurface,
    ),
  ),
)
```

### Icons
```dart
// Ícone simples (em lista, AppBar)
Icon(
  Icons.edit,
  color: colorScheme.primary,
  size: 24,
)

// Ícone em background (cards, dashboard)
Container(
  padding: const EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: colorScheme.primary.withAlpha(25),  // ✅ Fundo com alpha
    borderRadius: BorderRadius.circular(8),
  ),
  child: Icon(
    Icons.restaurant,
    color: colorScheme.primary,
    size: 24,
  ),
)

// IconButton (com densidade compacta)
IconButton(
  onPressed: () {},
  icon: Icon(Icons.edit, color: colorScheme.primary),
  visualDensity: VisualDensity.compact,
  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),  // ✅ Acessibilidade
)
```

---

## 🎯 Padrões Comuns

### Página com Lista
```dart
@override
Widget build(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 12,
        children: [
          // Botão de ação
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Novo'),
          ),
          
          // Lista com consumer
          Expanded(
            child: Consumer<Provider>(
              builder: (context, provider, _) {
                if (provider.all.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum item encontrado.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: provider.count,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: YourCard(item: provider.all[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
```

### Card com Múltiplas Linhas
```dart
Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        // Header (Título + Actions)
        Row(
          children: [
            Expanded(
              child: Text(
                'Título',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        
        // Divider
        Divider(color: colorScheme.outlineVariant),
        
        // Content
        Text(
          'Descrição',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    ),
  ),
)
```

### Empty State
```dart
if (items.isEmpty) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.inbox_outlined,
          size: 64,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 16),
        Text(
          'Nenhum item encontrado',
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Clique em "Novo" para adicionar um.',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
```

---

## ❌ O Que NUNCA Fazer

```dart
// ❌ NUNCA: Colors hardcoded
Colors.white                          // Use colorScheme.onError
Colors.black                          // Use colorScheme.onSurface
Color(0xFF6B4A2A)                    // Use AppColors ou colorScheme

// ❌ NUNCA: Espaçamento arbitrário
padding: const EdgeInsets.all(11),    // Use 8, 12, 16, 20, 24
const SizedBox(height: 7),            // Use 8, 12, 16

// ❌ NUNCER: Tipografia inconsistente
style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)  // Use textTheme
style: const TextStyle(color: Color(0xFF6B4A2A))            // Use colorScheme

// ❌ NUNCA: Buttons customizados quando tema tem
ElevatedButton.styleFrom(
  backgroundColor: Colors.blue,       // Use colorScheme
  padding: EdgeInsets.all(10),        // Tema define
)

// ❌ NUNCA: Elevações ou radius arbitrárias
Card(
  elevation: 5,                       // Tema define
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),  // Use 22, 12, 8
  ),
)
```

---

## ✅ Checklist ao Criar Novo Widget

- [ ] **Cores:** Apenas `colorScheme.*` ou `AppColors`?
- [ ] **Tipografia:** Usando `textTheme.*` com styles corretos?
- [ ] **Espaçamento:** Múltiplos de 8 (4, 8, 12, 16, 20, 24)?
- [ ] **Padding de Card:** `16px` ou `20px` (não `8`, `10`, `14`)?
- [ ] **Padding de Page:** `16px` ou `24px`?
- [ ] **Button:** `FilledButton` primária (não `ElevatedButton`)?
- [ ] **Ícones:** Com background em cards/dashboards?
- [ ] **Acessibilidade:** Áreas tappáveis >= 44x44?
- [ ] **Empty States:** Feedback visual claro?
- [ ] **Theme Extraction:** `final theme = Theme.of(context)`?

---

## 📚 Referências

- `lib/src/core/theme/app_theme.dart` — Definições do tema
- `lib/src/core/theme/app_colors.dart` — Paleta de cores
- `lib/src/core/theme/app_spacing.dart` — Tokens de espaçamento
- `lib/src/core/theme/app_texts.dart` — Definições de tipografia
- `development_rules.instructions.md` — Guidelines do projeto

---

**Última atualização:** 16 de janeiro de 2026
**Status:** ✅ Ativo
**Manutenção:** Em dia
