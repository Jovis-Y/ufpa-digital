import QtQuick
import QtQuick.Controls
import QtWebView

PageApp {
    property alias url: webPage.url
    property alias webPage: webPage

    WebView {
        id: webPage
        height: parent.height
        width: parent.width
        Timer {
            interval: 3000
            running: webPage.loading
            repeat: false
            onTriggered: busy.running = false
        }
    }
    Busy {
        id: busy
        anchors.centerIn: parent
        running: webPage.loading
    }
}
