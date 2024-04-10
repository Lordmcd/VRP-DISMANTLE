local Proxy = module('vrp', 'lib/Proxy')
local Tunnel = module("vrp", "lib/Tunnel")
local vRP = Proxy.getInterface('vRP')

RegisterNetEvent('STACK_DESMANCHE:PAYMENT', function()
    local user_id = vRP.getUserId(source)
    vRP.giveInventoryItem(user_id,'dinheiro-sujo',math.random(1000, 1500))
    --   lalala
end)
