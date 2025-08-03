import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "../components"
import "../js/config.js" as Cf

Item {
    property string titleComponent
    property ListModel modelElementsCollapse
    property int animationDurantion: 500

    id: rectHeader

    height: panel.height

    ToolButton {
        id: button
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 20
        icon {
            source: "qrc:/static/icons/arrow.svg"
            color: !isDarkMode ? Material.primaryHighlightedTextColor : Material.accent
        }
        height: 30
        width: 30
        Behavior on rotation {
            RotationAnimation {
                duration: animationDurantion
            }
        }
        onClicked: {
            rotation += 180
            rectangleCollapse.hidden = !rectangleCollapse.hidden
        }
        z: panel.z + 1
    }
    Panel {
        id: panel
        headerText: titleComponent
        width: parent.width
        Item {
            property bool hidden: true
            id: rectangleCollapse
            width: parent.width
            height: hidden ? 0 : columnElements.height
            clip: true
            Behavior on height {
                NumberAnimation {
                    duration: animationDurantion
                }
            }
            Column {
                id: columnElements
                width: parent.width
                spacing: 2
                Repeater {
                    id: elementsCollapse
                    model: modelElementsCollapse
                    delegate: Row {
                        property int toolButtonWidth: (width - labelName.width) / 3

                        id: rowElements
                        width: parent.width
                        ToolButton {
                            id: labelName
                            width: parent.width * 0.4
                            Label {
                                anchors.fill: parent
                                anchors.margins: 2
                                text: "<b>" + name + "</b> - " + complement
                                color: Material.primaryTextColor
                                elide: Label.ElideRight
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                            }
                            enabled: false
                        }
                        ToolButton {
                            width: rowElements.toolButtonWidth
                            highlighted: true
                            icon {
                                source: "qrc:/static/icons/phone.svg"
                                height: parent.height / 2
                                width: parent.height / 2
                            }
                            onClicked: {
                                if (phone) {
                                    utils.openUrl("tel:" + phone,
                                                  Material.primary)
                                } else {
                                    toolTip.show(qsTr("Telefone não fornecido"))
                                }
                            }
                        }
                        ToolButton {
                            width: rowElements.toolButtonWidth
                            highlighted: true
                            icon {
                                source: "qrc:/static/icons/email.svg"
                                height: parent.height / 2
                                width: parent.height / 2
                            }
                            onClicked: {
                                if (email) {
                                    utils.openUrl("mailto:" + email,
                                                  Material.primary)
                                } else {
                                    toolTip.show(qsTr("E-mail não fornecido"))
                                }
                            }
                        }
                        ToolButton {
                            width: rowElements.toolButtonWidth
                            highlighted: true
                            icon {
                                source: "qrc:/static/icons/site.svg"
                                height: parent.height / 2
                                width: parent.height / 2
                            }
                            onClicked: {
                                if (site) {
                                    utils.openUrl(site, Material.primary)
                                } else {
                                    toolTip.show(qsTr("Site não fornecido"))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
