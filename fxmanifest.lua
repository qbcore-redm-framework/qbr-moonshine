fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

description 'qbr-moonshine'

client_script {
	'client/client.lua',
	'client/menu.lua',
}

server_script {
	'server/server.lua',
}

shared_scripts { 
	'config.lua',
}

exports {
    'isNearKit'
}