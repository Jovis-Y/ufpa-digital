import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "../components"
import "../models"
import "../js/config.js" as Cf

PageApp {
    id: page
    title: qsTr('Contatos')
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
                headerText: qsTr("Redes Sociais - UFPA")
                width: parent.width
                Row {
                    width: parent.width
                    id: rowSocial
                    Repeater {
                        model: SocialListModel {
                            id: socialListModel
                        }
                        delegate: ToolButton {
                            icon.source: sourceIcon
                            onClicked: utils.openUrl(url, Material.primary)
                            highlighted: true
                            width: parent.width / socialListModel.count
                        }
                    }
                }
            }
            ContactsCollapseComponent {
                width: parent.width
                titleComponent: qsTr("Pró-Reitorias")
                modelElementsCollapse: ProReitoriasListModel {}
            }
            ContactsCollapseComponent {
                width: parent.width
                titleComponent: qsTr("Institutos")
                modelElementsCollapse: InstitutosListModel {}
            }
            ContactsCollapseComponent {
                width: parent.width
                titleComponent: qsTr("Núcleos")
                modelElementsCollapse: NucleosListModel {}
            }
        }
        ScrollIndicator.vertical: ScrollIndicator {}
    }
}
