resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Optional Needs'

version '1.0.0'

server_scripts {
	'@tprp_base/locale.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}
