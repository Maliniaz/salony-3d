local vehicles = {
    -- nazwa, id, cena, przebieg, pojemnosc, rocznik, x, y, z, rx, ry, rz
    -- doherty
    {'Premier', 426, 0, 0, '1.6', '2001', -1953.26, 297.19, 35.21, 0.0, 360.0, 146.6},
    {'Sabre', 475, 0, 0, '1.6', '2003', -1962.66, 300.20, 35.28, 359.7, 360.0, 197.1},
    {'Sentinel', 405, 0, 0, '1.8', '2010', -1957.74, 304.97, 35.34, 0.0, 360.0, 180.3},
    {'Blista Compact', 496, 0, 0, '1.6', '2007', -1963.38, 283.98, 35.20, 360.0, 0.1, 1.9},
    {'Stretch', 409, 0, 0, '1.8', '2016', -1947.70, 267.38, 35.27, 0.0, 0.0, 359.2},
    {'NRG-500', 522, 0, 0, '1.8', '2013', -1956.53, 259.67, 40.62, 359.0, 0.0, 311.9},
    {'Quadbike', 471, 0, 0, '1.6', '2008', -1945.66, 273.16, 40.53, 359.2, 0.0, 139.4},
    {'Faggio', 462, 0, 0, '1.4', '2000', -1949.13, 257.08, 40.66, 359.6, 360.0, 33.7},
    {'Sanchez', 468, 0, 0, '1.6', '2010', -1944.33, 260.95, 40.72, 359.8, 360.0, 38.9},
    -- sport car
    {'Turismo', 451, 0, 0, '2.2', '2014', -1648.66, 1206.32, 20.86, 359.4, 360.0, 72.7},
    {'Infernus', 411, 0, 0, '2.0', '2012', -1661.40, 1218.91, 20.88, 0.0, 0.0, 177.1},
    {'Bansheee', 429, 100, 0, '1.8', '2011', -1665.72, 1205.93, 20.83, 360.0, 0.0, 289.6},
    {'Elegy', 562, 0, 0, '1.8', '2013', -1661.07, 1219.63, 13.33, 359.5, 359.9, 202.6},
    {'Jester', 559, 0, 0, '1.8', '2012', -1648.70, 1207.96, 13.25, 359.9, 360.0, 55.5},
    {'Sandking', 495, 0, 0, '1.8', '2000', -1672.00, 1205.90, 14.13, 0.5, 0.0, 277.5},
    {'Mercedes SLS', 494, 0, 0, '2.4', '2021', -1660.97, 1213.80, 6.98, 0.9, 0.0, 264.0},
}

for i = 1, #vehicles do
    local v = vehicles[i]
    local veh = createVehicle(v[2], v[7], v[8], v[9], v[10], v[11], v[12])
    setElementData(veh, 'salon:car', true)
    setElementData(veh, 'salon:info', {
        name = v[1],
        id = v[2],
        cost = v[3],
        mileage = v[4],
        capacity = v[5],
        vintage = v[6],
    })
    setVehicleColor(veh,0, 0, 0,150,150,150)
    setVehicleDamageProof(veh, true)
    setElementData(veh,'recznySalonData', true)
    setVehicleOverrideLights(veh, 1)
    setElementFrozen(veh,true)
end

addEventHandler('onPlayerVehicleEnter', root, function(veh, seat, jacked)
    if getElementData(veh, 'salon:car') then
        local info = getElementData(veh, 'salon:info')
        bindKey(source, 'B', 'down', function(plr)
            if getPlayerMoney(plr) < info.cost then
                outputChatBox('( #ff0000✘ #ffffff) Nie stać Cię na ten pojazd.', plr, 255, 255, 255, true)
                return false
            end
            takePlayerMoney(plr, info.cost)
            exports['pystories-db']:dbSet('INSERT INTO pystories_vehicles (model, mileage, ownedPlayer, registered, parking, vintage, capacity) VALUES (?, ?, ?, ?, 1, ?, ?)', info.id, info.mileage, getElementData(plr, 'player:sid'), 'true', 'diesel', info.vintage, info.capacity)
            outputChatBox('( #00ff00✔ #ffffff) Pomyślnie zakupiłeś pojazd '..info.name..' z silnikiem '..info.capacity..'dm3 ( '..info.vintage..'r ) za cenę '..info.cost..' PLN!', plr, 255, 255, 255, true)
        end)
    end
end)

addEventHandler('onPlayerVehicleExit', root, function(veh)
    if getElementData(veh, 'salon:car') then
        unbindKey(source, 'B', 'down')
    end
end)