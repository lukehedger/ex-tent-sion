require.config
	paths:
		"jquery": "lib/jquery"
	shim:
		app: ["jquery"]


require ["popup"], (Popup) -> new Popup()