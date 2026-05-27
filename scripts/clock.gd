extends Label

func _process(_delta):
	var time = Time.get_time_dict_from_system()
	var date = Time.get_date_dict_from_system()
	var weekday = Time.get_datetime_dict_from_system().weekday
	
	# Listas para traduzir os números para português
	var dias_semana = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"]
	var meses = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", 
				 "julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
	
	# Montando as strings
	var dia_nome = dias_semana[weekday]
	var mes_nome = meses[date.month - 1]
	
	# Formatando a saída (o %02d garante que 10:5 vire 10:05)
	var format_string = "{dia_semana}, {dia} de {mes}   {hora}:{minuto}"
	text = format_string.format({
		"dia_semana": dia_nome,
		"dia": date.day,
		"mes": mes_nome,
		"hora": "%02d" % time.hour,
		"minuto": "%02d" % time.minute
	})
