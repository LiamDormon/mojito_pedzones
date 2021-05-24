fx_version 'cerulean'
game 'gta5'

description 'API for spawning peds within a given range using PolyZone'
version '1.0'

dependency 'PolyZone'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    'main.lua'
}