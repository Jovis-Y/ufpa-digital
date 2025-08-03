import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../components"

PageApp {
    title: qsTr('Sobre')
    Flickable {
        id: flickable
        height: parent.height - tabBar.height - 10
        width: parent.width
        contentHeight: column.height
        maximumFlickVelocity: 5000
        boundsBehavior: Flickable.OvershootBounds
        Column {
            id: column
            width: parent.width
            spacing: 20
            Item {
                height: 100
                width: parent.width
                BackgroundAPP {
                    id: backgroundPanel
                    anchors.fill: parent

                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: 100
                        anchors.margins: 10
                        Image {
                            height: parent.height - 10
                            fillMode: Image.PreserveAspectFit
                            source: 'qrc:/static/images/logo-ufpa-white.svg'
                            sourceSize.width: 79
                            sourceSize.height: 100
                            smooth: true
                        }
                        Label {
                            color: 'white'
                            text: qsTr('<b>UFPA</b>' + ' ' + 'Digital')
                            font.pixelSize: parent.height / 3
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
            StackLayout {
                id: stackLayout
                currentIndex: tabBar.currentIndex
                height: project.visible ? project.height : software.height
                width: parent.width
                Column {
                    id: project
                    width: parent.width
                    spacing: 20
                    Panel {
                        headerText: qsTr("Projeto")
                        width: parent.width
                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.7
                            text: qsTr(
                                      "<br><b>UFPA Digital</b>" + "<br>Aplicativo Multiplataforma para Centralização de Informações da Universidade Federal do Pará"
                                      + "<br><br><b>Versão: </b>" + Qt.application.version)
                            horizontalAlignment: Label.AlignHCenter
                            wrapMode: Label.Wrap
                            onLinkActivated: utils.openUrl(link,
                                                           Material.primary)
                            linkColor: Material.secondaryTextColor
                        }
                        Column {
                            width: parent.width
                            Label {
                                x: parent.width / 2 - width / 2
                                text: "<br><b>Colaborações e Licença (GPLv3)</b>"
                                horizontalAlignment: Label.AlignHCenter
                            }
                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                ToolButton {
                                    icon {
                                        source: "qrc:/static/icons/social/gitlab.svg"
                                        height: 30
                                        width: 30
                                        color: Material.accent
                                    }
                                    padding: 16
                                    onClicked: utils.openUrl(
                                                   "https://gitlab.com/ccsl-ufpa/ufpa-digital",
                                                   Material.primary)
                                }
                                ToolButton {
                                    icon {
                                        source: "qrc:/static/icons/balance.svg"
                                        height: 30
                                        width: 30
                                        color: Material.accent
                                    }
                                    padding: 16
                                    onClicked: utils.openUrl(
                                                   "https://www.gnu.org/licenses/gpl-3.0.txt",
                                                   Material.primary)
                                }
                            }
                        }
                    }
                    Panel {
                        headerText: qsTr("Desenvolvedores")
                        width: parent.width

                        Image {
                            id: ccslLogo
                            source: "qrc:/static/images/logo-ccsl.svg"
                            fillMode: Image.PreserveAspectFit
                            sourceSize.width: 79
                            sourceSize.height: 120
                            smooth: true
                            x: parent.width / 2 - width / 2
                            horizontalAlignment: Image.AlignHCenter
                        }

                        Column {
                            width: parent.width
                            Label {
                                x: parent.width / 2 - width / 2
                                text: "<br><b>UFPA Digital</b> é um projeto do <b>Centro de Competência em Software Livre da UFPA</b>"
                                width: parent.width * 0.7
                                horizontalAlignment: Label.AlignHCenter
                                wrapMode: Label.Wrap
                                onLinkActivated: utils.openUrl(link,
                                                               Material.primary)
                                linkColor: Material.secondaryTextColor
                            }
                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                ToolButton {
                                    icon {
                                        source: "qrc:/static/icons/social/site.svg"
                                        height: 30
                                        width: 30
                                        color: Material.accent
                                    }
                                    padding: 16
                                    onClicked: utils.openUrl(
                                                   "http://ccsl.ufpa.br",
                                                   Material.primary)
                                }
                                ToolButton {
                                    icon {
                                        source: "qrc:/static/icons/social/gitlab.svg"
                                        height: 30
                                        width: 30
                                        color: Material.accent
                                    }
                                    padding: 16
                                    onClicked: utils.openUrl(
                                                   "https://gitlab.com/ccsl-ufpa",
                                                   Material.primary)
                                }
                            }
                        }
                        Repeater {
                            model: ListModel {
                                ListElement {
                                    title: qsTr("Desenvolvedor")
                                    name: qsTr("Vinícius Botelho")
                                    contacts: [
                                        ListElement {
                                            url: "https://gitlab.com/viniciusdev-br"
                                            sourceIcon: "qrc:/static/icons/social/gitlab.svg"
                                        },
                                        ListElement {
                                            url: "https://github.com/viniciusdev-br/"
                                            sourceIcon: "qrc:/static/icons/social/github.svg"
                                        },
                                        ListElement {
                                            url: "https://www.linkedin.com/in/vinicius-botelho-15716218b"
                                            sourceIcon: "qrc:/static/icons/social/linkedin.svg"
                                        },
                                        ListElement {
                                            url: "mailto:viniciusdev.br@gmail.com"
                                            sourceIcon: "qrc:/static/icons/social/email.svg"
                                        }
                                    ]
                                }
                                ListElement {
                                    title: qsTr("Desenvolvedor Original")
                                    name: qsTr("Lucas Gabriel de Souza<br>@souzaluuk")
                                    contacts: [
                                        ListElement {
                                            url: "https://gitlab.com/souzaluuk"
                                            sourceIcon: "qrc:/static/icons/social/gitlab.svg"
                                        },
                                        ListElement {
                                            url: "https://github.com/souzaluuk/"
                                            sourceIcon: "qrc:/static/icons/social/github.svg"
                                        },
                                        ListElement {
                                            url: "https://www.linkedin.com/in/souzaluuk"
                                            sourceIcon: "qrc:/static/icons/social/linkedin.svg"
                                        },
                                        ListElement {
                                            url: "mailto:lucassouzaufpa@gmail.com"
                                            sourceIcon: "qrc:/static/icons/social/email.svg"
                                        }
                                    ]
                                }
                                ListElement {
                                    title: qsTr("Orientador")
                                    name: qsTr("Filipe Saraiva")
                                    contacts: [
                                        ListElement {
                                            url: "http://filipesaraiva.info"
                                            sourceIcon: "qrc:/static/icons/social/site.svg"
                                        },
                                        ListElement {
                                            url: "https://gitlab.com/filipesaraiva"
                                            sourceIcon: "qrc:/static/icons/social/gitlab.svg"
                                        },
                                        ListElement {
                                            url: "mailto:saraiva@ufpa.br"
                                            sourceIcon: "qrc:/static/icons/social/email.svg"
                                        }
                                    ]
                                }
                            }
                            delegate: Column {
                                width: parent.width
                                Label {
                                    x: parent.width / 2 - width / 2
                                    text: "<b>" + name + "</b><br>" + title
                                    horizontalAlignment: Label.AlignHCenter
                                }
                                Row {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    Repeater {
                                        id: repeaterSocial
                                        model: contacts
                                        delegate: ToolButton {
                                            icon {
                                                source: sourceIcon
                                                height: 30
                                                width: 30
                                                color: Material.accent
                                            }
                                            padding: 16
                                            onClicked: utils.openUrl(
                                                           url,
                                                           Material.primary)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Column {
                    id: software
                    width: parent.width
                    spacing: 20
                    Panel {
                        headerText: qsTr("Base do Software")
                        width: parent.width
                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.7
                            text: qsTr(
                                      "<br><b>Qt/QML</b>" + "<br>Qt é um framework multiplataforma enquanto " + "QML é uma linguagem de desenvolvimento de interfaces disponível com o Qt"
                                      + "<br> UFPA Digital utiliza a versão GPLv3 do Qt")
                            horizontalAlignment: Label.AlignHCenter
                            wrapMode: Label.Wrap
                            onLinkActivated: utils.openUrl(link,
                                                           Material.primary)
                            linkColor: Material.secondaryTextColor
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/social/site.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl("https://qt.io",
                                                         Material.primary)
                            }
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/balance.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://www.gnu.org/licenses/gpl-3.0.txt",
                                               Material.primary)
                            }
                        }
                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.7
                            text: qsTr("<br><b>Font Awesome</b>" + "<br>Font Awesome disponibiliza vários ícones vetoriais para aplicações sob a licença CC BY 4.0")
                            horizontalAlignment: Label.AlignHCenter
                            wrapMode: Label.Wrap
                            onLinkActivated: utils.openUrl(link,
                                                           Material.primary)
                            linkColor: Material.secondaryTextColor
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/social/site.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://fontawesome.com/",
                                               Material.primary)
                            }
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/balance.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://creativecommons.org/licenses/by/4.0/",
                                               Material.primary)
                            }
                        }
                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.7
                            text: qsTr("<br><b>Material Design</b>" + "<br>Conjunto de componentes de interface independentes de plataforma")
                            horizontalAlignment: Label.AlignHCenter
                            wrapMode: Label.Wrap
                            onLinkActivated: utils.openUrl(link,
                                                           Material.primary)
                            linkColor: Material.secondaryTextColor
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/social/site.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://material.io/",
                                               Material.primary)
                            }
                        }
                    }
                    Panel {
                        headerText: qsTr("Mapa")
                        width: parent.width
                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.7
                            text: qsTr(
                                      "<br><b>OpenStreetMap</b>"
                                      + "<br>Projeto comunitário de mapeamento colaborativo "
                                      + "disponibilizando os dados para ampla utilização sob a licença ODbL e os mapas em CC BY SA")
                            horizontalAlignment: Label.AlignHCenter
                            wrapMode: Label.Wrap
                            onLinkActivated: utils.openUrl(link,
                                                           Material.primary)
                            linkColor: Material.secondaryTextColor
                        }
                        Label {
                            x: parent.width / 2 - width / 2
                            text: "<br><b>© contribuidores do OpenStreetMap</b><br>Mapeadores"
                            horizontalAlignment: Label.AlignHCenter
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/social/site.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://www.openstreetmap.org/",
                                               Material.primary)
                            }
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/balance.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://www.openstreetmap.org/copyright",
                                               Material.primary)
                            }
                        }
                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.7
                            text: qsTr(
                                      "<br><b>Overpass API</b>"
                                      + "<br>Conjunto de APIs e servidores que simplificam buscas "
                                      + "nos dados do OpenStreetMap<br>Disponível sob licença AGPLv3")
                            horizontalAlignment: Label.AlignHCenter
                            wrapMode: Label.Wrap
                            onLinkActivated: utils.openUrl(link,
                                                           Material.primary)
                            linkColor: Material.secondaryTextColor
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/social/site.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "http://overpass-api.de/",
                                               Material.primary)
                            }
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/social/github.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://github.com/drolbr/Overpass-API/",
                                               Material.primary)
                            }
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/balance.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://www.gnu.org/licenses/agpl-3.0.txt",
                                               Material.primary)
                            }
                        }
                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.7
                            text: qsTr("<br><b>Circular UFPA</b>" + "<br>Desenvolvido pelo Núcleo de Pesquisa e Desenvolvimento em Telecomunicações, Automação " + "e Eletrônica (LASSE), o projeto monitora o percurso do ônibus Circular no campus da UFPA - Guamá")
                            horizontalAlignment: Label.AlignHCenter
                            wrapMode: Label.Wrap
                            onLinkActivated: utils.openUrl(link,
                                                           Material.primary)
                            linkColor: Material.secondaryTextColor
                        }
                        Label {
                            x: parent.width / 2 - width / 2
                            text: "<br><b>Felipe Bastos<br>Lucas Borges<br>Izídio Carvalho<br>Camila Novaes<br>" + "Gabriel Couto<br>Moacir Brito<br>Virgínia Tavares<br>Carlos Dias<br>" + "Yuri Silva<br>Lucas Shibata<br>Lucas Conde</b><br>Desenvolvedores"
                                  + "<br><br><b>Aldebaro Klautau</b><br>Orientador"
                            horizontalAlignment: Label.AlignHCenter
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/social/site.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://www.lasse.ufpa.br/",
                                               Material.primary)
                            }
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/bus.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://circular.lasseufpa.org/",
                                               Material.primary)
                            }
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/social/github.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://github.com/lasseufpa/circular",
                                               Material.primary)
                            }
                            ToolButton {
                                icon {
                                    source: "qrc:/static/icons/balance.svg"
                                    height: 30
                                    width: 30
                                    color: Material.accent
                                }
                                padding: 16
                                onClicked: utils.openUrl(
                                               "https://peti.lasseufpa.org/2018/01/04/termo-de-uso-dos-dados-de-localizacao-do-projeto-circular-ufpa/",
                                               Material.primary)
                            }
                        }
                    }
                }
            }
        }
        ScrollIndicator.vertical: ScrollIndicator {}
    }
    TabBar {
        id: tabBar
        position: TabBar.Footer
        anchors.bottom: parent.bottom
        width: parent.width
        Material.elevation: 6
        Repeater {
            model: ListModel {
                ListElement {
                    title: qsTr("Sobre o Projeto")
                }
                ListElement {
                    title: qsTr("Softwares Integrados")
                }
            }
            delegate: TabButton {
                id: control
                text: title
                font.bold: true
            }
        }
    }
}
