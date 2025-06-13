// barcos.wlk

import misiones.*

class BarcoPirata {
    var mision 
    const property tripulacion = []
    const property capacidadMaxima

    method cambiarMision(unaMision) {
        mision = unaMision
        tripulacion.removeAll(self.tripulacionNoCalifica(unaMision))
    }
    method agregarPirata(unPirata) {
      if(mision.cumpleRequisitos(unPirata) && capacidadMaxima > self.capacidadTripulacion()) {
        tripulacion.add(unPirata)
        }
    }
    method capacidadTripulacion() = tripulacion.size()
    method tieneSuficienteTripulacion() = self.capacidadTripulacion() >= capacidadMaxima * 0.9
    method hayTripulanteQueTiene(unItem) = tripulacion.any({t => t.tiene(unItem)})
    method puedeSerSaqueadoPor(unPirata) = unPirata.estaPasadoDeGrug()
    method esVulnerable(otroBarco) {
        return 
        self.capacidadTripulacion() >= otroBarco.capacidadTripulacion() / 2
    } 
    method estanTodosPasadosDeGrog() = tripulacion.all({p => p.estaPasadoDeGrug()})
    method tripulacionNoCalifica(unaMision) = tripulacion.filter({p => not unaMision.esUtil(p)})
    method anclarEnCiudad(unaCiudad) {
      self.todosSeTomanGrog(5)
      self.todosSeGastan(1)
      self.removerMasBorracho()
      unaCiudad.sumarUnHabitante()
    }
    method todosSeTomanGrog(unaCantidad) {
      tripulacion.forEach({p => p.tomarGrog(unaCantidad)})
    }
    method todosSeGastan(unaCantidad) {
      tripulacion.forEach({p => p.gastarMonedas(unaCantidad)})
    }
    method elMasBorracho() = tripulacion.max({p = p.nivelDeEbriedad()})
    method removerMasBorracho() {
      tripulacion.remove(self.elMasBorracho())
    }
    method esTemible() = mision.puedeCumplirMision(self)
}

class Espia inherits Pirata {
      
}

class CiudadCostera {
    var habitantes
    method puedeSerSaqueadoPor(unPirata) = unPirata.nivelEbriedadMayorA(50) 
    method esVulnerable(otroBarco) {
        return otroBarco.capacidadTripulacion() >= habitantes * 0.4
    }
    method sumarUnHabitante() {
      habitantes += 1
    }
}

class Pirata {
    const property items = []
    var nivelDeEbriedad 
    var monedas 
    
    method agregarItem(unItem) {
      items.add(unItem)
    }
    method nivelDeEbriedad() = nivelDeEbriedad
    method nivelEbriedadMayorA(unValor) = nivelDeEbriedad > unValor
    method tiene(unItem) = items.contains(unItem) 
    method tieneMenosDe(unaCantidad) = monedas < unaCantidad
    method tieneAlMenosItems(unaCantidad) = items.size() >= unaCantidad
    method estaPasadoDeGrug() = nivelDeEbriedad >= 90 
    method seAnimaA(unObjetivo) = unObjetivo.puedeSerSaqueadoPor(self)
    method esUtil(unaMision) = unaMision.esUtil(self)
    method tomarGrog(unaCantidad) {
      nivelDeEbriedad += unaCantidad
    }
    method gastarMonedas(unaCantidad) {
      monedas = (monedas - unaCantidad).max(0)
    }
}