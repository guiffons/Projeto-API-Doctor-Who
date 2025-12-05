# Doctor Who APP — Flutter App

Aplicativo mobile desenvolvido em **Flutter** para a disciplina de Mobile, usando **arquivos JSON locais** baseados na estrutura da *Doctor Who API* (PhoenixJaymes).  

O app permite explorar:

- As encarnações do **Doctor** (1 até 14, sem o Doctor da Guerra)  
- Alguns **vilões clássicos** da série (Daleks, Cybermen, Master, Weeping Angels, Beast, Toymaker, Sontarans etc.)  

Tudo isso em uma interface simples e totalmente **offline**.

---

## Funcionalidades do App

### Tela Inicial

A tela inicial mostra:

- Título do app  
- Botão **“Doctors”**  
- Botão **“Vilões”**  
- Botão **“Créditos da API”**

Ela é o ponto de partida da navegação. A partir dela o usuário escolhe se quer ver os Doctors, os vilões ou apenas os créditos.

---

### Tela de Doctors

- Lista em **grid** com todos os Doctors até o 14º (sem o Doctor da Guerra)  
- Cada card mostra:
  - Imagem do Doctor  
  - Nome (ex.: “10º Doctor”, “13º Doctor”)  

Ao tocar em um Doctor, o app abre a **tela de detalhes** com:

- Imagem maior  
- Nome  
- Texto descritivo (características da encarnação, personalidade etc.)  

No topo, há um **botão de voltar** padrão da AppBar, que retorna à lista.

---

### Tela de Vilões

Segue a mesma ideia da tela de Doctors, mas com vilões:

- Grid de vilões com:
  - Imagem  
  - Nome (ex.: “Daleks”, “Cybermen”, “The Master”, “Weeping Angels”, “The Beast”, “Toymaker”, “Sontarans” etc.)  

Ao tocar em um vilão, abre a tela de detalhes com:

- Imagem em destaque  
- Nome  
- Descrição/explicação do vilão  

Também com botão de voltar na AppBar.

---

### Tela de Créditos da API

Mostra:

- Espaço para a **logo da API** ou alguma imagem representando a fonte dos dados  
- Texto explicando que os JSON foram baseados na **Doctor Who API**  
- Link para a página da API  
- Pequena explicação de que o app foi desenvolvido para trabalho escolar, com foco em estudo de JSON, POO e Flutter

---

## Fluxo de Navegação

Representação simples de como o usuário circula pelo app:

    Tela Inicial
    │
    ├── Doctors Page
    │     └── Detalhes do Doctor
    │           └── Voltar
    │
    ├── Vilões Page
    │     └── Detalhes do Vilão
    │           └── Voltar
    │
    └── Créditos da API

---

## JSON e Organização dos Dados

O app usa **dois arquivos JSON locais**:

- `assets/doctors.json`  
- `assets/villains.json`  

Esses arquivos foram montados a partir da estrutura da Doctor Who API, mas adaptados para uso **offline**.

### Exemplo simplificado de um Doctor no JSON

    {
      "id": 10,
      "name": "10º Doctor",
      "info": "Encarnarção mais carismática e emotiva, marcada por frases icônicas e conflitos internos.",
      "img": "assets/imagens/doctor10.jpg"
    }

### Exemplo simplificado de um Vilão no JSON

    {
      "id": 1,
      "name": "Daleks",
      "info": "Os Daleks são um dos inimigos mais antigos do Doctor, obcecados por dominação e extermínio.",
      "img": "assets/imagens/daleks.jpg"
    }

> Observação: o campo `img` aponta para o caminho da imagem dentro da pasta de assets, como `assets/imagens/doctor1.jpg`, `assets/imagens/master.png`, etc.

---

## Como o App Lê o JSON (Lado Técnico)

Dentro do código (em `main.dart` ou em arquivos separados), existem funções que fazem:

1. Ler o arquivo JSON usando `rootBundle.loadString()`
2. Decodificar o JSON com `jsonDecode`
3. Transformar cada item em um **objeto Dart** da classe adequada

### Exemplo de fluxo para Doctors (conceito)

- Função `loadDoctors()`:
  - Carrega `assets/doctors.json`
  - Faz `jsonDecode`
  - Percorre a lista e chama `Doctor.fromJson()` para cada item
  - Retorna `List<Doctor>`

- Classe `Doctor` (modelo):
  - Possui atributos como `id`, `name`, `info`, `imageUrl`
  - Tem um `factory Doctor.fromJson(Map<String, dynamic> json)` que monta o objeto

O mesmo vale para `Villain` e `loadVillains()`.

Na interface, a tela de lista usa um `FutureBuilder<List<Doctor>>` / `FutureBuilder<List<Villain>>`:

- Enquanto carrega → mostra `CircularProgressIndicator`
- Se der erro → mostra mensagem de erro
- Se der certo → monta o `GridView.builder` com os cards

---

## Interface e Tema Visuais

O app usa:

- **Tema escuro (Dark Theme)**  
- Cores puxadas para:
  - Azul “TARDIS” (azul escuro vivo)
  - Fundos quase pretos para destacar as imagens
- Cards com cantos arredondados e leve sombra
- Textos **centralizados** nas telas de detalhes e na tela de créditos  
- Botões largos e com rótulos claros, para facilitar uso em celular

Os cards de Doctors e Vilões utilizam um widget reutilizável (por exemplo, `CharacterCard`) com:

- Imagem no topo  
- Nome embaixo, centralizado  
- Clique que abre a tela de detalhes correspondente  

---

## Estrutura Geral do Projeto (Resumo)

A estrutura pode variar um pouco, mas segue a ideia:

    doctor_who_app/
    │
    ├── assets/
    │   ├── doctors.json
    │   ├── villains.json
    │   └── imagens/
    │        ├── doctor1.jpg
    │        ├── doctor2.jpg
    │        ├── doctor3.png
    │        ├── daleks.jpg
    │        ├── cyberman.jpg
    │        ├── master.png
    │        ├── weeping_angels.jpg
    │        ├── beast.webp
    │        ├── toymaker.png
    │        ├── sontarans.jpg
    │        └── ...
    │
    ├── lib/
    │   └── main.dart      (código principal do app, telas, modelos e widgets)
    │
    └── pubspec.yaml       (configuração do Flutter e registro dos assets)

Neste projeto, para simplificar o trabalho escolar, grande parte da lógica e das telas pode estar concentrada em `main.dart`, mas a estrutura já foi pensada de forma que possa ser separada em arquivos no futuro (models, widgets, pages, etc.).

---

## Registro dos Assets (pubspec.yaml)

Para que as imagens e JSON funcionem, o `pubspec.yaml` precisa ter algo assim:

    flutter:
      uses-material-design: true

      assets:
        - assets/doctors.json
        - assets/villains.json
        - assets/imagens/

Isso permite ao Flutter carregar os arquivos JSON e as imagens dentro da pasta de assets.

---

## Referência da API Original

Os dados presentes em `doctors.json` e `villains.json` foram montados com base na estrutura da Doctor Who API:

- Documentação:  
  https://phoenixjaymes.com/lab/r-doctorwho-api/

No entanto, o app **não faz requisições HTTP**.  
Ele funciona totalmente **offline**, apenas usando arquivos JSON salvos localmente, o que facilita o uso em sala de aula e apresentações.

---

## Conceitos de POO Presentes

- **Classes**: `Doctor` e `Villain` representam entidades do domínio  
- **Objetos**: cada entrada do JSON vira um objeto real usado na interface  
- **Encapsulamento**: o tratamento dos dados é feito dentro das classes  
- **Reutilização de código**: mesmo widget de card para Doctors e Vilões  
- **Responsabilidade única**: funções separadas para carregar dados, montar telas e exibir detalhes

---

## Desenvolvedores

Projeto desenvolvido por:

- **Guilherme Fonseca da Silva**
- **Lucas Soares de Araujo**  

Curso: **Programação de Jogos Digitais — ETEC**  
Ano: **2025**  

---

## Finalidade

Este projeto foi desenvolvido **exclusivamente para fins educacionais**, como parte de um trabalho escolar, demonstrando:

- Flutter na prática  
- Leitura de JSON  
- Organização de app mobile  
- Documentação e uso de GitHub/Wiki em um projeto real.
