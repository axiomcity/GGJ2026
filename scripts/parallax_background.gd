extends ParallaxLayer

@export var scroll_scale: Vector2 = Vector2(0.5, 0.5)

func _ready():
	# Trouver le Sprite2D enfant
	var sprite = find_child("Sprite2D") as Sprite2D
	if sprite == null:
		push_error("Aucun Sprite2D trouvé dans le ParallaxLayer!")
		return
	
	# Calculer la taille réelle du sprite (texture * scale)
	var texture = sprite.texture
	if texture == null:
		push_error("Le Sprite2D n'a pas de texture!")
		return
	
	var texture_size = texture.get_size()
	var scaled_size = texture_size * sprite.scale
	
	# Configurer le motion_mirroring pour une répétition seamless
	motion_mirroring = Vector2(scaled_size.x, 0)
	
	# Centrer le sprite verticalement si nécessaire
	# Le sprite est positionné par rapport à son centre
	
	# Configurer la vitesse de défilement du parallax
	motion_scale = scroll_scale
	
	print("Background configuré - Taille: ", scaled_size, " Mirroring: ", motion_mirroring)
