# DNS LUA

Simple scripts collection for services which can support LUA.

## Allow-names

`allow-names.lua` it is a script for binding domain names from `lists/allowlist.txt` to `public` pool servers.

Setup:

Create `public` pool in your DNS server, like as:
```
newServer({address='8.8.8.8', pool='public'})
newServer({address='8.8.4.4', pool='public'})
```

Clone `dns-lua` repo in to DNS server catalog and bind `allow-names.lua` to DNS config:
```
-- Allow list
dofile('/path/to/dns-server/dns-lua/allow-names.lua')
```

Done. Script automatically find own location and add `allowlist.txt` to own logic.