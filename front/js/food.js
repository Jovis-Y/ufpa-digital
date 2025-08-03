function getDay() {
    const weekDay = new Date().getDay()

    return 0 < weekDay && weekDay < 6 ? weekDay - 1 : 0
}

function decodeDay(monthDayFinal){
    var nameDay = []
        for(let index=0;index<monthDayFinal.length;index++){
            switch (parseInt(monthDayFinal[index])){
                case 1:
                    nameDay[index] = "Segunda"
                    break;
                case 2:
                    nameDay[index] = "Terça"
                    break;
                case 3:
                    nameDay[index] = "Quarta"
                    break;
                case 4:
                    nameDay[index] = "Quinta"
                    break;
                case 5:
                    nameDay[index] = "Sexta"
                  break;
            }
      }
      return nameDay;
}

function getDayOfWeek(date) {
  const dayOfWeek = new Date(date).getDay();
  return isNaN(dayOfWeek) ? null :
    ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta'][dayOfWeek];
}

function readFile(fileUrl, functionTriggered) {
    var xhr = new XMLHttpRequest()

    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            functionTriggered(xhr.responseText)
        }
    }

    xhr.open("GET", fileUrl)
    xhr.send()
}

function getWeekDays(json) {
    // return array = [{"weekDay": weekDay,"weekMonth": weekMonth},...]
    let monthDay = [];
    let weekDay = [];
    let dateMonth = [];
    for(let indice =0; indice <10;){
        if (indice == 0){
            monthDay = json["cardapio"]["cardapio"+indice]["data"] + " ";
            weekDay = json["cardapio"]["cardapio"+indice]["diaSemana"];
            dateMonth = json["cardapio"]["cardapio"+indice]["data"] + " ";
        }else{
            monthDay += json["cardapio"]["cardapio"+indice]["data"] + " ";
            weekDay += json["cardapio"]["cardapio"+indice]["diaSemana"];
            dateMonth += json["cardapio"]["cardapio"+indice]["data"] + " ";
        }
        indice = indice + 2;
    }
    weekDay = weekDay.split('');
    monthDay = monthDay.split(' ');
    dateMonth = dateMonth.split(' ');

    let monthDayFinal = []
    let weekDayFinal = []
    let dateMonthFinal = []

    let aux = 0;
    for (let index=0; index < 10; ){
        monthDayFinal[aux] = monthDay[index].split("-")[2];
        dateMonthFinal[aux] = monthDay[index].split("-")[1];
        aux++;
        index = index + 2;
    }

    weekDayFinal = decodeDay(weekDay)

    let mes = monthDayFinal;
    let semana = weekDayFinal;
    let obj; let arrayTotal = []


    for(let i=0;i<mes.length;i++){
      obj={
        "weekDay":semana[i],
        "monthDay":mes[i],
        "dateMonth": dateMonthFinal[i]
      }
      arrayTotal[i] = obj;
    }

//  Exemplro de retorno:
//    [
//      { weekDay: 'Segunda', monthDay: '02' },
//      { weekDay: 'Terça', monthDay: '03' },
//      { weekDay: 'Quarta', monthDay: '04' },
//      { weekDay: 'Quinta', monthDay: '05' },
//      { weekDay: 'Sexta', monthDay: '06' }
//    ]
    return arrayTotal;
}

function criateAlmoAcompanhamento(json, i, almoCancelado){
  let almoAcompanhamento = [];
  let indiceAlmoAcomp=0;
  let j;

  if (almoCancelado !== "NAO"){
    return "";
  }

  switch (i){
    case 0:
      for(j=1; j<6 && indiceAlmoAcomp<5; j++){
        almoAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio0"]["acompanhamento"+j];
        indiceAlmoAcomp++;
      }
      return almoAcompanhamento;

    case 1:
      for(j=1; j<6 && indiceAlmoAcomp<5; j++){
        almoAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio2"]["acompanhamento"+j];
        indiceAlmoAcomp++;
      }
      return almoAcompanhamento;
    case 2:
      for(j=1; j<6 && indiceAlmoAcomp<5; j++){
        almoAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio4"]["acompanhamento"+j];
        indiceAlmoAcomp++;
      }
      return almoAcompanhamento;
    case 3:
      for(j=1; j<6 && indiceAlmoAcomp<5; j++){
        almoAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio6"]["acompanhamento"+j];
        indiceAlmoAcomp++;
      }
      return almoAcompanhamento;
    case 4:
      for(j=1; j<6 && indiceAlmoAcomp<5; j++){
        almoAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio8"]["acompanhamento"+j];
        indiceAlmoAcomp++;
      }
      return almoAcompanhamento;
  }
}

function criateJantarAcompanhamento(json, i, jantarCancelado){
  let jantarAcompanhamento = [];
  let indiceAlmoAcomp=0; let indiceJantarAcomp = 0;
  let j;

  if (jantarCancelado !== "NAO"){
    return "";
  }

  switch (i){
    case 0:
      for( j=1; j<6 && indiceAlmoAcomp<5; j++){
        jantarAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio1"]["acompanhamento"+j];
        indiceAlmoAcomp++;
      }
      return jantarAcompanhamento;
    case 1:
      for( j=1; j<6 && indiceAlmoAcomp<5; j++){
        jantarAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio3"]["acompanhamento"+j];
        indiceAlmoAcomp++;
      }
      return jantarAcompanhamento;
    case 2:
      for( j=1; j<6 && indiceAlmoAcomp<5; j++){
        jantarAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio5"]["acompanhamento"+j];
        indiceAlmoAcomp++;
      }
      return jantarAcompanhamento;
    case 3:
      for( j=1; j<6 && indiceAlmoAcomp<5; j++){
        jantarAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio7"]["acompanhamento"+j];
        indiceAlmoAcomp++;
      }
      return jantarAcompanhamento;
    case 4:
      for( j=1; j<6 && indiceAlmoAcomp<5; j++){
        jantarAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio9"]["acompanhamento"+j];
        indiceAlmoAcomp++;
      }
      return jantarAcompanhamento;
  }
}

function getMeal(json){
    let almoPrincipal = []; let almoVegetariano = [];
    let jantarPrincipal = []; let jantarVegetariano = [];
    let almoCancelado = []; let jantarCancelado = [];
    let arrayTotal = []
    let auxAlm = 0; let auxJant = 0
    let obj;
    let i, j
    let almoAcompanhamento = []; let jantarAcompanhamento = [];

    //Guardando acompanhamentos
    let indiceAlmoAcomp = 0;
    let indiceJantarAcomp = 0;
    for (i=0; i<10; i++){
      if (i % 2 == 0){
        for(let j=1; j<6 && indiceAlmoAcomp<5; j++){
          almoAcompanhamento[indiceAlmoAcomp] = json["cardapio"]["cardapio"+i]["acompanhamento"+j];
          indiceAlmoAcomp++;
        }
      }else{
        for(j=1; j<=6 && indiceJantarAcomp<5; j++){
         jantarAcompanhamento[indiceJantarAcomp] = json["cardapio"]["cardapio"+i]["acompanhamento"+j];
         indiceJantarAcomp++;
        }
      }
    }

    for (let indice=0;indice<10;indice++){
      if (indice % 2 == 0 ){
        almoCancelado[auxAlm] = json["cardapio"]["cardapio" + indice].cancelado
        almoPrincipal[auxAlm] = json["cardapio"]["cardapio"+indice].principal
        almoVegetariano[auxAlm] = json["cardapio"]["cardapio"+indice].vegetariano
        auxAlm++;
      }else{
        jantarCancelado[auxJant] = json["cardapio"]["cardapio" + indice].cancelado
        jantarPrincipal[auxJant] = json["cardapio"]["cardapio"+indice].principal  
        jantarVegetariano[auxJant] = json["cardapio"]["cardapio"+indice].vegetariano
        auxJant++;
      }

    }

    for(i=0; i<almoPrincipal.length;i++){
        obj = {
            "almoCancelado":almoCancelado[i],
            "jantarCancelado":jantarCancelado[i],
            "almoPrincipal": almoPrincipal[i],
            "almoVegetariano": almoVegetariano[i],
            "jantarPrincipal": jantarPrincipal[i],
            "jantarVegetariano": jantarVegetariano[i],
            "almoAcompanhamento": criateAlmoAcompanhamento(json,i, almoCancelado[i]),
            "jantarAcompanhamento": criateJantarAcompanhamento(json, i, jantarCancelado[i])
          }
      arrayTotal[i] = obj
    }

    return arrayTotal;
}















