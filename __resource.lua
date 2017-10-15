--resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
client_scripts {
	'lib/classLib.lua',
	'lib/json.lua',
	'lib/keys.lua',
	'client/reporting.lua',
	'client/syncing.lua',
	'lib/notifications.lua',
	'lib/graphics.lua',
	'lib/input.lua',
	'common/networkEntities.lua',
	'common/armyGroup.lua',
	'lib/DataDumper.lua',
	'common/armySoldier.lua',
	'common/ped.lua',
	'lib/checksum.lua',
	'client/networkEntities.lua',
	'client/client.lua'
}

server_scripts {
	'lib/classLib.lua',
	'lib/json.lua',
	'lib/DataDumper.lua',
	'common/armyGroup.lua',
	'common/armySoldier.lua',
	'common/ped.lua',
	'common/networkEntities.lua',
	'lib/inventory.lua',
	'lib/checksum.lua',
	'server/tracking.lua',
	'server/networkEntities.lua',
	'server/player.lua',
	'server/playerManager.lua',
	'server/server.lua'
}

