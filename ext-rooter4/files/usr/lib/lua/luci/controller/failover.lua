module("luci.controller.failover", package.seeall)

function index()
	local page

	if not nixio.fs.access("/etc/config/failover") then
		return
	end

	page = entry({"admin", "modem", "failover"}, cbi("rooter/failover"), "Connection Failover", 25)
	page.dependent = true

	entry({"admin", "modem", "get_status"}, call("action_get_status"))
end

function action_get_status()
       local file
	mArray = {}
	file = io.open("/tmp/wanstatus", "r")
	if file == nil then
		mArray["wan"] = " "
	else
		mArray["wan"] = file:read("*line")
		mArray["winter"] = file:read("*line")
		mArray["wstatus"] = file:read("*line")
		file:close()
	end
	file = io.open("/tmp/modemstatus", "r")
	if file == nil then
		mArray["modem"] = " "
	else
		mArray["modem"] = file:read("*line")
		mArray["minter"] = file:read("*line")
		mArray["mstatus"] = file:read("*line")
		file:close()
	end
	luci.http.prepare_content("application/json")
	luci.http.write_json(mArray)
end
