import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import QtMultimedia

import "../components"

PageApp {
    property int objectsHeight: 50
    property int animationDuration: 200
    title: qsTr('Rádio Web UFPA')
    Row {
        id: barSoundRow
        property bool change: false
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height - logoRect.height
        spacing: 10
        Timer {
            id: timer
            interval: animationDuration
            repeat: true
            running: streamRadio.playbackState === MediaPlayer.PlayingState
                     && !busy.running && streamRadio.audioOutput.volume > 0
            onRunningChanged: if (!running)
                                  repeater.maxHeightBar = 0
            onTriggered: {
                barSoundRow.change = !barSoundRow.change
                repeater.maxHeightBar = barSoundRow.change ? parent.height
                                                             * 0.9 : parent.height * 0.7
            }
        }
        Repeater {
            id: repeater
            property int maxHeightBar: 0
            model: parent.width / 30
            delegate: Rectangle {
                id: element
                color: Material.accent
                width: 30
                height: repeater.maxHeightBar * Math.random()
                anchors.bottom: parent.bottom
                opacity: 0.1
                Behavior on height {
                    NumberAnimation {
                        duration: animationDuration
                    }
                }
            }
        }
        z: parent.z - 1
    }
    Column {
        anchors.fill: parent
        Item {
            id: logoRect
            width: parent.width
            height: columnLogo.height
            Column {
                id: columnLogo
                width: parent.width
                Image {
                    id: logoRadio
                    source: "qrc:/static/images/radio-logo.png"
                    fillMode: Image.PreserveAspectCrop
                    width: parent.width
                    height: 120
                }
                Row {
                    id: rowSocial
                    width: parent.width
                    Repeater {
                        model: ListModel {
                            id: socialListModel
                            ListElement {
                                name: "Rádio UFPA"
                                url: "http://radio.ufpa.br"
                                sourceIcon: "qrc:/static/icons/social/site.svg"
                            }
                            ListElement {
                                name: "Facebook"
                                url: "https://www.facebook.com/radiowebufpa"
                                sourceIcon: "qrc:/static/icons/social/facebook.svg"
                            }
                            ListElement {
                                name: "Twitter"
                                url: "https://twitter.com/radiowebufpa"
                                sourceIcon: "qrc:/static/icons/social/twitter.svg"
                            }
                            ListElement {
                                name: "Instagram"
                                url: "https://www.instagram.com/radiowebufpa/"
                                sourceIcon: "qrc:/static/icons/social/instagram.svg"
                            }
                            ListElement {
                                name: "Phone"
                                url: "tel:(91)3201-8814"
                                sourceIcon: "qrc:/static/icons/social/phone.svg"
                            }
                        }
                        delegate: ToolButton {
                            icon {
                                source: sourceIcon
                                height: 30
                                width: 30
                                color: Material.accent
                            }
                            padding: 16
                            onClicked: utils.openUrl(url, Material.primary)
                            width: parent.width / socialListModel.count
                        }
                    }
                }
            }
        }
        Row {
            height: parent.height - logoRect.height
            width: parent.width
            RoundButton {
                property bool active: streamRadio.playbackState === MediaPlayer.PlayingState
                id: buttonPlay
                anchors.verticalCenter: parent.verticalCenter
                x: parent.width / 4 - width / 2
                padding: 16
                icon {
                    source: !active ? "qrc:/static/icons/audio/play.svg" : "qrc:/static/icons/audio/pause.svg"
                }
                highlighted: true
                onClicked: {
                    if (active) {
                        streamRadio.pause()
                    } else {
                        streamRadio.play()
                    }
                }
            }
            RoundButton {
                property bool active: streamRadio.audioOutput.volume
                id: buttonSound
                x: parent.width / 4 * 3 - width / 2
                anchors.verticalCenter: parent.verticalCenter
                padding: 16
                icon {
                    source: active ? "qrc:/static/icons/audio/volume-up.svg" : "qrc:/static/icons/audio/mute.svg"
                }
                highlighted: true
                onClicked: {
                    streamRadio.audioOutput.volume = active ? 0 : 1
                }
            }
        }
    }
    Busy {
        id: busy
        running: streamRadio.mediaStatus === MediaPlayer.LoadingMedia
        anchors.centerIn: parent
    }
}
