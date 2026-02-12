-- Vehicle Info Command (QBX Core + ox_lib)

RegisterCommand('vehicleinfo', function()
    local ped = PlayerPedId()

    if not IsPedInAnyVehicle(ped, false) then
        lib.notify({
            title = 'Vehicle Info',
            description = 'You are not in a vehicle',
            type = 'error'
        })
        return
    end

    local veh = GetVehiclePedIsIn(ped, false)

    local plate = GetVehicleNumberPlateText(veh)

    local engPct = math.floor((GetVehicleEngineHealth(veh) / 1000) * 100)
    local bodyPct = math.floor((GetVehicleBodyHealth(veh) / 1000) * 100)

    local fuelPct = math.floor(exports['lc_fuel']:GetFuel(veh) or 0)

    lib.registerContext({
        id = 'veh_info_menu',
        title = '🚗 Vehicle Information',
        options = {
            {
                title = 'Number Plate',
                description = plate,
                icon = 'car-side'
            },
            {
                title = 'Fuel Level',
                description = ('Level: %d%%'):format(fuelPct),
                icon = 'gas-pump',
                progress = fuelPct,
                colorScheme = 'yellow'
            },
            {
                title = 'Engine Health',
                description = ('Health: %d%%'):format(engPct),
                icon = 'cogs',
                progress = engPct,
                colorScheme = engPct > 50 and 'green' or 'red'
            },
            {
                title = 'Body Health',
                description = ('Health: %d%%'):format(bodyPct),
                icon = 'car-crash',
                progress = bodyPct,
                colorScheme = bodyPct > 50 and 'green' or 'red'
            }
        }
    })

    lib.showContext('veh_info_menu')
end, false)
