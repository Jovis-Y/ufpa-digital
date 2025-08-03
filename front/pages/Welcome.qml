import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Controls.Material

import Utils 1.0

import "../js/config.js" as Cf
import "../components"
import "../models"

Page {
    property PageApp currentItem

    id: root
    visible: true

    header: ToolBarAPP {
        id: toolBar
        Material.foreground: "white"
        title: root.currentItem ? root.currentItem.title : ""
        toolButtonMenu: root.currentItem ? root.currentItem.toolButtonMenu : true
    }
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: PageApp {}
        onCurrentItemChanged: {
            root.currentItem = currentItem
        }
    }
    Shortcut {
        id: shortcutGlobal
        sequences: ["Esc", "Back"]
        onActivated: {
            if (stackView.depth === 1) {
                Qt.quit()
            } else {
                stackView.pop()
            }
        }
    }
    Drawer {
        id: drawer
        width: ((parent.width < 600) ? parent.width : 600) * 0.8
        height: parent.height
        dragMargin: Qt.styleHints.startDragDistance * 1.8
        ListView {
            property int initialIndex: 0
            id: listView
            anchors.fill: parent
            boundsBehavior: Flickable.OvershootBounds
            currentIndex: initialIndex
            clip: true
            headerPositioning: ListView.OverlayHeader
            header: Item {
                height: 100
                width: parent.width
                BackgroundAPP {
                    anchors.fill: parent
                }
                Row {
                    anchors.fill: parent
                    anchors.margins: 10
                    Image {
                        height: parent.height
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
            Material.foreground: isDarkMode ? Material.color(
                                                  Material.Grey,
                                                  Material.Shade300) : Material.color(
                                                  Material.Grey,
                                                  Material.Shade700)
            model: ModulesListModel {
                id: allModels
                Component.onCompleted: {
                    if (filterModules) {
                        var all = filterModules.split("=")[1].split(",")
                        for (var i = 0; i < count; i++) {
                            var module = allModels.get(i)
                            if (!all.includes(module.nameId)) {
                                allModels.remove(i)
                                i--
                            }
                        }
                    }
                    if (allModels.count) {
                        stackView.clear()
                        stackView.push(allModels.get(
                                           listView.initialIndex).source)
                    }
                }
            }
            delegate: ItemDelegate {
                property bool isSelected: currentItem && model.title === currentItem.title
                z: parent ? parent.z - 1 : 0
                Material.foreground: isSelected ? Material.accent : isDarkMode ? Material.color(Material.Grey, Material.Shade300) : Material.color(Material.Grey, Material.Shade700)
                width: parent ? parent.width : 0
                text: model.title
                icon.source: model.sourceIcon
                highlighted: isSelected

                onClicked: {
                    if (!isSelected) {
                        stackView.pop(null, StackView.PushTransition)
                        if (model.index !== listView.initialIndex)
                            stackView.push(model.source, {
                                               "title": model.title
                                           })
                    }
                    drawer.close()
                }
            }
        }
    }
    MediaPlayer {
        id: streamRadio
        audioOutput: AudioOutput {}
        source: Cf.urlStreamRadioWebUFPA
        onErrorChanged: {
            if (toolBar.title === qsTr('Rádio Web UFPA')) {
                var errors = {}
                errors[MediaPlayer.NoError] = qsTr("Mídia carregada com sucesso")
                errors[MediaPlayer.NetworkError] = qsTr("Erro de conexão")
                errors[MediaPlayer.AccessError] = qsTr("Permissões insuficientes")

                if ([MediaPlayer.NoError, MediaPlayer.NetworkError, MediaPlayer.AccessError].includes(
                            error)) {
                    toolTip.show(errors[error])
                } else {
                    toolTip.show(qsTr("Erro desconhecido"))
                }
            }
        }
    }
    Utils {
        id: utils
    }
    ToolTip {
        id: toolTip
        x: parent.width / 2 - width / 2
        y: parent.height - height * 2
        timeout: 1500
        delay: 500
        font.pixelSize: 12
        background: Rectangle {
            radius: 10
            color: "black"
            opacity: 0.6
        }
    }
    Loader {
        active: !!totemEnable
        anchors.fill: parent
        source: "qrc:/components/VirtualKeyboard.qml"
    }
}
