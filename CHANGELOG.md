# CHANGELOG

## vCurrent

## v3.1

* BUGFIX: Correção da apresentação incorreta do prato principal na seção RU da Home #15;
* BUGFIX: Remoção do resultado padrão "Universidade Federal do Pará" nas buscas no mapa #12;
* BUGFIX: Corrige o link para o cardápio do RU #17.

## v3.0

* Suporte ao iOS;
* Disponibilizado modo "totem";
* Refatoração do projeto com divisão de arquivos entre "backend" e "frontend";
* Adição de integração contínua para versões desktop e android via [Gitlab CI](https://gitlab.com/ccsl-ufpa/ufpa-digital/-/blob/master/.gitlab-ci.yml);
* Reimplementação do backend do módulo do RU, agora usando um JSON provido pela SAEST;
* Apresentação do número do mês no cardápio do RU;
* Atualização dos valores do tíquete do RU :( ;
* Buscas no mapa atualizadas para a Overpass API v0.7.57;
* Stream da rádio migrado para o codec MP3;
* Modificações no logo da aplicação, agora gerados por [AppIcon.build](https://www.appicon.build/);
* Adição de Vinícius Botelho como desenvolvedor da aplicação.

## v2.0

* Port para Qt 5.14;
* Disponibilizada versão para Android;
* Port da interface para Material Design;
* Adição de splash screen;
* Adoção do "logo" do projeto;
* Adição do modo noturno;
* Adição de módulo para configuração;
* Remodelagem do módulo Sobre;
* Melhor disposição das informações do RU;
* Projeto movido para [ccsl-ufpa/ufpa-digital](https://gitlab.com/ccsl-ufpa/ufpa-digital);
* Remoção das menções à "ufpa-mobile".

## v1.0

* Estabilização da plataforma;
* Módulos de notícias e oportunidades (utilizando processamento de XML);
* Módulos de acesso ao SIGAA e Pergamum (utilizando webview);
* Módulo do cardápio do RU (utilizando processamento JSON e dados providos pelo [Appetit](http://appetitews.herokuapp.com/));
* Mapa com vários filtros e buscas no campus do Guamá;
* Acompanhamento do ônibus Circular (dados da localização do ônibus providos pelo projeto [Circular](https://circular.lasseufpa.org/) do [LASSE](https://www.lasse.ufpa.br/));
* Módulo para ouvir a [Rádio Web UFPA](http://radio.ufpa.br/);
* Lista de contatos telefônicos, e-mails e site de pró-reitorias, núcleos e institutos da universidade;
* Adoção da licença GPLv3.
