local NS = {}

-- Create server with default parameters
local defaultParams = {
    sockets = 2,
    reconnectOnUp=true,
    maxInFlight=10240,
    checkClass = DNSClass.IN,
    checkName="openbld.net.",
    checkType = "A",
    checkTimeout = 2000,
    maxCheckFailures = 3,
    checkInterval = 2,
    mustResolve = false,
    rise = 2
}

-- Функция для создания нового сервера с заданными параметрами
-- Create new server with default parameters
function NS.newServerWithDefaults(address, name, pool)
    local serverParams = { address = address, name = name, pool = pool }

    -- Добавление параметров по умолчанию к серверу
    for key, value in pairs(defaultParams) do
        if serverParams[key] == nil then
            serverParams[key] = value
        end
    end

    newServer(serverParams)
end

return NS
