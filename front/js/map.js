var area_ufpa = 'area(265732584)->.a;'
var timeout = 30

// Query term_search
var query_term_search = function (term) {
    if (!term)
        return '[out:json][timeout:' + timeout + '];();out body center;>;'

    var query_string = '[out:json][timeout:' + timeout + '];('
    query_string += area_ufpa
    query_string += ["name", "short_name", "loc_name"].map(function (value) {
        var temp = ''
        temp += 'way(area.a)["' + value + '"~"' + term + '",i];'
        temp += 'node(area.a)["' + value + '"~"' + term + '",i];'
        return temp
    }).join('')
    query_string += ');out body center;>;'
    return query_string
}

// Query recycling
var query_recycling = '[out:json][timeout:' + timeout + '];('
query_recycling += area_ufpa
query_recycling += 'node(area.a)["amenity"="recycling"];'
query_recycling += 'way(area.a)["amenity"="recycling"];'
query_recycling += ');out body center;>;'

// Query food
var query_food = '[out:json][timeout:' + timeout + '];('
query_food += area_ufpa
query_food += ["food_court", "restaurant", "fast_food"].map(function (value) {
    var temp = ''
    temp = 'node(area.a)["amenity"="' + value + '"];'
    temp += 'way(area.a)["amenity"="' + value + '"];'
    return temp
}).join('')
query_food += ');out body center;>;'

// Query library
var query_library = '[out:json][timeout:' + timeout + '];('
query_library += area_ufpa
query_library += 'node(area.a)["amenity"="library"];'
query_library += 'way(area.a)["amenity"="library"];'
query_library += ');out body center;>;'

// Query toilets
var query_toilets = '[out:json][timeout:' + timeout + '];('
query_toilets += area_ufpa
query_toilets += 'way(area.a)["toilets"="yes"];'
query_toilets += 'way(area.a)["amenity"="toilets"];'
query_toilets += 'node(area.a)["amenity"="toilets"];'
query_toilets += ');out body center;>;'

// Query copyshop
var query_copyshop = '[out:json][timeout:' + timeout + '];('
query_copyshop += area_ufpa
query_copyshop += 'way(area.a)["shop"="copyshop"];'
query_copyshop += 'node(area.a)["shop"="copyshop"] ;'
query_copyshop += ');out body center;>;'

// Query exhibition_centre
var query_exhibition_centre = '[out:json][timeout:' + timeout + '];('
query_exhibition_centre += area_ufpa
query_exhibition_centre += 'way(area.a)["amenity"="exhibition_centre"];'
query_exhibition_centre += 'node(area.a)["amenity"="exhibition_centre"];'
query_exhibition_centre += ');out body center;>;'

// Query stop_position
var query_stop_position = '[out:json][timeout:' + timeout + '];('
query_stop_position += area_ufpa
query_stop_position += 'node(area.a)["public_transport"="platform"];'
query_stop_position += ');out body center;>;'

function getQuery(key, term) {
    var querys = {
        "food": query_food,
        "library": query_library,
        "toilet": query_toilets,
        "copyshop": query_copyshop,
        "exhibition_centre": query_exhibition_centre,
        "stop_position": query_stop_position,
        "term_search": query_term_search(term),
        "recycling": query_recycling
    }
    return querys[key]
}

function queryOverpass(key, callback, term, markerIconSource) {
    var baseOverpass = "http://overpass-api.de/api/interpreter/?data="
    var url = baseOverpass + getQuery(key, term)

    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            callback(xhr.responseText, markerIconSource)
        }
    }
    xhr.open("GET", url)
    xhr.send()
}
