import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

BackgroundAPP {
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        Image {
            id: logo
            Layout.alignment: Qt.AlignCenter
            fillMode: Image.PreserveAspectFit
            source: 'qrc:/static/images/logo-ufpa-white.svg'
            sourceSize.width: 100
            sourceSize.height: 125
        }
        Label {
            id: label
            Layout.alignment: Qt.AlignCenter
            color: 'white'
            text: qsTr('<b>UFPA</b> Digital')
            Component.onCompleted: label.font.pointSize += 6
        }
    }
}
