import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import QtCore

import "js/config.js" as Cf

ApplicationWindow {
    function option(regex, index) {
        if (index === undefined)
            index = 0
        if (index < Qt.application.arguments.length) {
            var arg_current = Qt.application.arguments[index]
            return regex.exec(arg_current) ? arg_current : option(regex,
                                                                  index + 1)
        }
        return false
    }
    property var totemEnable: option(new RegExp("^--totem$"))
    property var filterModules: option(new RegExp("^--modules=+"))
    property string campusSelecionado: "Belém" // valor padrão
    property bool isDarkMode: Material.theme === Material.Dark
    id: application

    visibility: !!totemEnable ? ApplicationWindow.FullScreen : ApplicationWindow.AutomaticVisibility
    height: Cf.heigth
    width: Cf.width
    minimumHeight: Cf.heigth / 2
    minimumWidth: Cf.width / 2

    title: qsTr(Qt.application.name)

    visible: true

    Material.primary: isDarkMode ? Material.background : settingsMaterial.primary
    Material.accent: isDarkMode ? settingsMaterial.accentDark : settingsMaterial.accentLight
    Material.theme: settingsMaterial.style

    Settings {
        id: settingsMaterial
        property int style: value("style", Material.Light)
        property color primary: value("primary", "#0f3f68")
        property color accentLight: value("accentLight", "#096a9f")
        property color accentDark: value("accentDark", "#6ca7c7")
    }

    Loader {
        id: mainLoader
        asynchronous: true
        visible: status === Loader.Ready
        anchors.fill: parent
    }
    Loader {
        id: splashLoader
        anchors.fill: parent
        source: "qrc:/front/components/SplashScreen.qml"

        Timer {
            interval: 1000
            running: true
            repeat: false
            onTriggered: mainLoader.source = "qrc:/front/pages/Welcome.qml"
        }

        opacity: mainLoader.visible ? 0 : 1
        visible: opacity !== 0
        Behavior on opacity {
            NumberAnimation {
                duration: 250
            }
        }
    }
}
