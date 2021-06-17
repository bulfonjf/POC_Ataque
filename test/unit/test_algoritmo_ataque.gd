extends "res://addons/gut/test.gd"

var sut = null

func after_each():
	autoqfree(sut)
	sut = null
	
func test_obtner_unidad_modificada_debe_retornar_la_unidad_con_los_modificadores_aplicados():
	var test_suite = [
		{
			test_nombre = "unidad con vida 100 - aplicar buff a la vida de 20 - debe retornar unidad con vida 120",
			modificadores =  [
				Buff.new(Valor.new(20), get_atributo_vida(100))
			],
			unidad =  UnidadAlgoritmoAtaque.new([get_atributo_vida(100)]),
			unidad_esperada = UnidadAlgoritmoAtaque.new([get_atributo_vida(120)]),
		},
		{
			test_nombre = "unidad con vida 100 - aplicar debuff a la vida de 20 - debe retornar unidad con vida 80",
			modificadores =  [
				Debuff.new(Valor.new(20), get_atributo_vida(100))
			],
			unidad =  UnidadAlgoritmoAtaque.new([get_atributo_vida(100)]),
			unidad_esperada = UnidadAlgoritmoAtaque.new([get_atributo_vida(80)]),
		},
		{
			test_nombre = "unidad con vida 100 - aplicar buff de 7 - debe retornar unidad con vida 93",
			modificadores =  [
				Buff.new(Valor.new(7), get_atributo_vida(100))
			],
			unidad =  UnidadAlgoritmoAtaque.new([get_atributo_vida(100)]),
			unidad_esperada = UnidadAlgoritmoAtaque.new([get_atributo_vida(107)])
		},
		{
			test_nombre = "unidad con vida 100 - aplicar debuff de 7 - debe retornar unidad con vida 93",
			modificadores =  [
				Debuff.new(Valor.new(7), get_atributo_vida(100))
			],
			unidad =  UnidadAlgoritmoAtaque.new([get_atributo_vida(100)]),
			unidad_esperada = UnidadAlgoritmoAtaque.new([get_atributo_vida(93)])
		},
	]

	for tc in test_suite:
		# Arrange
		sut = load("res://combate/algoritmo.gd").new()

		# Act
		var unidad_obtenida = sut.obtener_unidad_con_modificadores_aplicados(tc.modificadores, tc.unidad)

		# Assert
		print(tc.test_nombre)
		print("unidad esperada ", tc.unidad_esperada)
		print("unidad obtenida ", unidad_obtenida)
		assert_true(tc.unidad_esperada._eq(unidad_obtenida))
		
		# Teardown
		unidad_obtenida = null
		sut.queue_free()

#func test_obtner_unidad_modificada_deben_retornar_error():
	#var atributo_vida_100 = Atributo.new("vida", Valor.new(100), 120, 0)
	#var buff_vida_20 = Buff.new(Valor.new(20), atributo_vida_100)

	# var test_suite = [
		# {
		# 	test_nombre = "unidad esperada no debe coincidir con unidad obtenida",
		# 	modificadores =  [
		# 		buff_vida_20
		# 	],
		# 	unidad =  UnidadAlgoritmoAtaque.new([atributo_vida_100]),
		# 	unidad_esperada = UnidadAlgoritmoAtaque.new([atributo_vida_100])
		# },
	# ]

	# for tc in test_suite:
	# 	# Arrange
	# 	sut = load("res://combate/algoritmo.gd").new()

	# 	# Act
	# 	var unidad_obtenida = sut.obtener_unidad_con_modificadores_aplicados(tc.modificadores, tc.unidad)

	# 	# Assert
	# 	print(tc.test_nombre)
	# 	print("unidad esperada ", tc.unidad_esperada)
	# 	print("unidad obtenida ", unidad_obtenida)
	# 	assert_false(tc.unidad_esperada._eq(unidad_obtenida)) # TODO darle una vuelta de rosca a este assert
		
	# 	# Teardown
	# 	unidad_obtenida = null
	# 	sut.queue_free()
		
func get_atributo_vida(cantidad : int) -> Atributo:
	return Atributo.new("vida", Valor.new(cantidad), 200, 0)
