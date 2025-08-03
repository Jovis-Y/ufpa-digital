import QtQuick
import QtQuick.Controls

Item {
    property bool isPortrait: this.width < this.height
    property bool toolButtonMenu: true
    property string title: qsTr("Sem Título")

    anchors.left: parent ? parent.left : undefined
    anchors.leftMargin: drawer.width * drawer.position
}
