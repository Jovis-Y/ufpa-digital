var title = qsTr('UFPA Digital')

// Layout
var heigth = 640
var width = 480

var mapMarkerColor = '#a80c11'

var maximumFlickVelocity = 5000

// Servers URL
var urlJsonRu = 'https://saest.ufpa.br/ru/ru.cardapio.json.php'
var urlRssNews = 'https://portal.ufpa.br/index.php/ultimas-noticias2?format=feed&type=atom'
var urlRssOpportunity = 'https://portal.ufpa.br/index.php/editais-e-bolsas/155-vagas-estagio?format=feed&type=atom'
var urlRadioWebUFPA = 'http://radio.ufpa.br/'
var urlStreamRadioWebUFPA = 'http://www2.radio.ufpa.br/aovivo'
var hostMqttCircular = 'test.mosquitto.org'
var subMqttCircular = '/ufpa/circular/loc/+'
var portMqttCircular = '1883'

// Configuração multicampi completa
var campiConfig = {
	"Belém": {
		nome: "Belém",
		urlJsonRu: 'https://saest.ufpa.br/ru/ru.cardapio.json.php',
		urlRssNews: 'https://portal.ufpa.br/index.php/ultimas-noticias2?format=feed&type=atom',
		urlRssOpportunity: 'https://portal.ufpa.br/index.php/editais-e-bolsas/155-vagas-estagio?format=feed&type=atom',
		urlRadioWebUFPA: 'http://radio.ufpa.br/',
		urlStreamRadioWebUFPA: 'http://www2.radio.ufpa.br/aovivo',
		hostMqttCircular: 'test.mosquitto.org',
		subMqttCircular: '/ufpa/circular/loc/+',
		portMqttCircular: '1883'
	},
	"Altamira": {
		nome: "Altamira",
		urlJsonRu: '',
        urlRssNews: 'https://altamira.ufpa.br/index.php/ultimas-noticias.html?format=feed&type=atom',
		urlRssOpportunity: '',
		urlRadioWebUFPA: '',
		urlStreamRadioWebUFPA: '',
		hostMqttCircular: '',
		subMqttCircular: '',
		portMqttCircular: ''
	},
	"Ananindeua": {
		nome: "Ananindeua",
		urlJsonRu: '',
        urlRssNews: 'https://campusananindeua.ufpa.br/index.php/ultimas-noticias?format=feed&type=atom',
		urlRssOpportunity: '',
		urlRadioWebUFPA: '',
		urlStreamRadioWebUFPA: '',
		hostMqttCircular: '',
		subMqttCircular: '',
		portMqttCircular: ''
	},
	"Abaetetuba": {
		nome: "Abaetetuba",
		urlJsonRu: '',
        urlRssNews: 'https://cubt.ufpa.br/ultimas-noticias?format=feed&type=atom',
		urlRssOpportunity: '',
		urlRadioWebUFPA: '',
		urlStreamRadioWebUFPA: '',
		hostMqttCircular: '',
		subMqttCircular: '',
		portMqttCircular: ''
	},
	"Bragança": {
		nome: "Bragança",
		urlJsonRu: '',
		urlRssNews: 'https://campusbraganca.ufpa.br/ultimasnoticas?format=feed&type=atom',
		urlRssOpportunity: '',
		urlRadioWebUFPA: '',
		urlStreamRadioWebUFPA: '',
		hostMqttCircular: '',
		subMqttCircular: '',
		portMqttCircular: ''
	},
	"Capanema": {
		nome: "Capanema",
		urlJsonRu: '',
        urlRssNews: 'https://campuscapanema.ufpa.br/index.php/ultimas-noticias.html?format=feed&type=atom',
		urlRssOpportunity: '',
		urlRadioWebUFPA: '',
		urlStreamRadioWebUFPA: '',
		hostMqttCircular: '',
		subMqttCircular: '',
		portMqttCircular: ''
	},
	"Castanhal": {
		nome: "Castanhal",
		urlJsonRu: '',
        urlRssNews: 'https://campuscastanhal.ufpa.br/?feed=rss2',
		urlRssOpportunity: '',
		urlRadioWebUFPA: '',
		urlStreamRadioWebUFPA: '',
		hostMqttCircular: '',
		subMqttCircular: '',
		portMqttCircular: ''
	},
    "Salinópolis": {
		nome: "Salinópolis",
		urlJsonRu: '',
        urlRssNews: 'https://campussalinopolis.ufpa.br/index.php/home/noticias?format=feed&type=atom',
		urlRssOpportunity: '',
		urlRadioWebUFPA: '',
		urlStreamRadioWebUFPA: '',
		hostMqttCircular: '',
		subMqttCircular: '',
		portMqttCircular: ''
	},
	"Soure": {
		nome: "Soure",
		urlJsonRu: '',
        urlRssNews: 'https://soure.ufpa.br/ultimas-noticias?format=feed&type=atom',
		urlRssOpportunity: '',
		urlRadioWebUFPA: '',
		urlStreamRadioWebUFPA: '',
		hostMqttCircular: '',
		subMqttCircular: '',
		portMqttCircular: ''
	},
	"Tucuruí": {
		nome: "Tucuruí",
		urlJsonRu: '',
		urlRssNews: 'https://camtuc.ufpa.br/index.php/ultimas-noticias?format=feed&type=atom',
		urlRssOpportunity: '',
		urlRadioWebUFPA: '',
		urlStreamRadioWebUFPA: '',
		hostMqttCircular: '',
		subMqttCircular: '',
		portMqttCircular: ''
	},
	"Cametá": {
		nome: "Cametá",
		urlJsonRu: '',
        urlRssNews: 'https://campuscameta.ufpa.br/index.php/ultimas-noticias?format=feed&type=atom',
		urlRssOpportunity: '',
		urlRadioWebUFPA: '',
		urlStreamRadioWebUFPA: '',
		hostMqttCircular: '',
		subMqttCircular: '',
		portMqttCircular: ''
	}
};
