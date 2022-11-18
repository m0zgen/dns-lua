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

local file_path = "/etc/dnsdist/dns-lua/lists/allowlist.txt" -- # path to list
local pattern = "#" -- # except pattern from list
local matches = {}

local function contains(str, pattern)
  return string.match(str, pattern) and true or false
end

for line in io.lines(file_path) do
  if not contains(line, pattern) then
    -- table.insert(matches, line)
    addAction(RegexRule(line), PoolAction("public"))
  end
end

-- --