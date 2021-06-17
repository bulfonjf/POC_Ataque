extends Node

# recibir array de buff/debuff (modificadores) --> 
# agruparlos segun tipo de modificador b/db y por segun atributo

func agrupar_modificadores(lista_modificadores : Array, filtro : FuncRef, agrupar : FuncRef) -> Dictionary:
    var modificadores_por_tipo_y_atributo = {}

    for modificador in lista_modificadores:
        if filtro.call_func(modificador):
            agrupar.call_func(modificadores_por_tipo_y_atributo, modificador)
   
    return modificadores_por_tipo_y_atributo

func filtrar_por_Buff(modificador : Modificador) -> bool:
    return modificador is Buff

func filtrar_por_Debuff(modificador : Modificador) -> bool:
        return modificador is Debuff