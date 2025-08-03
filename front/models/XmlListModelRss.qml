import QtQml.XmlListModel

XmlListModel {
    property int start: 0
    property string baseUrl

    function getUrlFull() {
        if (!baseUrl) {
            return ''
        }
        return baseUrl + '&start=' + start
    }

    source: getUrlFull()
    query: '/feed/entry'

    XmlListModelRole {
        name: 'title'
        elementName: 'title'
    }
    XmlListModelRole {
        name: 'description'
        elementName: 'summary'
    }
    XmlListModelRole {
        name: 'link'
        elementName: 'link'
        attributeName: 'href'
    }
    XmlListModelRole {
        name: 'published'
        elementName: 'published'
    }
    XmlListModelRole {
        name: 'updated'
        elementName: 'updated'
    }
}
