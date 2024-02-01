local NS = {}

-- Create server with default parameters
local defaultParams = {
    sockets = 2,
    order=1,
    qps=100,
    weight=100,
    reconnectOnUp=true,
    maxInFlight=10240,
    tcpFastOpen=true,
    checkClass = DNSClass.IN,
    checkName="openbld.net.",
    checkType = "A",
    checkTimeout = 2000,
    maxCheckFailures = 3,
    checkInterval = 6,
    mustResolve = false,
    rise = 2
}

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

-- Usage
-- local NS = dofile('/path/to/dns-lua/newServerWithDefaults.lua')
-- NS.newServerWithDefaults('127.0.0.1', 'server-name', 'pool-name')