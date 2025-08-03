import QtQuick
import QtQuick.Controls.Material

Rectangle {
    color: Material.primary
    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: 'qrc:/static/images/image-background.png'
        opacity: 0.6
    }
}
