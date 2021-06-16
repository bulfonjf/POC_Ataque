class_name Valor

var cantidad : int

func _init(_cantidad : int):
	if _cantidad < 0:
		_cantidad = 0
		# CHECK THIS: podria tirar error aca
	cantidad = _cantidad

func _eq(_other : Valor):
	return cantidad == _other.cantidad

func _to_string():
	return "cantidad: %d" % cantidad
