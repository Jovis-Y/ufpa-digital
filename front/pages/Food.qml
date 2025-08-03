import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../components"
import "../js/config.js" as Cf
import "../js/food.js" as FoodJS

PageApp {
    property string urlJsonRu: Cf.urlJsonRu
    property variant statusKeys: {
        "NONE": 0,
        "LOADING": 1,
        "LOADED": 2,
        "ERRO": 3
    }
    //Inicia com none(0)
    property int status: statusKeys.NONE
    title: qsTr('Restaurante Universitário')
    id: page

    function load() {
        page.status = page.statusKeys.LOADING
        FoodJS.readFile(urlJsonRu, function (responseText) {
            try {
                const json = JSON.parse(responseText)
                weekDays.model = FoodJS.getWeekDays(json)
                tabBar.currentIndex = FoodJS.getDay()
                repeaterView.model = FoodJS.getMeal(json)
                page.status = page.statusKeys.LOADED
            } catch (error) {
                if (page)
                    page.status = page.statusKeys.ERRO
            }
        })
    }
    Component.onCompleted: {
        load()
    }
    Busy {
        id: busy
        running: page.status === page.statusKeys.LOADING
        anchors.centerIn: parent
    }
    TextErro {
        id: textErro
        anchors.centerIn: parent
        visible: page.status === page.statusKeys.ERRO
        MouseArea {
            anchors.fill: parent
            onClicked: load()
        }
    }
    Column {
        anchors.fill: parent
        visible: page.status === page.statusKeys.LOADED
        TabBar {
            id: tabBar
            width: parent.width
            Material.elevation: 4
            Repeater {
                id: weekDays
                delegate: TabButton {
                    text: "<h5>" + modelData.weekDay + "</h5><br><h4>"
                          + modelData.monthDay + "/"+ modelData.dateMonth + "</h4>"
                    font.bold: true
                    font.italic: true
                }
            }
            z: view.z + 1
        }
        StackLayout {
            id: view
            width: parent.width
            height: parent.height - tabBar.height - parent.spacing
            currentIndex: tabBar.currentIndex
            clip: true
            Repeater {
                id: repeaterView
                delegate: Flickable {
                    height: view.height
                    width: view.width
                    contentHeight: column.height
                    contentWidth: view.width
                    Column {
                        id: column
                        width: parent.width
                        Panel {
                            id: panelAlmoco
                            headerText: qsTr("Almoço")
                            width: parent.width
                            Item {
                                width: parent.width
                                height: labelAlmoco.lineCount * 30
                                clip: true
                                Label {
                                    id: labelAlmoco
                                    text: modelData.almoCancelado === "NAO" ? qsTr(modelData.almoPrincipal +"<br>"+
                                               "VEGETARIANO: "+modelData["almoVegetariano"]) : modelData.almoCancelado
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    width: parent.width
                                    anchors.centerIn: parent
                                    wrapMode: Text.Wrap
                                }
                            }
                            Repeater {
                                id: acompAlmoco
                                model: modelData.almoAcompanhamento
                                delegate: Item {
                                    width: view.width
                                    height: 30
                                    Label {
                                        text:  qsTr(model.modelData)
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        width: parent.width
                                        anchors.centerIn: parent
                                        wrapMode: Text.Wrap
                                    }
                                }
                            }
                        }

                        Panel {
                            id: panelJantar
                            headerText: qsTr("Jantar")
                            width: parent.width
                            Item {
                                width: parent.width
                                height: labelJantar.lineCount * 30
                                clip: true
                                Label {
                                    id: labelJantar
                                    text: modelData.jantarCancelado === "NAO" ? qsTr( modelData.jantarPrincipal +"<br>"+
                                               "VEGETARIANO: " + modelData.jantarVegetariano) : modelData.jantarCancelado
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    width: parent.width
                                    anchors.centerIn: parent
                                    wrapMode: Text.Wrap
                                }
                            }
                            Repeater {
                                id: acompJantar
                                model: modelData.jantarAcompanhamento
                                delegate: Item {
                                    width: view.width
                                    height: 30
                                    Label {
                                        text: qsTr(model.modelData)
                                        //visible: repeaterView.model.jantarCancelado === "NAO" ? true : false
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        width: parent.width
                                        anchors.centerIn: parent
                                        wrapMode: Text.Wrap
                                    }
                                }
                            }
                        }
                    }
                    ScrollIndicator.vertical: ScrollIndicator {}
                }
            }
        }
    }
    RoundButton {
        visible: page.status === page.statusKeys.LOADED
        icon {
            source: "qrc:/static/icons/info.svg"
        }
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10

        padding: 16

        highlighted: true

        onClicked: {
            contentDialog.open()
        }
    }
    Dialog {
        property alias text: labelInfo.text

        id: contentDialog
        title: qsTr("Informações")
        modal: true
        width: Math.min(parent.width, parent.height) / 3  * 2
        height: page.height * 0.7
        standardButtons: Dialog.Close
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        Flickable {
            id: flickable
            clip: true
            anchors.fill: parent
            contentHeight: labelInfo.height
            boundsBehavior: Flickable.OvershootBounds
            Label {
                id: labelInfo
                width: flickable.width
                wrapMode: Label.Wrap
                horizontalAlignment: Qt.AlignHCenter
                text: "<h3>HORÁRIOS:</h3> <p>Almoço: 11:00h às 14:00h<br>Jantar: 17:45h às 19:15h.</p>
<h3>VALOR DA REFEIÇÃO:</h3>
<p>Estudantes de graduação e pós-graduação da UFPA e estudantes visitantes de outras instituições de ensino superior e da educação básica: <b>R$1,00</b><br><br>
Servidores, terceirizados e visitantes que não sejam estudantes: <b>R$10,00</b></p>
<h4>
Para informações mais detalhadas acesse o site oficial da <a href='https://saest.ufpa.br/ru/index.php/d-3'>SAEST/UFPA</a>
</h4>"
                onLinkActivated: {
                    utils.openUrl('https://saest.ufpa.br/ru/index.php/d-3', Material.primary)
                }
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.NoButton
                    cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
            }
            ScrollIndicator.vertical: ScrollIndicator {
                active: flickable.moving || !flickable.moving
            }
        }
    }
}
