resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Sukus Crafting Resource'

version '0.0.1'

server_scripts {
	'config.lua',
    'server/main.lua'
}

client_script {
	'config.lua',
	'client/main.lua'
}

ui_page "html/ui.html"

files {
    "html/ui.html",
    "html/ui.css",
    "html/ui.js",
    "html/img/blueprint.jpg",
    "html/img/wrench.png",
    "html/img/phone.png",
    "html/img/water.png"
}