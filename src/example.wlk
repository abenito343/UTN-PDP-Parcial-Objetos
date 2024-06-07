/** 
 ** Nombre y Apellido: Ariel Benito
 ** Legajo: 1633168


Puntos de entrada:


 */

class Personaje{
	
	var property copas = 0
	var property agilidad
	var property fuerza
	
	
	method copas() = copas
	
	method estrategia()
	
	method destreza() 
	
	method deltaCopas(delta){ 
		copas = copas + delta
	}
	
}

class Guerrera inherits Personaje{
	var estrategia
	
	override method estrategia() = estrategia == 1
	
	override method destreza() = fuerza * 1.5
}

class Arquero inherits Personaje{
	var rango
	
	override method destreza() = agilidad * rango
	override method estrategia() = rango >100
}

class Ballestero inherits Arquero{
	override method destreza() = super() * 2
}


class Mision{
	
	var copasQueOtorga = 1
	var dificultad
	var participantes = []
	
	const tipoMision
	
	method copasQueOtorga() = tipoMision.copasQueOtorga(copasQueOtorga)
	
	method cantidadParticipantes() = participantes.size()
	
	method copasParticipantes() = participantes.sum({participante=>participantes.copas()})
	
	method estrategiaParticipantes() = participantes.sum({participante=>participantes.estrategia()})
	
	method destrezaParticipantes() = participantes.sum({participante=>participantes.destreza()})
	
	method puedeRealizarse()
	
	method repartirCopas(copas){participantes.forEach{int => int.deltaCopas(copas)}}
	
	method puedeSerSuperada()
	
	method realizarse(){
		if(self.puedeRealizarse()){
			if(self.puedeSerSuperada()){
				self.repartirCopas(self.copasQueOtorga())
			}else{
				self.repartirCopas(-(self.copasQueOtorga()))
			}
		}else{
			throw new DomainException(message = "Misión no puede comenzar")
		}
			
	}
	
	
}

object normal{
	method copasQueOtorga(copas)=copas
	
	}
class Bonus{
	const participantes
	
	method copasQueOtorga(copas)=copas+participantes
}
object boost{
	var multiplicador 
	method copasQueOtorga(copas)= copas*multiplicador
}

class MisionIndividual inherits Mision {
	override method puedeRealizarse() = self.copasParticipantes()>9 and self.cantidadParticipantes() == 1
	
	override method copasQueOtorga()= super()+dificultad*2
	
	method puedeSerSuperada() = self.estrategiaParticipantes() > dificultad || self.destrezaParticipantes() > dificultad
	
	
	
}
class MisionEquipo inherits Mision {
	
	override method puedeRealizarse() = self.copasParticipantes()>59 and self.cantidadParticipantes() > 1
	
	override method copasQueOtorga() =  super()+(50 / self.cantidadParticipantes())
	
	method estrategiaMayoriaParticipantes() = (self.estrategiaParticipantes() > self.cantidadParticipantes()/2)
	
	method destrezaParticipantesMayorA400()= participantes.all({participante =>participante.destreza()>400})
	 
	method puedeSerSuperada() = self.estrategiaMayoriaParticipantes() || self.destrezaParticipantesMayorA400()
	
	
}

 
object wollok {
	method saludar() = '¡Mucha suerte, gente!'
}
//Punto 5
/*
 * ¿Cuál es el mensaje polimórfico? ¿Qué objetos lo implementan? ¿Qué objeto se aprovecha de ello?
 * method copasQueOtorga() = tipoMision.copasQueOtorga(copasQueOtorga)
	lo estoy aplicando en tipoMision por que con 3 tipos de mision diferentes(normal, bonus, boost)
	*  logro un comportamiento diferente 
 * 
 * 
 */
