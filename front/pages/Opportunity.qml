import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQml.XmlListModel

import "../components"
import "../models"
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

    property string baseUrl: Cf.urlRssOpportunity
    title: qsTr('Oportunidades')

    id: page

    Flickable {
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
                        function splitInTags(description) {
                            const regex = /<p.*?>|<\/p>/

                            const splitP = description.replace(
                                             /&nbsp;|<img.*?>/g, ' ').split(
                                             regex).filter(function (value) {
                                                 return value.trim()
                                             })
                            return splitP
                        }

                        id: delegate
                        property variant descriptionInTags: splitInTags(
                                                                description)

                        width: (gridView.width - gridView.padding * 2 - gridView.spacing
                                * (gridView.columns - 1)) / gridView.columns
                        height: 150
                        clip: true

                        Row {
                            anchors.fill: parent
                            anchors.margins: 10
                            Column {
                                width: parent.width * 0.3
                                height: parent.height
                                Text {
                                    text: qsTr(title)
                                    font.bold: true
                                    color: isDarkMode ? Material.primaryTextColor : Material.primary
                                    width: parent.width
                                    height: parent.height * 0.7
                                    wrapMode: Text.Wrap
                                    elide: Text.ElideRight
                                    horizontalAlignment: Text.AlignRight
                                }
                                Text {
                                    id: dateText
                                    color: Material.secondaryTextColor
                                    width: parent.width
                                    height: parent.height * 0.3
                                    verticalAlignment: Text.AlignBottom
                                    horizontalAlignment: Text.AlignRight
                                    elide: Text.ElideRight
                                    Component.onCompleted: {
                                        dateText.text = RssJS.formatDate(
                                                    published)
                                    }
                                }
                            }
                            ToolSeparator {
                                orientation: Qt.Vertical
                                height: parent.height
                            }
                            Text {
                                id: descriptionNew
                                text: description.replace(/&nbsp;|<img.*?>/g,
                                                          ' ')
                                width: parent.width * 0.65
                                height: parent.height
                                wrapMode: Text.Wrap
                                elide: Text.ElideRight
                                color: Material.primaryTextColor
                                linkColor: Material.theme === Material.Dark ? Material.secondaryTextColor : Material.primary
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                stackView.push('qrc:/front/components/PageHTML.qml', {
                                                   "paragraphs": delegate.descriptionInTags,
                                                   "title": title,
                                                   "linkNew": link,
                                                   "published": dateText.text
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
