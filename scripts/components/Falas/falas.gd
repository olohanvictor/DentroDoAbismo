extends RichTextLabel

var falas = [
	"Acho que eu não deveria abrir isso...",
	"Por sorte o Fábio esqueceu o notebook aqui.",
	"Por mais sorte ainda ele é um idiota e deixa a senha colada embaixo do notebook então acessar vai ser bem fácil.", 
	"Preciso ser rápido antes que ele perceba que tem alguém fuçando nos arquivos dele..."
]

func mostrar_fala(faladavez):
	text = "[b][color=purple]Você:[/color][/b] " + falas[faladavez]
	show()
	
func esconder_fala():
	hide()
