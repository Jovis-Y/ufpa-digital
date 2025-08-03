import QtQuick
import QtQuick.Controls.Material

Text {
    text: qsTr('Erro ao carregar')
    opacity: 0.5
    color: Material.primaryTextColor
    font.italic: true
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
