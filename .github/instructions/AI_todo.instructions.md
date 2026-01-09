* [] em `lib/src/app/app_widget.dart` fazer a padronização do widget principal do aplicativo conforme as diretrizes de desenvolvimento do Reseller App. Seguindo as instruições presenstes nos comentarios do arquivo.

🎯 Objetivo do App

Auxiliar pequenos produtores de alimentos a:

Calcular o custo de produção (por receita e por produto unitário).

Equilibrar receitas conforme a quantidade desejada (ex.: 1 receita = 4 cucas → mas o usuário pode querer 6, 10, etc.).

Gerenciar diferentes produtos e suas variações (ex.: cuca de banana, cuca de chocolate, etc.).

Apoiar na precificação (considerando custos variáveis, fixos e margem de lucro).



Sugestões Profissionais de Refatoração
Analisando o arquivo ingredients.dart (250 linhas), identifico as seguintes melhorias:

🎯 Problemas Principais
Violação do Single Responsibility - A página contém 4 widgets diferentes
Widgets reutilizáveis misturados com a página - _TableTab, _TableHeader, _TableRow são componentes genéricos
Dados mockados hardcoded - Arrays de dados diretamente no build
TabBar específico misturado com lógica de página
✅ Refatoração Recomendada
1. Extrair widgets para arquivos separados ⭐ PRIORIDADE ALTA
Benefícios:

Reutilização em outras telas
Arquivo de página reduzido para ~80-100 linhas
Testabilidade individual dos componentes
Segue padrão já existente (você tem top_image.dart separado)
2. Criar models para dados tipados ⭐ PRIORIDADE ALTA
Benefícios:

Type safety em vez de List<dynamic>
Autocomplete e validação do compilador
Documentação implícita da estrutura
3. Mover dados mock para arquivo separado ⭐ PRIORIDADE MÉDIA
Benefícios:

Página focada apenas em UI
Facilita trocar por dados reais depois
Dados centralizados e reutilizáveis
4. Extrair constantes de estilo ⭐ PRIORIDADE BAIXA
Criar lib/src/modules/ingredients/presentation/styles/ingredients_styles.dart:

Cores (já tem AppColors, mas usa Color direto)
TextStyles reutilizáveis
Espaçamentos
📊 Estrutura Final Sugerida
🎯 Resultado Esperado
Antes: 250 linhas em 1 arquivo
Depois: ~80 linhas na página + 5 widgets reutilizáveis (30-50 linhas cada)

💡 Ordem de Implementação Recomendada
Criar models (rápido, alto impacto)
Extrair _TableRow e _TableHeader para widgets separados
Extrair _TableTab
Mover dados mock
Extrair TabBar customizado
Refatorar estilos (opcional)
Essas mudanças seguem os princípios do development_rules.instructions.md: widgets pequenos e composáveis, separação clara de responsabilidades, e arquitetura limpa (presentation → services → data).