// misiones.wlk
import barcos.*

class Mision {
    method puedeCumplirMision(unBarco) = unBarco.tieneSuficienteTripulacion()
}

class BusquedasTesoro inherits Mision {
  /*method piratasUtiles(unBarco) = unBarco.tripulacion().count({p => p.esUtilParaBusquedaTesoro()})
  method puedeRealizarse(unBarco) = unBarco.tripulacion().any({p => p.items().contains("llave de cofre")})*/
  const itemsRequeridos = #{"brujula", "mapa", "grog"}

  method requisitoAdicional(unBarco) = unBarco.hayTripulanteQueTiene("llave de cofre")
  override method puedeCumplirMision(unBarco) {
    return super(unBarco) && self.requisitoAdicional(unBarco)
  }
  method esUtil(unPirata) = not unPirata.items().asSet().intersection(itemsRequeridos).isEmpty() 
  && 
  unPirata.tieneMenosDe(5)
  
  method esUtilBis(unPirata) {
    return 
    itemsRequeridos.any({i => unPirata.contains(i)})
    &&
    unPirata.tieneMenosDe(5)
  }
}

class ConvertirseEnLeyendas inherits Mision {
  //override method puedeCumplirla(unBarco) = hacer.otraCosa() => No modifica el method original

  /*method pirataUtil(unBarco, unObjeto) = unBarco.tripulacion().any({p => p.items() >= 10 && p.items().contains(unObjeto)})
  method puedeRealizarse(unBarco) = true*/
  const itemObligatorio

  method esUtil(unPirata) = unPirata.tieneAlMenosItems(10) && unPirata.tiene(itemObligatorio)
}

class Saqueos inherits Mision {
  /*var objetivo 
  var property monedasNecesitadas

  method piratasUtiles(unBarco) = unBarco.tripulacion().count({p => p.dinero() < self.monedasNecesitadas()})
  method puedeRealizarse(unBarco) = []*/
  var objetivo

  method cambiarObjetivo(unObjetivo) {objetivo = unObjetivo}
  method esUtil(unPirata) {
    return
    unPirata.tieneMenosDe(monedasDeterminadas.valor())
    &&
    unPirata.seAnimaA(objetivo)
  } 
}

object monedasDeterminadas {
  method valor() = 0
}