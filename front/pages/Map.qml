import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import Qt5Compat.GraphicalEffects
import QtLocation
import QtPositioning
import MqttClient 1.0

import "../components"
import "../js/config.js" as Cf
import "../js/map.js" as MapJS

PageApp {
    id: page
    property int sizeButton: 56
    property int animationDuration: 500
    property string undefinedProperty: qsTr("Não informado")
    property bool loading: false
    property var busList: Object()
    property int busCenterIndex: 0
    title: qsTr('Mapa')

    property variant visibleRegion: {
        "latMax": -1.4572908563765181,
        "latMin": -1.478415443600767,
        "lonMax": -48.439450263977044,
        "lonMin": -48.459577560424805,
        "contains": function (coord) {
            var lat = coord.latitude
            var lon = coord.longitude

            return (this.latMin < lat && lat < this.latMax && this.lonMin < lon
                    && lon < this.lonMax)
        }
    }

    function loadObjectsOverpass(responseText, markerIconSource) {
        loading = false
        console.log(responseText);
        const json = JSON.parse(responseText)
        let elements = json.elements.filter(function (element) {
            return ["node", "way"].includes(element.type)
        })
        modelItemView.clear()
        elements.forEach(function (element) {
            let objectReturn = Object()

            objectReturn.latitude = element.type === "node" ? element.lat : element.center.lat
            objectReturn.longitude = element.type === "node" ? element.lon : element.center.lon

            if (markerIconSource)
                objectReturn.markerIconSource = markerIconSource

            if (element.tags) {
                const attributes = ["name", "email", "short_name", "opening_hours", "phone", "description", "website"]
                objectReturn = attributes.reduce(function (acc, current) {
                    acc[current] = element.tags[current]
                    return acc
                }, objectReturn)
            }
            // Ignora POI Universidade Federal do Pará e busca apenas o que o usuário deseja
            if (objectReturn.name !== "Universidade Federal do Pará") {
                modelItemView.append(objectReturn)
            }
        })
        if (modelItemView.count) {
            var objectCenter = modelItemView.get(0)
            mapId.center = QtPositioning.coordinate(objectCenter.latitude,
                                                    objectCenter.longitude)
            if (modelItemView.count === 1)
                mapId.zoomLevel = Math.floor(
                            (mapId.maximumZoomLevel + mapId.maximumZoomLevel) / 2)
        }
    }

    Plugin {
        id: mapPlugin
        name: "osm"
        PluginParameter {
            name: "osm.mapping.providersrepository.address"
            value: "maps-redirect.qt.io"
        }
        PluginParameter {
            name: "osm.useragent"
            value: Cf.title
        }
    }
    PositionSource {
        id: positionSource
        active: true
        updateInterval: 500
        onPositionChanged: {
            var coord = positionSource.position.coordinate
            if (PositionSource.NoError === sourceError) {
                if (modelUserView.count) {
                    modelUserView.set(0, {
                                          "latitude": coord.latitude,
                                          "longitude": coord.longitude
                                      })
                } else {
                    modelUserView.append({
                                             "disableClicked": true,
                                             "latitude": coord.latitude,
                                             "longitude": coord.longitude,
                                             "markerIconSource": "qrc:/static/icons/map-marker-user.svg"
                                         })
                }
            } else {
                toolTip.show(qsTr("Erro ao obter localização"))
                stop()
            }
        }
    }
    Map {
        id: mapId
        anchors.fill: parent
        plugin: mapPlugin
        copyrightsVisible: false

        center: page.isPortrait ? QtPositioning.coordinate(
                                      -1.4735,
                                      -48.4551) : QtPositioning.coordinate(
                                      -1.47474, -48.45438)

        zoomLevel: isPortrait ? 16 : 17
        maximumZoomLevel: 19
        minimumZoomLevel: 15

        Behavior on zoomLevel {
            NumberAnimation {
                duration: animationDuration
            }
        }
        Behavior on center {
            CoordinateAnimation {
                duration: animationDuration
            }
        }
        MouseArea {
            anchors.fill: parent
            onDoubleClicked: {
                if (mapId.mapReady
                        && parent.zoomLevel < parent.maximumZoomLevel) {
                    mapId.zoomLevel += 1
                    mapId.center = mapId.toCoordinate(Qt.point(mouseX, mouseY))
                }
            }
        }
        MapItemView {
            model: ListModel {
                id: modelUserView
            }
            delegate: mapQuickItem
        }
        MapItemView {
            id: mapItemView
            model: ListModel {
                id: modelItemView
            }
            delegate: mapQuickItem
        }
        MapItemView {
            model: ListModel {
                id: modelBusView
            }
            delegate: mapQuickItem
        }
        Component {
            id: mapQuickItem
            MapQuickItem {
                coordinate: QtPositioning.coordinate(model.latitude,
                                                     model.longitude)
                anchorPoint {
                    x: image.width / 2
                    y: item.height
                }
                smooth: true
                sourceItem: Row {
                    id: item
                    height: 40 * (mapId.zoomLevel / mapId.maximumZoomLevel) ** 3
                    clip: true
                    Image {
                        id: image
                        height: parent.height
                        width: height
                        source: !model.markerIconSource ? "qrc:/static/icons/map-marker.svg" : model.markerIconSource
                    }
                    Label {
                        id: label
                        text: model.name ? model.name : ""
                        color: Cf.mapMarkerColor
                        font {
                            bold: true
                            pixelSize: parent.height * 0.3
                        }
                        height: parent.height
                        width: label.text !== "" ? height * 3 : 0
                        wrapMode: Label.Wrap
                        elide: Label.ElideRight
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (!model.disableClicked) {
                            mapId.center = parent.coordinate
                            messageDialog.placeModel = JSON.parse(
                                        JSON.stringify(modelItemView.get(
                                                           model.index)))
                            messageDialog.open()
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        property bool hidden: true

        id: search
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        width: search.hidden ? height : parent.width - anchors.margins * 2
        height: btSearch.height
        radius: width / 2

        color: isDarkMode ? Material.primary : "white"

        Behavior on width {
            NumberAnimation {
                easing {type: Easing.OutCirc}
                duration: animationDuration
            }
        }



        TextField {
            id: inputSearch
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: btSearch.left
            anchors.rightMargin: 10
            anchors.leftMargin: 25

            placeholderText: qsTr("Buscar...")
            color: Material.primaryTextColor
            visible: !search.hidden
            onAccepted: {
                loading = true
                MapJS.queryOverpass("term_search", loadObjectsOverpass,
                                    inputSearch.text)
            }
        }
        ToolButton {
            id: btSearch

            anchors.right: parent.right
            icon {
                source: 'qrc:/static/icons/search.svg'
                color: Material.accent
            }
            onClicked: {
                search.hidden = !search.hidden
                search.focus = true
            }
        }
    }
    RoundButton {
        property bool hidden: true

        id: btFilter
        rotation: btFilter.hidden ? 0 : 180

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: hidden ? -width / 2 : filter.width - width / 2

        padding: 20

        Material.foreground: Material.accent
        Material.background: isDarkMode ? Material.primary : "white"

        icon {
            source: 'qrc:/static/icons/back.svg'
        }
        Behavior on rotation {
            RotationAnimation {
                duration: animationDuration
            }
        }
        Behavior on anchors.rightMargin {
            NumberAnimation {
                duration: animationDuration
            }
        }
        onClicked: btFilter.hidden = !btFilter.hidden
        z: filter.z + 1
        background: Rectangle {
            color: Material.background
            radius: width / 2
        }
    }
    Rectangle {
        id: filter
        anchors.verticalCenter: parent.verticalCenter
        width: 200
        height: parent.height * 0.5
        x: btFilter.x + btFilter.width / 2
        radius: 10
        color: isDarkMode ? Material.primary : "white"
        Column {
            anchors.fill: parent
            anchors.margins: 10
            ItemDelegate {
                id: labelFilter
                text: qsTr("Filtrar por:")
                font.bold: true
                Material.foreground: Material.primaryTextColor
                background: null
            }
            ListView {
                id: filterList
                width: parent.width
                height: parent.height - labelFilter.height
                ScrollIndicator.vertical: ScrollIndicator {
                    active: filterList.moving || !filterList.moving
                }
                clip: true
                model: ListModel {
                    ListElement {
                        tag: 'exhibition_centre'
                        title: qsTr('Auditórios')
                        sourceIcon: 'qrc:/static/icons/auditorium-map.svg'
                        markerIconSource: 'qrc:/static/icons/map-marker-exhibition-centre.svg'
                    }
                    ListElement {
                        tag: 'toilet'
                        title: qsTr('Banheiros')
                        sourceIcon: 'qrc:/static/icons/bathroom.svg'
                        markerIconSource: 'qrc:/static/icons/map-marker-bathroom.svg'
                    }
                    ListElement {
                        tag: 'library'
                        title: qsTr('Bibliotecas')
                        sourceIcon: 'qrc:/static/icons/library.svg'
                        markerIconSource: 'qrc:/static/icons/map-marker-library.svg'
                    }
                    ListElement {
                        tag: 'stop_position'
                        title: qsTr('Pontos do Circular')
                        sourceIcon: 'qrc:/static/icons/bus-stop.svg'
                        markerIconSource: 'qrc:/static/icons/map-marker-bus-stop.svg'
                    }
                    ListElement {
                        tag: 'recycling'
                        title: qsTr('Pontos do Reciclagem')
                        sourceIcon: 'qrc:/static/icons/recycling.svg'
                        markerIconSource: 'qrc:/static/icons/map-marker-recycling.svg'
                    }
                    ListElement {
                        tag: 'food'
                        title: qsTr('Refeições')
                        sourceIcon: 'qrc:/static/icons/food.svg'
                        markerIconSource: 'qrc:/static/icons/map-marker-food.svg'
                    }
                    ListElement {
                        tag: 'copyshop'
                        title: qsTr('Xerox')
                        sourceIcon: 'qrc:/static/icons/copy.svg'
                        markerIconSource: 'qrc:/static/icons/map-marker-copy.svg'
                    }
                }
                delegate: ItemDelegate {
                    width: parent.width
                    text: model.title
                    Material.foreground: Material.primaryTextColor
                    icon.source: model.sourceIcon
                    icon.color: Material.accent
                    onClicked: {
                        btFilter.hidden = true
                        loading = true
                        MapJS.queryOverpass(model.tag, loadObjectsOverpass,
                                            undefined, model.markerIconSource)
                    }
                }
            }
        }
    }
    Label {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 1
        text: qsTr('© Contribuidores do OpenStreetMap')
        font {
            pixelSize: 12
        }
    }
    RoundButton {
        id: clearObjetcs
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 5

        padding: 16

        visible: modelItemView.count
        Material.foreground: Material.accent
        Material.background: isDarkMode ? Material.primary : "white"
        icon {
            source: 'qrc:/static/icons/trash.svg'
        }
        onClicked: {
            modelItemView.clear()
        }
    }
    RoundButton {
        id: busLocation
        anchors.bottom: myLocation.top
        anchors.right: parent.right
        anchors.margins: 5
        Material.foreground: Material.accent
        Material.background: isDarkMode ? Material.primary : "white"
        icon {
            source: 'qrc:/static/icons/bus.svg'
        }
        padding: 16
        onClicked: {
            if (modelBusView.count) {
                var bus = modelBusView.get(busCenterIndex)
                mapId.center = QtPositioning.coordinate(bus['latitude'],
                                                        bus['longitude'])

                if (busCenterIndex < modelBusView.count - 1)
                    busCenterIndex += 1
                else
                    busCenterIndex = 0
            } else {
                toolTip.show(qsTr("Nenhum circular localizado"))
            }
        }
    }
    RoundButton {
        id: myLocation
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 5

        Material.foreground: Material.accent
        Material.background: isDarkMode ? Material.primary : "white"

        padding: 16

        icon {
            source: 'qrc:/static/icons/gps-location.svg'
        }
        onClicked: {
            var coord = positionSource.position.coordinate
            if (page.visibleRegion.contains(coord)) {
                mapId.center = coord
            } else {
                toolTip.show(qsTr("Fora dos limites do mapa"))
            }
        }
    }
    Dialog {
        property variant placeModel: Object()
        id: messageDialog
        width: parent.width < 400 ? parent.width * 0.8 : 300
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height - 5 - 40 * (mapId.zoomLevel / mapId.maximumZoomLevel) ** 3
        clip: true
        title: messageDialog.placeModel.name ? messageDialog.placeModel.name : qsTr(
                                                   "Nome não informado")
        contentItem: Column {
            id: column
            width: parent.width
            Repeater {
                property variant labels: {
                    "opening_hours": qsTr("Horário de funcionamento"),
                    "phone": qsTr("Telefone"),
                    "email": qsTr("E-mail"),
                    "website": qsTr("Website")
                }
                property variant weekDays: {
                    "Mo": qsTr("Seg"),
                    "Tu": qsTr("Ter"),
                    "We": qsTr("Qua"),
                    "Th": qsTr("Qui"),
                    "Fr": qsTr("Sex"),
                    "Sa": qsTr("Sáb"),
                    "Su": qsTr("Dom")
                }
                function replaceDay(str) {
                    Object.keys(weekDays).forEach(function (key) {
                        str = str.replace(key, listView.weekDays[key])
                    })
                    return str
                }
                id: listView
                model: Object.keys(listView.labels)
                delegate: Label {
                    width: parent.width
                    wrapMode: Label.Wrap
                    color: Material.primaryTextColor
                    text: (function () {
                        let str = "<b>" + listView.labels[modelData] + ": </b>"
                        if (messageDialog.placeModel[modelData]) {
                            if (modelData === "opening_hours")
                                messageDialog.placeModel[modelData] = listView.replaceDay(
                                            messageDialog.placeModel[modelData])

                            str += messageDialog.placeModel[modelData]
                        } else
                            str += page.undefinedProperty
                        return str
                    })()
                }
            }
        }
    }
    ProgressBar {
        anchors.top: parent.top
        width: parent.width
        visible: page.loading
        indeterminate: true
    }
    MqttClient {
        property var tempSubscription: 0
        property string portStr: Cf.portMqttCircular
        property string sub: Cf.subMqttCircular

        id: mqtt
        hostname: Cf.hostMqttCircular
        port: portStr

        onConnected: {
            tempSubscription = mqtt.subscribe(sub)
            tempSubscription.messageReceived.connect(setBus)
        }
        onErrorChanged: {
            if (!error)
                toolTip.show(error)
        }
        onStateChanged: {
            if (mqtt.state === MqttClient.Connecting) {
                toolTip.show(qsTr("Conectando ao servidor..."))
            } else if (mqtt.state === MqttClient.Connected) {
                toolTip.show(qsTr("Conectado"))
            }
        }
        function setBus(payload, topic) {
            // código baseado no projeto https://circular.lasseufpa.org/
            // fonte: https://circular.lasseufpa.org/js/mqtt/clientMqtt.js
            // <Qualidade do sinal>,<Temperatura>,<UTC date & Time>,<Latitude>,<Longitude>,<Velocidade>,<Curso>
            if (!(payload.toString() === "test")) {
                payload = payload.toString().split(',')

                const busLat = payload[3] // Latitude
                const busLng = payload[4] // Longitude

                const circular = topic.split('/').pop()

                if (circular in busList) {
                    const index = busList[circular]
                    modelBusView.set(index, {
                                         "latitude": busLat,
                                         "longitude": busLng
                                     })
                } else {
                    busList[circular] = modelBusView.count
                    modelBusView.append({
                                            "disableClicked": true,
                                            "latitude": busLat,
                                            "longitude": busLng,
                                            "markerIconSource": "qrc:/static/icons/map-marker-bus.svg"
                                        })
                }
            }
        }
        Component.onCompleted: mqtt.connectToHost()
    }
}
