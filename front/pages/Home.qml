import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQml.XmlListModel

import "../models"
import "../components"
import "../js/config.js" as Cf
import "../js/rss.js" as RssJS
import "../js/food.js" as FoodJS

PageApp {
    id: page
    title: qsTr('Início')
    Flickable {
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        maximumFlickVelocity: 5000
        boundsBehavior: Flickable.OvershootBounds
        contentHeight: columnMain.height

        Column {
            id: columnMain
            width: parent.width
            spacing: 10
            Panel {
                headerText: qsTr("Últimas Notícias")
                width: parent.width
                Item {
                    id: newsSection
                    width: parent.width
                    height: 150
                    Busy {
                        running: xmlRss.status === XmlListModel.Loading
                        anchors.centerIn: parent
                    }
                    TextErro {
                        anchors.fill: parent
                        visible: xmlRss.status === XmlListModel.Error
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                xmlRss.reload()
                            }
                        }
                        z: parent.z + 1
                    }
                    ListView {
                        id: view
                        height: parent.height
                        width: parent.width
                        clip: true
                        orientation: ListView.Horizontal
                        spacing: 10
                        maximumFlickVelocity: 5000
                        boundsBehavior: Flickable.OvershootBounds
                        model: XmlListModelRss {
                            id: xmlRss
                            baseUrl: Cf.urlRssNews
                        }
                        delegate: Item {
                            height: view.height
                            width: page.width < page.height ? view.width : 400
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
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    stackView.push(
                                                'qrc:/front/components/PageHTML.qml',
                                                {
                                                    "paragraphs": RssJS.splitInTags(
                                                                      description).map(
                                                                      function (value) {
                                                                          return value.replace(
                                                                                      /<img.*?>/g,
                                                                                      '')
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
                            }
                        }
                    }
                }
            }
            Panel {
                headerText: qsTr("Oportunidades")
                width: parent.width
                Item {
                    id: opportunitiesSection
                    width: parent.width
                    height: 150
                    Busy {
                        running: xmlRssOpport.status === XmlListModel.Loading
                        anchors.centerIn: parent
                    }
                    TextErro {
                        anchors.fill: parent
                        visible: xmlRssOpport.status === XmlListModel.Error
                        MouseArea {
                            anchors.fill: parent
                            onClicked: xmlRssOpport.reload()
                        }
                        z: parent.z + 1
                    }
                    ListView {
                        id: viewOpport
                        height: parent.height
                        width: parent.width
                        clip: true
                        orientation: ListView.Horizontal
                        spacing: 10
                        maximumFlickVelocity: 5000
                        boundsBehavior: Flickable.OvershootBounds
                        model: XmlListModelRss {
                            id: xmlRssOpport
                            baseUrl: Cf.urlRssOpportunity
                        }

                        delegate: Item {
                            height: viewOpport.height
                            width: page.width < page.height ? viewOpport.width : 400
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
                                        id: dateOpp
                                        color: Material.secondaryTextColor
                                        text: RssJS.formatDate(published)
                                        width: parent.width
                                        height: parent.height * 0.3
                                        verticalAlignment: Text.AlignBottom
                                        horizontalAlignment: Text.AlignRight
                                        elide: Text.ElideRight
                                    }
                                }
                                ToolSeparator {
                                    orientation: Qt.Vertical
                                    height: parent.height
                                }
                                Text {
                                    id: descriptionNew
                                    text: description.replace(
                                              /&nbsp;|<img.*?>/g, ' ')
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
                                    stackView.push(
                                                'qrc:/front/components/PageHTML.qml',
                                                {
                                                    "paragraphs": RssJS.splitInTagsNoImage(
                                                                      description),
                                                    "title": title,
                                                    "linkNew": link,
                                                    "published": dateOpp.text
                                                })
                                }
                            }
                        }
                    }
                }
            }
            Panel {
                property int status: statusKeys.NONE
                property variant statusKeys: {
                    "NONE": 0,
                    "LOADING": 1,
                    "LOADED": 2,
                    "ERRO": 3
                }
                id: panelFood
                headerText: qsTr("Cardápio do Dia")
                width: page.width
                Busy {
                    id: busyFood
                    anchors.horizontalCenter: parent.horizontalCenter
                    running: panelFood.status === panelFood.statusKeys.LOADING
                    height: swipeView.height * 0.7
                    visible: running
                }
                SwipeView {
                    id: swipeView
                    visible: panelFood.status !== panelFood.statusKeys.LOADING
                    width: panelFood.width
                    Repeater {
                        id: repeater
                        model: ListModel {
                            ListElement {
                                label: "ALMOÇO"
                            }
                            ListElement {
                                label: "JANTAR"
                            }
                        }
                        function openFood() {
                            stackView.push('qrc:/front/pages/Food.qml', {
                                               "title": qsTr("Restaurante Universitário")
                                           })
                        }
                        delegate: Column {
                            property string value: ""
                            topPadding: 10
                            spacing: 5
                            Label {
                                text: qsTr(model.label)
                                width: panelFood.width
                                horizontalAlignment: Qt.AlignHCenter
                                wrapMode: Label.Wrap
                                elide: Label.ElideRight
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: repeater.openFood()
                                }
                            }
                            Label {
                                text: parent.value
                                width: panelFood.width
                                horizontalAlignment: Qt.AlignHCenter
                                wrapMode: Label.Wrap
                                elide: Label.ElideRight
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: repeater.openFood()
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        const date = new Date()
                        const hours = date.getHours()

                        swipeView.currentIndex = hours < 15 ? 0 : 1

                        const indexDay = date.getDay()
                        function noLoad(modelData) {
                            repeater.itemAt(0).value = modelData
                            repeater.itemAt(1).value = modelData
                        }
                        if (0 < indexDay && indexDay < 6) {
                            panelFood.status = panelFood.statusKeys.LOADING
                            FoodJS.readFile(Cf.urlJsonRu,
                                            function (responseText) {

                                                try {
                                                    const json = JSON.parse(responseText)
                                                    //lunch
                                                    if (json.cardapio["cardapio"+((indexDay*2)-2)].cancelado !== "NAO"){
                                                        repeater.itemAt(0).value = json.cardapio["cardapio"+((indexDay*2)-2)].cancelado
                                                    }else{
                                                        repeater.itemAt(0).value =  json.cardapio["cardapio"+((indexDay*2)-2)].principal + "<br>" +
                                                                "VEGETARIANO: "+json.cardapio["cardapio"+((indexDay*2)-2)].vegetariano
                                                    }

                                                    //Dinner
                                                    if (json.cardapio["cardapio"+((indexDay*2)-1)].cancelado !== "NAO") {
                                                        repeater.itemAt(1).value = json.cardapio["cardapio"+((indexDay*2)-1)].cancelado
                                                    }else{
                                                        repeater.itemAt(1).value = json.cardapio["cardapio"+((indexDay*2)-1)].principal + "<br>" +
                                                                "VEGETARIANO: "+json.cardapio["cardapio"+((indexDay*2)-1)].vegetariano
                                                    }

                                                    panelFood.status = panelFood.statusKeys.LOADED
                                                } catch (error) {
                                                    noLoad(qsTr('Erro ao carregar cardápio'))
                                                    toolTip.show(qsTr('Erro ao carregar cardápio'))
                                                    panelFood.status = panelFood.statusKeys.ERRO
                                                }
                                            })
                        } else {
                            noLoad(qsTr("Sem funcionamento"))
                        }
                    }
                }
            }
        }
    }
}
