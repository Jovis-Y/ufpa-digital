import QtQuick
import QtQuick.Controls

ToolBar {
    property alias title: labelName.text
    property alias toolButtonMenu: buttonLeft.toolButtonMenu

    id: toolBarAPP
    height: 60

    contentItem: Row {
        anchors.fill: parent
        anchors.margins: 5
        ToolButton {
            property bool toolButtonMenu
            property string iconName: toolButtonMenu ? 'menu' : 'back'
            id: buttonLeft
            icon.source: 'qrc:/static/icons/' + iconName + '.svg'
            height: parent.height
            onClicked: {
                if (toolButtonMenu) {
                    drawer.open()
                } else {
                    stackView.pop()
                }
            }
        }
        Label {
            id: labelName
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            width: parent.width - (buttonLeft.width + buttonRigth.width)
            height: parent.height
            font.bold: true
            elide: Text.ElideRight
        }
        ToolButton {
            id: buttonRigth
            height: parent.height
            width: height
            visible: false


            /*background: Rectangle {
                anchors.fill: buttonRigth
                visible: streamRadio.playbackState === Audio.PlayingState
                         && streamRadio.status !== Audio.Loading
                color: "transparent"
                clip: true
                Timer {
                    id: timer
                    interval: 200
                    repeat: true
                    running: parent.visible
                    onTriggered: {
                        rowBar.height = rowBar.height !== parent.height
                                * 0.6 ? parent.height * 0.6 : parent.height * 0.4
                    }
                }
                Row {
                    id: rowBar
                    anchors.fill: parent
                    anchors.margins: 5
                    anchors.bottomMargin: 10
                    spacing: 3
                    Repeater {
                        model: 3
                        width: parent.width
                        height: parent.height
                        delegate: Rectangle {
                            id: element
                            color: "white"
                            width: rowBar.width / 3 - 3
                            height: rowBar.height * Math.random()
                            anchors.bottom: parent.bottom
                            Behavior on height {
                                NumberAnimation {
                                    duration: 200
                                }
                            }
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (title !== qsTr("Rádio Web UFPA")) {
                            stackView.pop(null)
                            stackView.push("qrc:/front/pages/Radio.qml", {
                                               "title": qsTr("Rádio Web UFPA")
                                           })
                        }
                    }
                }
            }*/
        }
    }
}
