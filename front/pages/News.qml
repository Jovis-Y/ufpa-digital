import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQml.XmlListModel

import "../models"
import "../components"
import "../js/config.js" as Cf
import "../js/rss.js" as RssJS

PageApp {
    function load() {
        if (flickable.atYEnd && !busyText.visible && !busy.running) {
            listModel.append({
                                 "rssStart": listModel.count * 10
                             })
        } else if (busyText.visible) {
            repeater.itemAt(listModel.count - 1).model.reload()
        }
    }
    property string baseUrl: Cf.campiConfig[campusSelecionado].urlRssNews
    property Item contentPane
    title: qsTr('Notícias')

    id: page

    Flickable {
        property int limitReload: 40
        id: flickable
        anchors.fill: parent
        contentHeight: gridView.height + busyLoader.height
        maximumFlickVelocity: 5000
        boundsBehavior: Flickable.OvershootBounds

        onMovementEnded: {
            load()
        }

        Grid {
            property int widthPanes: 400
            id: gridView
            width: parent.width
            spacing: 15
            topPadding: 10
            bottomPadding: 10
            columns: getColumns()

            function getColumns() {
                const columns = Math.round(gridView.width / widthPanes)
                return columns !== 0 ? columns : 1
            }

            function getUrlImage(imgTag) {
                var regex = /<img.*?src="(.*?)"/
                const src = regex.exec(imgTag)
                return src !== null ? src[1] : 'qrc:/static/images/ufpa-image.jpg'
            }
            function splitInTags(description) {
                const regex = /<p.*?>|<\/p>/
                const splitP = description.replace(/&nbsp;/g, ' ').split(
                                 regex).filter(function (value) {
                                     return value.trim()
                                 })
                return splitP
            }
            ListModel {
                id: listModel
                ListElement {
                    rssStart: 0
                }
            }
            Repeater {
                id: repeater
                model: listModel
                delegate: repeaterComponent
            }
            Component {
                id: repeaterComponent
                Repeater {
                    model: XmlListModelRss {
                        baseUrl: page.baseUrl
                        start: rssStart
                        onStatusChanged: {
                            busy.running = status === XmlListModel.Loading
                            busyText.visible = status === XmlListModel.Error
                        }
                    }
                    delegate: Item {
                        property variant descriptionInTags: gridView.splitInTags(
                                                                description)
                        id: delegate
                        width: (gridView.width - gridView.padding * 2 - gridView.spacing
                                * (gridView.columns - 1)) / gridView.columns
                        height: 170
                        clip: true

                        Row {
                            anchors.fill: parent
                            anchors.margins: 5
                            clip: true
                            Column {
                                width: parent.width * 0.3
                                height: parent.height
                                Text {
                                    text: qsTr(title)
                                    font.bold: true
                                    color: isDarkMode ? Material.primaryTextColor : Material.primary
                                    width: parent.width
                                    height: parent.height * 0.8
                                    wrapMode: Text.Wrap
                                    elide: Text.ElideRight
                                    horizontalAlignment: Text.AlignRight
                                }
                                Text {
                                    id: dateNew
                                    color: Material.secondaryTextColor
                                    text: RssJS.formatDate(published)
                                    width: parent.width
                                    height: parent.height * 0.2
                                    verticalAlignment: Text.AlignBottom
                                    horizontalAlignment: Text.AlignRight
                                    elide: Text.ElideRight
                                }
                            }
                            ToolSeparator {
                                orientation: Qt.Vertical
                                height: parent.height
                            }
                            RemoteImage {
                                id: imageNew
                                fillMode: Image.PreserveAspectCrop
                                width: parent.width * 0.7
                                height: parent.height
                                source: RssJS.getUrlImage(description)
                                sourceSize {
                                    width: 200
                                    height: 200
                                }
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                stackView.push(
                                            'qrc:/front/components/PageHTML.qml',
                                            {
                                                "paragraphs": delegate.descriptionInTags.map(
                                                                  function (value) {
                                                                      return value.replace(
                                                                                  /<img.*?>/g, '')
                                                                  }).filter(
                                                                  function (value) {
                                                                      return value.trim()
                                                                  }),
                                                "title": title,
                                                "linkNew": link,
                                                "published": dateNew.text,
                                                "urlImage": imageNew.source
                                            })
                            }
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }
        }

        Item {
            id: busyLoader
            anchors.bottom: parent.bottom
            width: parent.width
            height: 50
            Busy {
                id: busy
                padding: 10
                anchors.centerIn: parent
            }
            TextErro {
                id: busyText
                anchors.fill: parent
                MouseArea {
                    anchors.fill: parent
                    onClicked: load()
                }
            }
        }
        ScrollIndicator.vertical: ScrollIndicator {}
    }
}
