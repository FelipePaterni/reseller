# Reseller

[README in English](/README.md)

> Aplicativo Flutter para auxiliar pequenos produtores de alimentos no gerenciamento de receitas, ingredientes e cálculo de custos.


[![Flutter](https://img.shields.io/badge/Flutter-3.10.4+-blue.svg?style=for-the-badge&logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.10.4+-blue.svg?style=for-the-badge&logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

## Sobre o Projeto
O **Reseller** é uma ferramenta desenvolvida para pequenos empreendedores do ramo alimentício que precisam:

* Calcular o custo de produção de receitas
* Gerenciar ingredientes e seus custos
* Determinar preços de venda com base em custos reais
* Controlar a margem de lucro de cada produto,

##  Funcionalidades
### Implementadas:
* Gerenciamento de ingredientes (CRUD completo)
* Gerenciamento de receitas (CRUD completo)
* Cálculo automático de custo por unidade de ingrediente
* Cálculo de custo total por receita
* Dashboard com resumo de dados
* Interface com Material Design e paleta personalizada
* Suporte a imagens para receitas
* Persistência de dados (local database)


### Em Desenvolvimento 
* Cálculo de markup e preço sugerido
* Escalabilidade de receitas (ajuste de quantidades)
* Custos fixos e variáveis

##  Arquitetura

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

## Como Executar

### Pré-requisitos
- Flutter SDK 3.10.4 ou superior
- Dart SDK 3.10.4 ou superior
- Android Studio / VS Code (recomendado)

### Installation

```bash
# Clone the repository
git clone https://github.com/FelipePaterni/reseller.git

# Entre no diretório
cd reseller

# Instale as dependências
flutter pub get

# Execute o app
flutter run
```
## Dependências Principais

- **provider** ^6.1.5 - State management
- **flutter_form_builder** ^10.2.0 - Form building
- **uuid** ^4.5.2 - Unique ID generation
- **image_picker** ^1.0.7 - Image selection
- **flutter_slidable** ^4.0.3 - Sliding list actions
- **lucid_validation** ^1.3.1 - Form validation
- **sqflite** ^2.4.2 - Local SQLite database
- **path** ^1.9.1 - File path manipulation
- **flutter_staggered_grid_view** ^0.7.0 - Grid layouts

##  Design System

O app utiliza uma paleta de cores quente e acolhedora:

- **Background:** #F6EFE7 (creme suave)
- **Primary:** #C78B54 (terracota)
- **Text:** #6B4A2A (marrom escuro)

Seguindo grid de 8px e border radius de 22px para cards.




## Contribuindo

Contribuições são bem-vindas! Por favor:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona MinhaFeature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

##  Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

##  Autor
**Felipe Paterni**
- GitHub: [@FelipePaterni](https://github.com/FelipePaterni)

---

**Status:** Em Desenvolvimento | **Versão:** 0.1.0 | **Última Atualização:** Janeiro 2026