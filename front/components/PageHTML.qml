import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "../js/config.js" as Cf
import "../js/rss.js" as RssJS

PageApp {
    property string title
    property variant paragraphs
    property string published
    property url linkNew
    property url urlImage: 'qrc:/static/images/ufpa-image.jpg'

    id: page
    toolButtonMenu: false

    Flickable {
        anchors.fill: page
        contentWidth: parent.width
        contentHeight: imageTitle.height + bodyPage.height
        maximumFlickVelocity: 5000
        boundsBehavior: Flickable.OvershootBounds
        RemoteImage {
            id: imageTitle
            width: parent.width
            height: 200
            source: urlImage
            sourceSize {
                width: parent.width > 800 ? 800 : 200
                height: parent.width > 800 ? 800 : 200
            }
            fillMode: Image.PreserveAspectCrop
            verticalAlignment: Image.AlignTop
            Rectangle {
                id: rect
                width: parent.width
                height: parent.height * 0.4
                anchors.bottom: parent.bottom
                opacity: 0.7
                color: Material.background
            }
            Label {
                anchors.fill: rect
                anchors.margins: 10
                text: title
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                color: Material.theme
                       === Material.Dark ? Material.primaryTextColor : Material.primary
                font {
                    bold: true
                    capitalization: Font.AllUppercase
                    pixelSize: 16
                }
            }
        }
        Column {
            id: bodyPage
            width: parent.width - padding * 2
            anchors.top: imageTitle.bottom
            padding: 20
            spacing: 10
            Text {
                color: Material.secondaryTextColor
                text: published
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                elide: Text.ElideRight
            }
            Repeater {
                model: paragraphs.concat(
                           'Abrir no site: ' + '<a href="' + linkNew + '">Link</a>')
                delegate: Text {
                    text: modelData
                    width: parent.width
                    wrapMode: Text.WordWrap
                    color: Material.primaryTextColor
                    linkColor: Material.theme
                               === Material.Dark ? Material.secondaryTextColor : Material.primary
                    horizontalAlignment: Text.AlignJustify
                    onLinkActivated: {
                        utils.openUrl(link, Material.primary)
                    }
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.NoButton
                        cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }
                }
            }
        }
    }
}
