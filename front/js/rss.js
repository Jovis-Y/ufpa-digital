function formatDate(datePublished) {
    var day = function (num) {
        return (num < 10) ? "0" + num : num
    }
    var month = function (num) {
        return ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'][num]
    }
    var date = new Date(datePublished)
    var parts = []

    parts.push(day(date.getDate()))
    parts.push(month(date.getMonth()))
    parts.push(date.getFullYear())

    return parts.join('/')
}

function getUrlImage(description) {
    var imgTag = splitInTags(description)[0]

    var regex = /<img.*?src="(.*?)"/

    const src = regex.exec(imgTag)

    return src !== null ? src[1] : 'qrc:/static/images/ufpa-image.jpg'
}

function splitInTags(description) {
    const regex = /<p.*?>|<\/p>/

    const splitP = description.replace(/&nbsp;/g, ' ').split(regex).filter(
                     function (value) {
                         return value.trim()
                     })
    return splitP
}

function getColumns(width, widthObjects) {
    const columns = Math.round(width / widthObjects)
    return columns !== 0 ? columns : 1
}

function splitInTagsNoImage(description) {
    const regex = /<p.*?>|<\/p>/

    const splitP = description.replace(/&nbsp;|<img.*?>/g, ' ').split(
                     regex).filter(function (value) {
                         return value.trim()
                     })
    return splitP
}
