local sx, sy = guiGetScreenSize()

sw = function(value)
    return sx*value/1920    
end
            
sh = function(value)    
    return sy*value/1080
end

local textures = {}
local bg = dxCreateTexture('bg.png')
local logo_bg = dxCreateTexture('logo_bg.png')
local dxFont = dxCreateFont('normal.ttf', sw(14))

addEventHandler('onClientRender', root, function()
    for _, v in pairs(getElementsByType('vehicle', root, true)) do
        if textures[v] then
            local tex = textures[v]
            if isElement(tex) then
                local x, y, z = getElementPosition(localPlayer)
                local vx, vy, vz = getElementPosition(v)
                local px, py = getScreenFromWorldPosition(vx, vy, vz)
                local distance = getDistanceBetweenPoints3D(x, y, z, vx, vy, vz)

                if distance < 8 then
                    dxDrawImage((px or vx)-130, (py or vy)-600, sw(300), sh(400), tex)
                end
            end
        end
    end
end)


carInfo = function()
    for _, v in pairs(getElementsByType('vehicle', root, true)) do
        if getElementData(v, 'salon:car') then
            local rt = dxCreateRenderTarget(sw(300), sh(400), true)
            local tex = dxCreateTexture(sw(300), sh(400))
            local info = getElementData(v, 'salon:info')
            dxSetRenderTarget(rt, true)
            dxDrawImage(0, 0, 300, 400, bg, 0, 0, 0, tocolor(36, 36, 36, 250))
            dxDrawImage(0, 0, 300, 400, logo_bg, 0, 0, 0, tocolor(255, 255, 255, 255))
            dxDrawText('Model: '..info.name..'\nKoszt pojazdu: \n'..info.cost..' PLN\n\nPrzebieg: '..info.mileage..' KM\nSilnik: '..info.capacity..'dm3\nRocznik: '..info.vintage..'r\n\nAby zakupić ten pojazd\nwejdź do niego i kliknij B', 300, 100, 0, 0, tocolor(255, 255, 255, 255), 1, dxFont, 'center')
            dxSetRenderTarget()
    
            dxSetTexturePixels(tex, dxGetTexturePixels(rt))
            destroyElement(rt)
            textures[v] = tex
        end
    end
end
carInfo()
setTimer(carInfo, 1000, 0)