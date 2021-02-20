local webhook = ""



RegisterCommand("combat", function(source, args, rawcmd)
    TriggerClientEvent("doom_anticl:show", source)
end)

AddEventHandler("playerDropped", function(reason)
    local kordit = GetEntityCoords(GetPlayerPed(source))
    local id = source
    local identifier = ""
    if Config.UseSteam then
        identifier = GetPlayerIdentifier(source, 0)
    else
        identifier = GetPlayerIdentifier(source, 1)
    end
    TriggerClientEvent("doom_anticl", -1, id, kordit, identifier, syy)
    if Config.LogSystem then
        LahetaLogi(id, kordit, identifier, syy)
    end
end)

function LahetaLogi(id, kordit, identifier, syy)
    local nimi = GetPlayerName(id)
    local aika = os.date('*t')
    print("id:"..id)
    print("X: "..kordit.x..", Y: "..kordit.y..", Z: "..kordit.z)
    print("identifier:"..identifier)
    print("syy:"..syy)
    if aika.kuukausi < 10 then aika.kuukausi = '0' .. tostring(aika.kuukausi) end
    if aika.paiva < 10 then aika.paiva = '0' .. tostring(aika.paiva) end
    if aika.tunti < 10 then aika.tunti = '0' .. tostring(aika.tunti) end
    if aika.min < 10 then aika.min = '0' .. tostring(aika.min) end
    if aika.sec < 10 then aika.sec = '0' .. tostring(aika.sec) end
    local date = (''..aika.paiva .. '.' .. aika.kuukausi .. '.' .. aika.vuosi .. ' - ' .. aika.tunti .. ':' .. aika.min .. ':' .. aika.sec..'')
    local embeds = {
        {
            ["title"] = "Player Disconnect",
            ["type"]="rich",
            ["color"] = 4777493,
            ["fields"] = {
                {
                    ["nimi"] = "Identifier",
                    ["value"] = identifier,
                    ["inline"] = true,
                },{
                    ["nimi"] = "Name",
                    ["value"] = name,
                    ["inline"] = true,
                },{
                    ["nimi"] = "Player ID",
                    ["value"] = id,
                    ["inline"] = true,
                },{
                    ["nimi"] = "Cordinates",
                    ["value"] = "X: "..kordit.x..", Y: "..kordit.y..", Z: "..kordit.z,
                    ["inline"] = true,
                },{
                    ["nimi"] = "Reason",
                    ["value"] = syy,
                    ["inline"] = true,
                },
            },
            ["footer"]=  {
                ["icon_url"] = "https://cdn.discordapp.com/attachments/808001003496275980/811560780059115587/spirelolxdwebbi.png",
                ["text"]= "Sended: " ..aika.."",
            },
        }
    }
    PerformHttpRequest("webhook this", function(err, text, headers) end, 'POST', json.encode({ username = Config.BotNimi,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end