class_name UnidadAlgoritmoAtaque

var atributos : Array

func _init(_atributos : Array):
	self.atributos = []
	for a in _atributos:
		if a is Atributo:
			self.atributos.append(a)

func match_atributo(atributo_a_buscar : Atributo) -> Atributo:
	var atributo_a_devolver = AtributoNulo.new()
	for atributo in self.atributos:
		if atributo._eq(atributo_a_buscar):
			atributo_a_devolver = atributo
			break
	
	return atributo_a_devolver

func _eq(other : UnidadAlgoritmoAtaque) -> bool:
	var result = false
	for atributo in atributos:
		var atributo_encontrado = other.match_atributo(atributo)
		if atributo_encontrado is AtributoNulo:
			result = false
			break
		else:
			result = true

	return result

func _to_string() -> String:
	var desc = "unidad: \n"
	for atributo in self.atributos:
		desc += " " + atributo._to_string() + "\n"
	
	return desc

func clone_atributes() -> Array:
	var nuevos_atributos = []
	for atributo in self.atributos:
		var nuevo_atributo = Atributo.new(atributo.nombre, Valor.new(atributo.valor.cantidad), atributo.valor_maximo, atributo.valor_minimo)
		nuevos_atributos.append(nuevo_atributo)

	return nuevos_atributos
