# Reseller App 🍰

> Aplicativo Flutter para auxiliar pequenos produtores de alimentos no gerenciamento de receitas, ingredientes e cálculo de custos.

[![Flutter](https://img.shields.io/badge/Flutter-3.10.4+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.10.4+-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📱 Sobre o Projeto

O **Reseller App** é uma ferramenta desenvolvida para pequenos empreendedores do ramo alimentício que precisam:

- 📊 Calcular o custo de produção de receitas
- 🧮 Gerenciar ingredientes e seus custos
- 💰 Determinar preços de venda com base em custos reais
- 📈 Controlar a margem de lucro de cada produto

## ✨ Funcionalidades

### Implementadas ✅
- Gerenciamento de ingredientes (CRUD completo)
- Gerenciamento de receitas (CRUD completo)
- Cálculo automático de custo por unidade de ingrediente
- Cálculo de custo total por receita
- Dashboard com resumo de dados
- Interface com Material Design e paleta personalizada
- Suporte a imagens para receitas

### Em Desenvolvimento 🚧
- Persistência de dados (local database)
- Cálculo de markup e preço sugerido
- Escalabilidade de receitas (ajuste de quantidades)
- Exportação de dados (PDF, JSON)
- Custos fixos e variáveis

## 🏗️ Arquitetura

O projeto segue princípios de **Clean Architecture** com organização modular:

```
lib/
├── main.dart
└── src/
    ├── app/              # Configuração e roteamento
    ├── core/             # Recursos compartilhados (theme, constants)
    ├── modules/          # Features (home, ingredients, recipes)
    │   └── [feature]/
    │       ├── domain/           # Entidades e contratos
    │       ├── data/             # Implementação de repositórios
    │       └── presentation/     # UI (pages, widgets, providers)
    └── shared/           # Widgets compartilhados
```

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.10.4 ou superior
- Dart SDK 3.10.4 ou superior
- Android Studio / VS Code (recomendado)

### Instalação

```bash
# Clone o repositório
git clone https://github.com/FelipePaterni/reseller.git

# Entre no diretório
cd reseller

# Instale as dependências
flutter pub get

# Execute o app
flutter run
```

## 🧪 Testes

```bash
# Executar todos os testes
flutter test

# Executar análise de código
flutter analyze

# Formatar código
flutter format .
```

## 📦 Dependências Principais

- **provider** ^6.1.5 - Gerenciamento de estado
- **flutter_form_builder** ^10.2.0 - Construção de formulários
- **uuid** ^4.5.2 - Geração de IDs únicos
- **image_picker** ^1.0.7 - Seleção de imagens
- **flutter_slidable** ^4.0.3 - Ações deslizantes em listas

## 🎨 Design System

O app utiliza uma paleta de cores quente e acolhedora:

- **Background:** #F6EFE7 (creme suave)
- **Primary:** #C78B54 (terracota)
- **Text:** #6B4A2A (marrom escuro)

Seguindo grid de 8px e border radius de 22px para cards.

## 📄 Documentação

- [Análise Completa do Projeto](PROJECT_ANALYSIS.md)
- [Recomendações Rápidas](RECOMENDACOES_RAPIDAS.md)

## 🗺️ Roadmap

### Versão 0.2.0
- [ ] Implementar persistência com Hive
- [ ] Adicionar testes unitários
- [ ] Implementar tab Informações completa
- [ ] Validações robustas em formulários

### Versão 0.3.0
- [ ] Funcionalidade de escalabilidade de receitas
- [ ] Cálculo de markup e preço sugerido
- [ ] Exportação de receitas em PDF

### Versão 1.0.0
- [ ] Custos fixos e variáveis
- [ ] Análise de rentabilidade
- [ ] Backup na nuvem
- [ ] Internacionalização (PT-BR, EN, ES)

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona MinhaFeature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👤 Autor

**Felipe Paterni**

- GitHub: [@FelipePaterni](https://github.com/FelipePaterni)

## 🙏 Agradecimentos

- Comunidade Flutter/Dart
- Pequenos produtores que inspiraram este projeto

---

**Status:** Em Desenvolvimento | **Versão:** 0.1.0 | **Última Atualização:** Janeiro 2026
