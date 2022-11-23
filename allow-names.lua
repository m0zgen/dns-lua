-- Allow list - basic example
names = {
    '[a-z]{1,}\\.root-servers.net$',
    '[1-10]{1,}\\.pool.ntp.org$',
    '^[a-z]{2,}\\.pool.ntp.org$',
    '^[0-9]{1,}\\.android.pool.ntp.org$',
    '^pool.ntp.org$',
    '.*yandex\\..*',
    '.*facebook.com$',
    '.*google.com$',
    '.*googleadservices.com$'
}

-- for k,v in pairs(names) do
--     print("Name:" .. v)
--     -- addAction(RegexRule(v), PoolAction("public"))
-- end

-- --

-- Functions
function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

local function contains(str, pattern)
  return string.match(str, pattern) and true or false
end

-- Vars
local script_path = script_path()

-- local file_path = "/etc/dnsdist/dns-lua/lists/allowlist.txt" -- # path to list
local file_path = script_path .. "lists/allowlist.txt" 
local cdb_path = script_path .. "cdb/allowlist.cdb"

-- List loop
local pattern = "#" -- # except pattern from list
local matches = {}

-- Routine

-- List loop
for line in io.lines(file_path) do
  if not contains(line, pattern) then

    if contains(line, "yandex") then
      -- print( "Yandex: " .. line )
      addAction(RegexRule(line), PoolAction("public-yad"))

    elseif contains(line, "google") then
      -- print( "Google: " .. line )
      addAction(RegexRule(line), PoolAction("public"))

    else
      -- print( "Another:" .. line)
      -- table.insert(matches, line)
      addAction(RegexRule(line), PoolAction("public"))
    end

  end
end

-- --

-- Testing

-- local kvs = newCDBKVStore(cdb_path, 3000)
-- addAction(KeyValueStoreLookupRule(kvs, KeyValueLookupKeyQName(false)), SetTagAction('policy', 'kvs-allow-cdb'))
-- addAction(TagRule('kvs-allow-cdb', 'this is the value obtained from the lookup'), PoolAction("test"))

