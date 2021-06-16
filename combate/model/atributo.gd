class_name Atributo

var nombre : String
var valor : Valor
var valor_maximo : int
var valor_minimo : int

func _init(_nombre : String, _valor : Valor, _valor_maximo : int, _valor_minimo : int):
	nombre = _nombre
	valor = _valor
	valor_maximo = _valor_maximo
	valor_minimo = _valor_minimo

func _to_string():
	return "nombre %s" % nombre + " cantidad %d" % valor.cantidad

func _eq(other : Atributo):
	return nombre == other.nombre && valor._eq(other.valor)

func set_valor(nuevo_valor : Valor):
	valor = nuevo_valor
