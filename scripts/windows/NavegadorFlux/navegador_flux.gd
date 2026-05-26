extends Control

# ── refs ──────────────────────────────────────────────────────────────────────
@onready var search_bar  : LineEdit = $Content/Center/HomeVBox/SearchBar
@onready var url_bar     : LineEdit = $Header/TopLayout/UrlBar
@onready var btn_back    : Button   = $Header/TopLayout/BtnBack
@onready var btn_forward : Button   = $Header/TopLayout/BtnForward
@onready var btn_reload  : Button   = $Header/TopLayout/BtnReload
@onready var btn_fav     : Button   = $Header/TopLayout/BtnFav
@onready var btn_menu    : Button   = $Header/TopLayout/BtnMenu
@onready var login_modal : Panel    = $LoginModal
@onready var btn_login   : Button   = $LoginModal/ModalCenter/Card/CardMargin/CardVBox/BtnLogin
@onready var btn_fechar  : Button   = $LoginModal/ModalCenter/Card/CardMargin/CardVBox/BtnFechar
@onready var input_email : LineEdit = $LoginModal/ModalCenter/Card/CardMargin/CardVBox/InputEmail
@onready var input_senha : LineEdit = $LoginModal/ModalCenter/Card/CardMargin/CardVBox/InputSenha
@onready var modal_sub   : Label    = $LoginModal/ModalCenter/Card/CardMargin/CardVBox/ModalSub

# ── constantes ────────────────────────────────────────────────────────────────
const COLOR_SUB_DEFAULT := Color(0.45, 0.35, 0.62, 1)
const COLOR_SUB_ERROR   := Color(1.0, 0.35, 0.35, 1)
const COLOR_LOCKED      := Color(1, 1, 1, 0.45)
const COLOR_UNLOCKED    := Color(1, 1, 1, 1.0)

# ── estado ────────────────────────────────────────────────────────────────────
var _logged_in : bool = false

# ── init ──────────────────────────────────────────────────────────────────────
func _ready() -> void:
	login_modal.visible = false
	_lock_ui(true)

	search_bar.text_submitted.connect(_on_search_submitted)
	search_bar.focus_entered.connect(_on_field_focus_entered.bind(search_bar))
	url_bar.text_submitted.connect(_on_url_submitted)
	url_bar.focus_entered.connect(_on_field_focus_entered.bind(url_bar))
	btn_login.pressed.connect(_on_login_pressed)
	btn_fechar.pressed.connect(_close_modal)
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		if login_modal.visible:
			_close_modal()

# ── bloqueio de UI ────────────────────────────────────────────────────────────
func _lock_ui(locked: bool) -> void:
	search_bar.editable = not locked
	url_bar.editable    = not locked
	search_bar.modulate = COLOR_LOCKED if locked else COLOR_UNLOCKED

	for btn in [btn_back, btn_forward, btn_reload, btn_fav, btn_menu]:
		btn.disabled = locked

	if locked:
		search_bar.placeholder_text = "🔒  Faça login para pesquisar"
		url_bar.placeholder_text    = "flux://bloqueado"
	else:
		search_bar.placeholder_text = "         🔍  pesquise ou digite um endereço"
		url_bar.placeholder_text    = "flux://novaguia  —  pesquise ou cole um endereço"

# ── intercepta foco nos campos bloqueados ─────────────────────────────────────
func _on_field_focus_entered(field: LineEdit) -> void:
	if not _logged_in:
		field.release_focus()
		_open_modal()

# ── handlers de submit ────────────────────────────────────────────────────────
func _on_search_submitted(text: String) -> void:
	if not _logged_in: _open_modal()
	else: _do_navigate(text)

func _on_url_submitted(text: String) -> void:
	if not _logged_in: _open_modal()
	else: _do_navigate(text)

# ── modal ─────────────────────────────────────────────────────────────────────
func _open_modal() -> void:
	input_email.text = ""
	input_senha.text = ""
	_set_modal_sub("Para pesquisar, entre na sua conta Flux", COLOR_SUB_DEFAULT)
	login_modal.visible = true
	await get_tree().process_frame
	input_email.grab_focus()

func _close_modal() -> void:
	login_modal.visible = false

func _set_modal_sub(text: String, color: Color) -> void:
	modal_sub.text     = text
	modal_sub.modulate = color

func _on_login_pressed() -> void:
	var email := input_email.text.strip_edges()
	var senha := input_senha.text.strip_edges()

	if email.is_empty() or senha.is_empty():
		_set_modal_sub("Preencha e-mail e senha para continuar.", COLOR_SUB_ERROR)
		(input_email if email.is_empty() else input_senha).grab_focus()
		return

	_logged_in = true
	_close_modal()
	_lock_ui(false)
	search_bar.grab_focus()

func _do_navigate(query: String) -> void:
	query = query.strip_edges()
	if query.is_empty():
		return

	var url := query if query.begins_with("http") or query.begins_with("flux://") \
		else "flux://search?q=" + query.uri_encode()

	url_bar.text    = url
	search_bar.text = ""
	print("[Flux] Navegando: ", url)
