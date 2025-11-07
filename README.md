# Rick & Morty (Flutter • MVVM)

Aplicativo Flutter que consome a Rick and Morty API para listar personagens e exibir detalhes.

## Funcionalidades

* Lista de personagens com **nome** e **imagem**
* Tela de detalhes: **name**, **status**, **species**
* **Busca** por nome e **filtro** por status (Alive / Dead / Unknown)
* Paginação com botão **Carregar mais** + **Pull-to-refresh**
* **Tema claro/escuro** (toggle)
* **Splash screen** com fade e fundo preto

## Arquitetura (MVVM)

```
lib/
  assets/
    logoRM.jpg
  features/characters/
    data/
      api.dart
      repo.dart
    model/
      character.dart
    vm/
      view_model.dart
    view/
      page.dart
      details_page.dart
  splash/
    splash_screen.dart
  theme/
    theme.dart
    dark_theme.dart
  main.dart
```

Fluxo: **View ⇄ ViewModel ⇄ Repository ⇄ Api** (injeção via `provider`)

## Tecnologias

* Flutter (Material 3)
* provider (estado/DI)
* http (requisições)

## Como rodar

```bash
flutter clean
flutter pub get
flutter run
```
