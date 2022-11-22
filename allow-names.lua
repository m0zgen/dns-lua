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

function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

local script_path = script_path()

-- local file_path = "/etc/dnsdist/dns-lua/lists/allowlist.txt" -- # path to list
local file_path = script_path .. "lists/allowlist.txt" 
local pattern = "#" -- # except pattern from list
local matches = {}

local function contains(str, pattern)
  return string.match(str, pattern) and true or false
end

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
