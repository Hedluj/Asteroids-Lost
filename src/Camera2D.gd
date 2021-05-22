extends Camera2D

export var var_limit_bottom = 10000000
export var var_limit_top = 10000000
export var var_limit_right = 10000000
export var var_limit_left = 10000000

func _ready():
	set_limit(MARGIN_BOTTOM,var_limit_bottom)
	set_limit(MARGIN_TOP,var_limit_top)
	set_limit(MARGIN_RIGHT,var_limit_right)
	set_limit(MARGIN_LEFT,var_limit_left)
