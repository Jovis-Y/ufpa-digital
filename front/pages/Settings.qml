import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import "../js/config.js" as Cf

import "../components"

PageApp {
    title: qsTr("Configurações")

    Flickable {
        id: flickable
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        contentHeight: column.height
        maximumFlickVelocity: 5000
        boundsBehavior: Flickable.OvershootBounds

        Column {
            id: column
            width: parent.width
            spacing: 2

            Panel {
                headerText: qsTr("Interface")
                width: parent.width
                Row {
                    width: parent.width
                    SwitchDelegate {
                        width: parent.width
                        icon {
                            source: "qrc:/static/icons/dark-mode.svg"
                            color: Material.accent
                        }
                        text: qsTr("Modo Noturno")
                        checked: settingsMaterial.style === Material.Dark
                        onCheckedChanged: {
                            settingsMaterial.style = checked ? Material.Dark : Material.Light
                        }
                    }
                }
            }

            Panel {
                headerText: qsTr("Campus")
                width: parent.width

                RowLayout {
                    width: parent.width
                    anchors.margins: 10

                    Label {
                        text: qsTr("Selecionar campus:")
                        Layout.alignment: Qt.AlignLeft
                    }

                    Item { Layout.fillWidth: true }

                    Row {
                        spacing: 8
                        ComboBox {
                            id: campusSelector
                            model: [
                                "Belém",
                                "Altamira",
                                "Ananindeua",
                                "Abaetetuba",
                                "Bragança",
                                "Capanema",
                                "Castanhal",
                                "Salinópolis",
                                "Soure",
                                "Tucuruí",
                                "Cametá"
                            ]
                            currentIndex: model.indexOf(application.campusSelecionado)
                            Layout.alignment: Qt.AlignRight
                            onCurrentTextChanged: {
                                if (typeof application !== 'undefined') {
                                    application.campusSelecionado = currentText
                                }
                                console.log("Campus selecionado:", currentText)
                            }
                        }
                    }
                }
            }
        }
    }
}
