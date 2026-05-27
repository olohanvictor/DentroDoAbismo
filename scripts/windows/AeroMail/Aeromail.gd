extends Control

const EMAILS: Array[Dictionary] = [
	{
		"de": "Rafael Nunes",
		"assunto": "Project Aero — revisão final",
		"hora": "10:42",
		"corpo": "Oi,\n\nPode verificar a última versão antes do deploy?\n\nAbraços, Rafael"
	},
	{
		"de": "Luna Costa",
		"assunto": "Design tokens update",
		"hora": "09:18",
		"corpo": "Oi!\n\nAtualizei a paleta roxa no Figma.\nQualquer dúvida é só chamar.\n\nLuna"
	},
	{
		"de": "Lohan",
		"assunto": "Re: Sprint planning",
		"hora": "08:05",
		"corpo": "Confirmado pra quinta às 14h.\n\nValeu!"
	}
]

@onready var _email1: PanelContainer = $Window/HBox/MainArea/EmailList/Email1
@onready var _email2: PanelContainer = $Window/HBox/MainArea/EmailList/Email2
@onready var _email3: PanelContainer = $Window/HBox/MainArea/EmailList/Email3
@onready var _main_area: VBoxContainer  = $Window/HBox/MainArea
@onready var _email_list: VBoxContainer = $Window/HBox/MainArea/EmailList

var _linhas: Array[PanelContainer]
var _painel: PanelContainer
var _lbl_de:      Label
var _lbl_assunto: Label
var _lbl_hora:    Label
var _lbl_corpo:   Label

var _s_ativo:   StyleBoxFlat
var _s_nao_lido: StyleBoxFlat
var _s_normal:   StyleBoxFlat

func _ready() -> void:
	_linhas = [_email1, _email2, _email3]
	_criar_estilos()
	_criar_painel()
	_conectar_cliques()

func _criar_estilos() -> void:
	_s_ativo    = _estilo(Color(0.102, 0.063, 0.157), Color(0.663, 0.333, 1.0))
	_s_nao_lido = _estilo(Color(0.059, 0.051, 0.078), Color(0.486, 0.310, 1.0))
	_s_normal   = _estilo(Color(0, 0, 0, 0),          Color(0, 0, 0, 0))

func _criar_painel() -> void:
	_painel = PanelContainer.new()
	_painel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_painel.visible = false
	_painel.add_theme_stylebox_override("panel", _fundo(Color(0.059, 0.051, 0.078)))

	var m := MarginContainer.new()
	for l in ["margin_left","margin_right","margin_top","margin_bottom"]:
		m.add_theme_constant_override(l, 28)
	_painel.add_child(m)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 0)
	m.add_child(vbox)

	var btn := Button.new()
	btn.text = "← Voltar"
	btn.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	for e in ["normal","hover","pressed"]:
		btn.add_theme_stylebox_override(e, _fundo(Color(0,0,0,0)))
	btn.add_theme_color_override("font_color", Color(0.486, 0.310, 1.0))
	btn.add_theme_font_size_override("font_size", 13)
	btn.pressed.connect(_voltar)
	vbox.add_child(btn)
	vbox.add_child(_sep())

	var cab := VBoxContainer.new()
	cab.add_theme_constant_override("separation", 4)
	var mc := MarginContainer.new()
	mc.add_theme_constant_override("margin_top", 16)
	mc.add_theme_constant_override("margin_bottom", 16)
	mc.add_child(cab)
	vbox.add_child(mc)

	_lbl_assunto = _label(Color(0.878, 0.816, 1.0), 15)
	cab.add_child(_lbl_assunto)

	var meta := HBoxContainer.new()
	meta.add_theme_constant_override("separation", 8)
	cab.add_child(meta)
	_lbl_de   = _label(Color(0.600, 0.510, 0.780), 12)
	_lbl_hora = _label(Color(0.290, 0.220, 0.376), 12)
	meta.add_child(_lbl_de)
	meta.add_child(_lbl_hora)

	vbox.add_child(_sep())

	var mb := MarginContainer.new()
	mb.add_theme_constant_override("margin_top", 18)
	vbox.add_child(mb)
	_lbl_corpo = _label(Color(0.612, 0.529, 0.714), 13)
	_lbl_corpo.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	mb.add_child(_lbl_corpo)

	_main_area.add_child(_painel)

func _conectar_cliques() -> void:
	for i in _linhas.size():
		var btn := Button.new()
		btn.anchor_right  = 1.0
		btn.anchor_bottom = 1.0
		btn.flat = true
		for e in ["normal","hover","pressed","focus"]:
			btn.add_theme_stylebox_override(e, _fundo(Color(0,0,0,0)))
		btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		btn.pressed.connect(_abrir.bind(i))
		_linhas[i].add_child(btn)

func _abrir(idx: int) -> void:
	var email: Dictionary = EMAILS[idx]
	_lbl_de.text      = "De: " + email["de"]
	_lbl_assunto.text = email["assunto"]
	_lbl_hora.text    = email["hora"]
	_lbl_corpo.text   = email["corpo"]
	for i in _linhas.size():
		_linhas[i].add_theme_stylebox_override("panel",
			_s_ativo if i == idx else _s_normal)
	_email_list.visible = false
	_painel.visible     = true

func _voltar() -> void:
	_painel.visible     = false
	_email_list.visible = true
	var orig: Array[StyleBoxFlat] = [_s_ativo, _s_nao_lido, _s_normal]
	for i in _linhas.size():
		_linhas[i].add_theme_stylebox_override("panel", orig[i])

# --- helpers ---
func _fundo(c: Color) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = c
	return s

func _estilo(fundo: Color, borda: Color) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = fundo
	s.border_color = borda
	s.border_width_left = 2
	return s

func _label(cor: Color, tam: int) -> Label:
	var l := Label.new()
	l.add_theme_color_override("font_color", cor)
	l.add_theme_font_size_override("font_size", tam)
	return l

func _sep() -> PanelContainer:
	var s := PanelContainer.new()
	s.custom_minimum_size = Vector2(0, 1)
	s.add_theme_stylebox_override("panel", _fundo(Color(0.118, 0.082, 0.188)))
	return s
