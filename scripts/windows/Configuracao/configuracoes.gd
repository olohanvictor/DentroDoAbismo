extends Control

@onready var nav_buttons  : VBoxContainer  = $Root/Sidebar/SidebarMargin/SidebarVBox/NavButtons
@onready var search_box   : LineEdit       = $Root/ContentMargin/ContentVBox/Header/SearchBox
@onready var grid         : GridContainer  = $Root/ContentMargin/ContentVBox/SettingsGrid
@onready var title_label  : Label          = $Root/ContentMargin/ContentVBox/Header/Title

const CARDS := [
	{"titulo": "Minha Conta",           "sub": "Gerencie suas informações,\nconta e preferências.",        "icone": "👤"},
	{"titulo": "Sistema",               "sub": "Tela, som, notificações,\nenergia e mais.",                "icone": "🖥"},
	{"titulo": "Dispositivos",          "sub": "Bluetooth, impressoras,\nmouse e outros.",                 "icone": "📱"},
	{"titulo": "Rede",                  "sub": "Wi-Fi, modo avião,\nVPN e conexões.",                      "icone": "📶"},
	{"titulo": "Personalização",        "sub": "Plano de fundo, tela de bloqueio,\ncores e temas.",        "icone": "🎨"},
	{"titulo": "Aplicativos",           "sub": "Desinstalar, padrões,\nrecursos opcionais.",               "icone": "⊞"},
	{"titulo": "Jogos",                 "sub": "Barra de jogo, capturas,\nmodo de jogo.",                  "icone": "🎮"},
	{"titulo": "Acessibilidade",        "sub": "Narrador, lupa, alto contraste\ne mais.",                  "icone": "♿"},
	{"titulo": "Privacidade",           "sub": "Localização, câmera,\nmicrofone e mais.",                  "icone": "🔒"},
	{"titulo": "Atualização e Segurança","sub": "Windows Update, backup,\nrecuperação.",                   "icone": "🛡"},
	{"titulo": "Suporte",               "sub": "Obtenha ajuda, entre em contato\nou envie comentários.",   "icone": "🎧"},
]

var _style_card_normal : StyleBoxFlat
var _style_card_hover  : StyleBoxFlat
var _style_nav_active  : StyleBoxFlat
var _todos_cards       : Array = []

func _ready() -> void:
	_build_styles()
	_build_grid(CARDS)
	_connect_nav()

	_set_nav_active("Configurações")

func _build_styles() -> void:
	_style_card_normal = StyleBoxFlat.new()
	_style_card_normal.bg_color = Color(0.058, 0.025, 0.112, 1)
	for side in ["border_width_left","border_width_top","border_width_right","border_width_bottom"]:
		_style_card_normal.set(side, 1)
	_style_card_normal.border_color = Color(0.20, 0.10, 0.34, 0.6)
	for c in ["corner_radius_top_left","corner_radius_top_right","corner_radius_bottom_right","corner_radius_bottom_left"]:
		_style_card_normal.set(c, 10)

	_style_card_hover = _style_card_normal.duplicate()
	_style_card_hover.border_color = Color(0.55, 0.18, 0.88, 0.8)

	_style_nav_active = StyleBoxFlat.new()
	_style_nav_active.bg_color = Color(0.55, 0.16, 0.88, 0.22)
	for c in ["corner_radius_top_left","corner_radius_top_right","corner_radius_bottom_right","corner_radius_bottom_left"]:
		_style_nav_active.set(c, 8)

func _build_grid(cards: Array) -> void:
	for child in grid.get_children():
		child.queue_free()
	_todos_cards.clear()

	for dados in cards:
		var card := _make_card(dados)
		grid.add_child(card)
		_todos_cards.append({"node": card, "dados": dados})

func _make_card(dados: Dictionary) -> PanelContainer:
	var card := PanelContainer.new()
	card.add_theme_stylebox_override("panel", _style_card_normal.duplicate())
	card.custom_minimum_size = Vector2(0, 95)
	card.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	var m := MarginContainer.new()
	for side in ["margin_left","margin_top","margin_right","margin_bottom"]:
		m.add_theme_constant_override(side, 14)
	card.add_child(m)

	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 12)
	m.add_child(row)

	var icon := Label.new()
	icon.text = dados["icone"]
	icon.add_theme_font_size_override("font_size", 26)
	icon.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(icon)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 3)
	vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(vbox)

	var t := Label.new()
	t.text = dados["titulo"]
	t.add_theme_font_size_override("font_size", 13)
	t.add_theme_color_override("font_color", Color(0.90, 0.82, 1.0, 1))
	vbox.add_child(t)

	var s := Label.new()
	s.text = dados["sub"]
	s.add_theme_font_size_override("font_size", 11)
	s.add_theme_color_override("font_color", Color(0.50, 0.40, 0.65, 1))
	s.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	vbox.add_child(s)

	card.mouse_entered.connect(func(): card.add_theme_stylebox_override("panel", _style_card_hover.duplicate()))
	card.mouse_exited.connect(func(): card.add_theme_stylebox_override("panel", _style_card_normal.duplicate()))

	return card

func _connect_nav() -> void:
	for btn in nav_buttons.get_children():
		if btn is Button:
			btn.pressed.connect(func(): _set_nav_active(btn.text.strip_edges()))

func _set_nav_active(nome: String) -> void:
	title_label.text = nome if nome != "Configurações" else "Configurações"
	for btn in nav_buttons.get_children():
		if btn is Button:
			if btn.text.strip_edges() == nome:
				btn.add_theme_stylebox_override("normal", _style_nav_active)
			else:
				btn.remove_theme_stylebox_override("normal")
