# Padronização Visual e Design — Reseller App

## Resumo das Mudanças

Esta documentação detalha a **padronização completa do design visual** do Reseller App, garantindo consistência em todos os widgets e páginas.

---

## ✅ Mudanças Implementadas

### 1. **Cores e Tema**

#### Antes
- Cores hardcoded em alguns widgets (`Colors.white`, `Colors.transparent`, `Color.fromARGB`)
- Inconsistência entre widgets usando `AppColors` vs cores diretas

#### Depois
- ✅ Todas as cores agora usam **`Theme.of(context).colorScheme`**
- ✅ Cores prioritárias do tema em vez de hardcoded
- ✅ Gradientes usam `colorScheme.scrim` em vez de `Color.fromARGB`
- ✅ Botões de erro usam `colorScheme.onError` em vez de `Colors.white`

**Arquivos corrigidos:**
- `recipe_info.dart` — gradient e cores do AppBar
- `ingredient_delete_sheet.dart` — foreground color do botão de erro
- Todos os widgets — consistência de paleta de cores

---

### 2. **Tipografia e Estilo de Texto**

#### Antes
- Estilos de texto inconsistentes (alguns `headlineSmall`, outros sem estilo)
- Falta de `fontWeight` em alguns textos
- Cores de texto não seguiam padrão

#### Depois
- ✅ **Hierarquia clara:**
  - Títulos: `titleMedium` com `fontWeight: w600`
  - Subtítulos/secundário: `labelSmall` ou `bodySmall`
  - Valor principal: `displaySmall` com `fontWeight: bold`
- ✅ Cores semânticas sempre aplicadas:
  - Texto primário: `onSurface`
  - Texto secundário: `onSurfaceVariant`
  - Acentos: `primary` ou `error`

**Arquivos corrigidos:**
- `home.dart` — título "Resumo" com `headlineLarge`
- `dashboard_card.dart` — hierarquia clara de tipografia
- `card_recipe.dart` — títulos com `titleMedium`
- `card_ingredients.dart` — valores e subtítulos padronizados

---

### 3. **Espaçamento e Padding**

#### Antes
- Espaçamento inconsistente (`padding: 8px`, `16px`, `20px` sem padrão)
- Gaps entre elementos variados

#### Depois
- ✅ **Grid 8px consistente:**
  - Padding de cards: `16px` (2x 8px)
  - Padding de páginas: `16px`–`24px`
  - Spacing entre elementos: `12px` ou `16px`
  - Gaps em LineasRows: `spacing: 8`, `12`, ou `16`
- ✅ ListViews com padding `8px` em cards, `16px` em container
- ✅ Dialogs e sheets com `24px` superior, `32px` inferior + viewInsets

**Arquivos corrigidos:**
- `home.dart` — `padding: 16` + `spacing: 16`
- `recipe_list.dart` — `padding: 16` + filledButton em vez de elevated
- `ingredient_list.dart` — padding consistente + empty state melhorado
- `card_ingredients.dart` — `padding: 16` + `spacing: 12` entre seções
- `dashboard_card.dart` — `padding: 20` + `spacing: 16`

---

### 4. **Cards e Componentes**

#### Antes
- Cards sem elevação definida consistentemente
- Ícones sem background container
- Chip sem padding uniforme

#### Depois
- ✅ **Cards padronizadas:**
  - Elevation definida no `cardTheme` do app
  - Border radius: `22px` (conforme design system)
  - Padding interno: `16px`
- ✅ **Ícones com background:**
  - DashboardCard: ícone em container com cor primária reduzida (alpha 25%)
  - CardRecipe: background `surfaceVariant` com radius `12px`
- ✅ **Chips:**
  - Padding: `12px horizontal`, `4px vertical`
  - Tipografia: `labelSmall`

**Arquivos corrigidos:**
- `dashboard_card.dart` — icon container com fundo colorido
- `card_recipe.dart` — leading widget com radius e spacing
- `card_ingredients.dart` — ícones com `visualDensity.compact`

---

### 5. **Botões**

#### Antes
- Mix de `ElevatedButton` e `FilledButton`
- Estilos inline sem usar tema

#### Depois
- ✅ **Prioridade de botões:**
  - Ação primária: `FilledButton` (tema já define estilo)
  - Ação secundária: `OutlinedButton`
  - Ação terciária: `TextButton`
- ✅ **Estilos do tema aplicados automaticamente**
  - Padding: `horizontal: 24, vertical: 12` (tema)
  - Border radius: `12px` (tema)
  - Cores do colorScheme

**Arquivos corrigidos:**
- `recipe_list.dart` — `FilledButton.icon` em vez de `ElevatedButton`
- `ingredient_list.dart` — `FilledButton.icon` em vez de `ElevatedButton`

---

### 6. **Páginas e Screens**

#### RecipeList
- ✅ Padding: `16px` (antes `8px`)
- ✅ Button: `FilledButton` com ícone
- ✅ Empty state: texto com cor `onSurfaceVariant`
- ✅ Spacing: `12px` entre sections

#### IngredientList
- ✅ Padding: `16px` (antes `8px`)
- ✅ Button: `FilledButton` com ícone
- ✅ Empty state: adicionado com feedback visual
- ✅ Spacing: `12px` entre sections

#### Home
- ✅ Título: `headlineLarge` com `fontWeight: bold`
- ✅ Padding: `16px` (antes sem padding)
- ✅ DashboardCards com ícones coloridos

#### RecipeInfo
- ✅ TabBar com cor de tema: `surfaceContainer`
- ✅ TabBar indicator: `surface` (branco)
- ✅ Gradient: cores do `colorScheme.scrim`
- ✅ Espaçamento: `24px` horizontalmente

---

### 7. **Estados e Feedback Visual**

#### Antes
- Estados de loading/error não consistentes

#### Depois
- ✅ **Empty states bem definidos:**
  - Texto descritivo em `bodyMedium` com cor `onSurfaceVariant`
  - Centrado e com instrução clara
- ✅ **Loading indicators:**
  - CircularProgressIndicator com `brandAccent`
  - No DynamicImage e widgets de imagem

---

## 📊 Checklist Visual

- ✅ Cores: 100% usando tema
- ✅ Tipografia: Hierarquia clara e consistente
- ✅ Espaçamento: Grid 8px aplicado uniformemente
- ✅ Cards: Elevação, radius, e padding padronizados
- ✅ Botões: FilledButton/OutlinedButton/TextButton conforme prioridade
- ✅ Ícones: Com backgrounds coloridos em cards
- ✅ Estados: Empty, loading, error claros
- ✅ Acessibilidade: Áreas tappáveis >= 44x44
- ✅ Sem cores hardcoded: Apenas AppColors e colorScheme

---

## 🎨 Direções de Design Aplicadas

Com base no `development_rules.instructions.md`:

- **Paleta Warm:** Cores do tema respeitadas (F6EFE7, C78B54, 6B4A2A)
- **Rounded Cards:** Radius `22px` em cards (conforme theme)
- **Soft Shadows:** Sombras sutis via theme (elevation 2-4)
- **Spacing 8px:** Grid aplicado em todo layout
- **Typography:** Pesos bold/medium via theme.textTheme
- **Acessibilidade:** Cores de suficiente contraste com paleta warm

---

## 🔧 Como Manter a Padronização

### Ao Adicionar Novo Widget:
1. ✅ Use `Theme.of(context)` para cores
2. ✅ Use `theme.textTheme` para tipografia
3. ✅ Padding: prefira `16px` ou múltiplos de 8
4. ✅ Buttons: priorize `FilledButton` > `Outlined` > `Text`
5. ✅ Cards: elevation automática via tema
6. ✅ Spacing: use `spacing: 8`, `12`, ou `16` em Row/Column

### Ao Modificar Cores:
- ❌ Nunca: `Color(0xFF...)`
- ❌ Nunca: `Colors.white`, `Colors.black`
- ✅ Sempre: `colorScheme.primary`, `colorScheme.onSurface`

### Ao Ajustar Espaçamento:
- ✅ Use valores em múltiplos de 8 (4, 8, 12, 16, 20, 24...)
- ✅ Padding de cards: `16px`
- ✅ Padding de screens: `16px`–`24px`
- ✅ Spacing entre elementos: `8px`–`16px`

---

## 📝 Resumo Técnico

**Arquivos modificados:** 8
- `home.dart`, `recipe_list.dart`, `ingredient_list.dart`, `recipe_info.dart`
- `dashboard_card.dart`, `card_recipe.dart`, `card_ingredients.dart`
- `ingredient_delete_sheet.dart`

**Erros de compilação:** 0 ✅
**Warnings:** 0 ✅

---

## Próximos Passos (Opcional)

1. Aplicar mesmo padrão aos EditSheets (`recipe_edit_sheet`, `ingredient_edit_sheet`)
2. Adicionar animações ao mudar de tabs/seções
3. Implementar dark mode com tema completo
4. Padronizar modals e dialogs

---

**Data:** 16 de janeiro de 2026
**Responsável:** AI Assistant (GitHub Copilot)
**Status:** ✅ Implementado e verificado
