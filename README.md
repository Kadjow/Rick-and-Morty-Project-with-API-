# 🧪 Rick & Morty — Flutter (MVVM)

Aplicativo desenvolvido em **Flutter** para consumir a **Rick and Morty API**, exibindo uma lista de personagens e seus detalhes, com foco em **boas práticas de arquitetura (MVVM)**, organização em camadas e uso de gerenciamento de estado reativo.

> Este repositório foi criado para treinar consumo de API, modelagem de dados e separação de responsabilidades em um app Flutter.

---

## 🎯 Objetivo do projeto

- Consumir a **Rick and Morty API** em Flutter;
- Listar personagens com informações básicas e foto;
- Exibir uma tela de detalhes com mais informações do personagem;
- Implementar uma arquitetura organizada em **camadas (MVVM)**;
- Praticar:
  - Criação de models;
  - Repositórios;
  - Integração com API REST;
  - Gerenciamento de estado com `provider`.

---

## ✨ Funcionalidades

- 📃 **Lista de personagens**  
  Lista de personagens com nome, imagem e status.

- 🔍 **Busca e filtros**  
  - Busca por nome;  
  - Filtro por status: `Alive`, `Dead` e `Unknown`.

- 🧾 **Tela de detalhes**  
  Exibe informações como:
  - Nome;
  - Status;
  - Espécie;
  - Outras propriedades relevantes do personagem.

- 🔄 **Paginação e atualização**  
  - Paginação de resultados;
  - Possibilidade de recarregar dados.

- 🌓 **Tema claro e escuro**  
  Suporte a tema claro/escuro configurado via tema do Flutter.

---

## 🧱 Arquitetura (MVVM)

O projeto segue o padrão **MVVM (Model–View–ViewModel)** com separação em camadas:

- **View**  
  Telas e widgets que exibem os dados (UI).

- **ViewModel**  
  Gerencia estado, regras de apresentação e orquestra chamadas para o repositório.

- **Repository**  
  Responsável por acessar a camada de dados (API), tratar respostas e retornar para o ViewModel.

- **Data / API**  
  Lida diretamente com as requisições HTTP para a Rick and Morty API.

Estrutura principal (resumida):

    lib/
      assets/
        logoRM.jpg

      features/
        characters/
          data/
            api.dart          # Cliente de acesso à API (requisições HTTP)
            repo.dart         # Implementação do repositório (camada de dados)
          model/
            character.dart    # Model/entidade de personagem
          vm/
            view_model.dart   # Lógica de estado, chamadas ao repositório
          view/
            page.dart         # Tela principal de listagem de personagens
            details_page.dart # Tela de detalhes do personagem

      splash/
        splash_screen.dart    # Tela inicial com animação

      theme/
        theme.dart            # Tema principal (light)
        dark_theme.dart       # Tema dark

      main.dart               # Ponto de entrada do app

Fluxo principal:

    View  ⇄  ViewModel  ⇄  Repository  ⇄  API

O `provider` é utilizado para injeção e gerenciamento de estado entre essas camadas.

---

## 🔌 API utilizada

O app consome a **Rick and Morty API**:

- Documentação: https://rickandmortyapi.com/documentation  
- Endpoints usados:
  - `/character` – listagem e filtros;
  - `/character/{id}` – detalhes de um personagem específico.

As requisições são feitas utilizando o pacote `http`, com models tipados para mapear as respostas JSON.

---

## 🧰 Tecnologias e pacotes

- **Flutter**
- **Dart**
- **provider** — gerenciamento de estado e injeção de dependências
- **http** — consumo da API REST
- Organização por **features** (ex.: `features/characters`)

---

## 🛠 Pré-requisitos

Antes de rodar o projeto, você precisa ter:

- **Flutter SDK** instalado e configurado;
- **Dart** (já incluso com o Flutter);
- Emulador Android/iOS ou dispositivo físico conectado.

Verifique seu ambiente com:

    flutter doctor

---

## 🚀 Como rodar o projeto

No diretório do projeto, execute:

    flutter clean
    flutter pub get
    flutter run

Você pode escolher o dispositivo/emulador na própria CLI ou via IDE (Android Studio, VS Code etc.).

---

## 📦 Estrutura geral do repositório

    Rick-and-Morty-Project-with-API-/
    ├── android/          # Configurações e código nativo Android
    ├── ios/              # Configurações e código nativo iOS
    ├── linux/            # Configurações para desktop (Linux)
    ├── macos/            # Configurações para desktop (macOS)
    ├── web/              # Configurações/Web runner
    ├── windows/          # Configurações para desktop (Windows)
    ├── lib/              # Código Dart principal do app (features, theme, splash)
    ├── test/             # Testes de unidade/widget
    ├── pubspec.yaml      # Dependências, assets e configurações do Flutter
    ├── analysis_options.yaml
    ├── .gitignore
    └── README.md

---

## 🧪 Testes

Os testes (quando configurados) ficam em `test/`, seguindo o padrão do Flutter.

Para rodar os testes:

    flutter test

---

## 📌 Sobre o projeto

Este projeto foi criado com o propósito de:

- Explorar consumo de APIs em Flutter;
- Praticar arquitetura **MVVM**;
- Treinar organização por **features** e camadas (data, model, view, viewmodel);
- Servir como referência/estudo para projetos futuros que consumam APIs externas.

---

## 👨‍💻 Autor

**Diogo Arthur Gulhak**  

Desenvolvedor de Software focado em **Flutter/Dart**, arquitetura limpa e desenvolvimento mobile.

- GitHub: [@Kadjow](https://github.com/Kadjow)
- LinkedIn: [Diogo Arthur Gulhak](https://www.linkedin.com/in/diogo-arthur-gulhak-0bbaa0273/)
