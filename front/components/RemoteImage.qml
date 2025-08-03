import QtQuick

Image {
    sourceSize {
        width: 200
        height: 200
    }
    cache: true
    Busy {
        height: parent.height / 4
        width: parent.width / 4
        anchors.centerIn: parent
        running: parent.status === Image.Loading
    }
}
