extends Node

func obtener_unidad_con_modificadores_aplicados(modificadores : Array, unidad : UnidadAlgoritmoAtaque) -> UnidadAlgoritmoAtaque:
	# Esta variable es en este momento una copia de unidad
	var unidad_a_modificar = UnidadAlgoritmoAtaque.new(unidad.clone_atributes())

	# diccionario de key: Atributo, value: int
	var buff_por_atributo = {}
	var debuff_por_atributo = {}

	# TODO centralizar esto en un helper: buff_por_atributo, debuff_por_atributo = ArrayModificares.GroupByAtributo(modificadores)
	var filtrar_por_buff = funcref(ArrayModificadores, 'filtrar_por_Buff')
	var filtrar_por_debuff = funcref(ArrayModificadores, 'filtrar_por_Debuff')
	var acumular_por_atributo = funcref(self, 'acumular_modificadores_por_atributo')

	buff_por_atributo = ArrayModificadores.agrupar_modificadores(modificadores, filtrar_por_buff, acumular_por_atributo)
	debuff_por_atributo = ArrayModificadores.agrupar_modificadores(modificadores, filtrar_por_debuff, acumular_por_atributo) 
			
	aplicar_modificadores(unidad_a_modificar, buff_por_atributo, debuff_por_atributo)
		
	return unidad_a_modificar
   
func aplicar_modificadores(unidad : UnidadAlgoritmoAtaque, buff_por_atributo : Dictionary, debuff_por_atributo : Dictionary):
	for atributo_a_modificar in unidad.atributos:
		# obtener los modificadores para el atributo
		var buff_total_para_el_atributo = buff_por_atributo.get(atributo_a_modificar.nombre, 0)
		var debuff_total_para_el_atributo = debuff_por_atributo.get(atributo_a_modificar.nombre, 0)

		# calcular el valor nuevo del atributo
		var nuevo_valor_cantidad = calcular_valor_de_atributo(atributo_a_modificar, buff_total_para_el_atributo, debuff_total_para_el_atributo)
		
		# setear al atributo el nuevo valor
		var nuevo_valor = Valor.new(nuevo_valor_cantidad)
		atributo_a_modificar.set_valor(nuevo_valor)

func calcular_valor_de_atributo(atributo : Atributo, porcentaje_buff : int, porcentaje_debuff : int):
	var valor_modificado = calcular_modificacion(atributo.valor.cantidad, porcentaje_buff, porcentaje_debuff)
	return calcular_valor_truncado(atributo, valor_modificado)

func calcular_modificacion(valor_atributo : int, buff_total : int, debuff_total : int) -> int:
	var delta : float
	delta = ((100 + buff_total as float - debuff_total as float) / 100)
	return int(round(valor_atributo * delta))

func calcular_valor_truncado(atributo : Atributo, valor_a_truncar : int):
	# Truncar si excede el maximo
	if valor_a_truncar > atributo.valor_maximo:
		valor_a_truncar = atributo.valor_maximo
	# Truncar si excede el minimo
	elif valor_a_truncar < atributo.valor_minimo:
		valor_a_truncar = atributo.valor_minimo
	
	return valor_a_truncar

func acumular_modificadores_por_atributo(dic : Dictionary, m: Modificador):
	var valor_cantidad = dic.get(m.atributo.nombre, 0)
	if valor_cantidad == 0:
		dic[m.atributo.nombre] = m.valor.cantidad
	else:
		dic[m.atributo.nombre] += m.valor.cantidad
