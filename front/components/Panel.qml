import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Column {
    property alias headerText: title.text
    BackgroundAPP {
        width: parent.width
        height: 30
        Text {
            id: title
            anchors.centerIn: parent
            font.bold: true
            color: Material.primaryHighlightedTextColor
        }
    }
}
