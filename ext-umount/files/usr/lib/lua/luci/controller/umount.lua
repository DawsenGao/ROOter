module("luci.controller.umount", package.seeall)

function index()
	local page

	page = entry({"admin", "system", "umount"}, cbi("umount", {hidesavebtn=true, hideresetbtn=true}), "Safely Eject Drive", 25)
	page.dependent = true
end
