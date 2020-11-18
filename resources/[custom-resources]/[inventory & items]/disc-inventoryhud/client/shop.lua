local shopSecondaryInventory = {
    type = 'shop',
    owner = ''
}

Citizen.CreateThread(function()
    while not ESXLoaded do
        Citizen.Wait(10)
    end

    --[[ ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicence)
        if hasWeaponLicence then
            licence = "weapon"
            print("set your licence to weapon")
        else
            licence = nil
        end 
    end, GetPlayerServerId(PlayerId()), 'weapon')]]
    
    for k, v in pairs(Config.Shops) do
        local check = false
        if v.licence == "weapon" then
            check = true
        else
            check = false
        end

        local marker = {
            name = k,
            type = 1,
            coords = v.coords,
            colour = { r = 255, b = 255, g = 255 },
            size = vector3(0.5, 0.5, 0.0),
            check = check,
            action = function()
                    shopSecondaryInventory.owner = k
                    openInventory(shopSecondaryInventory)
            end,
            shouldDraw = function()
                local playerJob = ESX.PlayerData.job.name
                local ident = ESX.PlayerData.identifier
                if v.job ~= nil then
                    for t, q in pairs(v.job) do
                        if playerJob == q then
                            return true
                        end
                    end
                end

                if v.players ~= nil then
                    for t, q in pairs(v.players) do
                        if ident == q then
                            return true
                        end
                    end
                end

                if v.job == nil and v.players == nil then
                    return true
                end
                return false
            end,
            msg = 'Press ~INPUT_CONTEXT~ to open Shop',
        }
        TriggerEvent('disc-base:registerMarker', marker)
    end
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = GetPlayerPed(-1)
        local coords = GetEntityCoords(player)
        for k, v in pairs(Config.Shops) do
            if GetDistanceBetweenCoords(coords, v.coords, true) < 3.0 then
                ESX.Game.Utils.DrawText3D(vector3(v.coords), "[E] - Open Shop", 0.6)
            end
        end
    end

end)