extends Popup

func set_text(combination):
	$RichTextLabel.bbcode_text = "Will you stop forgetting the damn access code! I've set it to: " + PoolStringArray(combination).join("") + ". \nThis is the last time i'm changing it for you!"