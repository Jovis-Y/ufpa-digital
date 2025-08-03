import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "../components"

PageApp {
    title: qsTr('Configurações')
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
        }
    }
}
