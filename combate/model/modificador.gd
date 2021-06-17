class_name Modificador

var valor : Valor
var atributo : Atributo

func _init(_valor : Valor, _atributo : Atributo):
    valor = _valor
    atributo = _atributo

func _to_string() -> String:
    return "atributo: " + atributo.to_string() + " valor: " + valor.to_string()

    