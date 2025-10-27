<h1 align="center"> Doctor Who App</h1>

<p align="center">
Aplicativo Android baseado na <strong>Doctor Who API</strong>, criado como projeto escolar para demonstrar o uso de APIs, orientação a objetos e organização modular.  
</p>

---

## Integrantes
- **Guilherme Fonseca da Silva**
- **Lucas Soares de Araujo**

---

## Descrição do Projeto

O **Doctor Who App** é uma aplicação mobile desenvolvida para Android que consome dados da **Doctor Who API**, permitindo que o usuário explore informações sobre os diferentes **Doutores**, seus **companheiros** e **vilões icônicos** da série.

A proposta do aplicativo é apresentar conteúdo dinâmico obtido em tempo real a partir da API, garantindo uma navegação fluida e interativa.  
Cada elemento exibido é proveniente de **objetos instanciados** a partir de classes específicas.

---

## Funcionalidades Principais

- **Tela Inicial:** acesso direto às seções *Doctors*, *Vilões* e *Créditos da API*.  
- **Tela de Doctors:** exibição das 14 encarnações do Doutor, com detalhes sobre ator, características e companheiros.  
- **Tela de Vilões:** galeria com os principais vilões da série, incluindo nome, imagem e descrição.  
- **Tela de Créditos:** informações técnicas sobre a API e o projeto.  
- **Widgets:** Scrollbar, botões de navegação e estrutura responsiva para Android.  

---

## Tecnologias Utilizadas

| Categoria | Ferramenta |
|------------|-------------|
| API REST | [Doctor Who API](https://phoenixjaymes.com/lab/r-doctorwho-api/) |
| Prototipagem | Figma |
| Versionamento | Git + GitHub |
| Organização | GitHub Wiki e Markdown |

---

## Estrutura da Wiki

A documentação detalhada do projeto está disponível na **Wiki** deste repositório.

### Acesse os tópicos:

- [ 1. Protótipo e Mapa de Navegação](../../wiki/Protótipo-e-Mapa-de-Navegação)  
- [ 2. Descrição Detalhada da Aplicação](../../wiki/Descrição-Detalhada-da-Aplicação)  
- [ 3. Análise da API](../../wiki/Análise-da-API)  
- [ 4. Estrutura Técnica do Projeto](../../wiki/Estrutura-Técnica-do-Projeto)  
- [ 5. Créditos e Referências](../../wiki/Créditos-e-Referências)

---

##  Prévia do Protótipo

<p align="center">
📎 <a href="https://www.figma.com/design/UYxNbmeVGet1iz3hLYcq04/Sem-t%C3%ADtulo?node-id=6-143&p=f&t=8Qq7N2UHstGLYOHi-0">Ver no Figma</a>  
</p>

---

##  Organização do Repositório (Prototipo)

```bash
doctorwho-app/
│
├── README.md
├── /src
│   ├── /pages
│   │   ├── home_page.dart
│   │   ├── doctors_page.dart
│   │   ├── viloes_page.dart
│   │   ├── detalhes_page.dart
│   │   └── creditos_page.dart
│   ├── /modelos
│   │   ├── doctors.dart
│   │   ├── viloes.dart
│   │   └── api_info.dart
│   └── /services
│       └── api_service.dart
└── /docs
    ├── prototipo.png
    └── mapa-navegacao.png
