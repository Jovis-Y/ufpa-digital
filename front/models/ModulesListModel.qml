import QtQuick

ListModel {
    id: modelModules
    ListElement {
        nameId: "home"
        active: true
        title: qsTr('Início')
        source: 'qrc:/front/pages/Home.qml'
        sourceIcon: 'qrc:/static/icons/home.svg'
    }
    ListElement {
        nameId: "news"
        active: true
        title: qsTr('Notícias')
        source: 'qrc:/front/pages/News.qml'
        sourceIcon: 'qrc:/static/icons/rss.svg'
    }
    ListElement {
        nameId: "opportunity"
        active: true
        title: qsTr('Oportunidades')
        source: 'qrc:/front/pages/Opportunity.qml'
        sourceIcon: 'qrc:/static/icons/opportunity.svg'
    }
    ListElement {
        nameId: "sigaa"
        active: true
        title: qsTr('SIGAA UFPA')
        source: 'qrc:/front/pages/Sigaa.qml'
        sourceIcon: 'qrc:/static/icons/user-sigaa.svg'
    }
    ListElement {
        nameId: "pergamum"
        active: true
        title: qsTr('Pergamum UFPA')
        source: 'qrc:/front/pages/Pergamum.qml'
        sourceIcon: 'qrc:/static/icons/library.svg'
    }
    ListElement {
        nameId: "ru"
        active: true
        title: qsTr('Restaurante Universitário')
        source: 'qrc:/front/pages/Food.qml'
        sourceIcon: 'qrc:/static/icons/food.svg'
    }
    ListElement {
        nameId: "map"
        active: true
        title: qsTr('Mapa')
        source: 'qrc:/front/pages/Map.qml'
        sourceIcon: 'qrc:/static/icons/map.svg'
    }
    ListElement {
        nameId: "radio"
        active: true
        title: qsTr('Rádio Web UFPA')
        source: 'qrc:/front/pages/Radio.qml'
        sourceIcon: 'qrc:/static/icons/radio.svg'
    }
    ListElement {
        nameId: "phone"
        active: true
        title: qsTr('Contatos')
        source: 'qrc:/front/pages/Contacts.qml'
        sourceIcon: 'qrc:/static/icons/phone.svg'
    }
    ListElement {
        nameId: "settings"
        active: true
        title: qsTr('Configurações')
        source: 'qrc:/front/pages/Settings.qml'
        sourceIcon: 'qrc:/static/icons/settings.svg'
    }
    ListElement {
        nameId: "about"
        active: true
        title: qsTr('Sobre')
        source: 'qrc:/front/pages/About.qml'
        sourceIcon: 'qrc:/static/icons/about.svg'
    }
}
