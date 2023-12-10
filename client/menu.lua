RegisterNetEvent('qbr-moonshiner:client:corn', function()
	exports['qbr-menu']:openMenu({
		{
			header = "Moonshine",
			isMenuHeader = true,
		},
		{
			header = "Add bag of corn 1x",
			txt = "",
			params = {
				event = 'addcorn',
				isServer = false,
			}
		},
		{
			header = "Destroy the moonshine kit",
			txt = "",
			params = {
				event = 'deleteclientserverkit',
				isServer = false,
			}
		},
		{
			header = "Close Menu",
			txt = '',
			params = {
				event = 'qbr-menu:closeMenu',
			}
		},
	})
end)
RegisterNetEvent('qbr-moonshiner:client:sugar', function()
	exports['qbr-menu']:openMenu({
		{
			header = "Moonshine",
			isMenuHeader = true,
		},
		{
			header = "Add bag of sugar 1x",
			txt = "",
			params = {
				event = 'addsugar',
				isServer = false,
			}
		},
		{
			header = "Destroy the moonshine kit",
			txt = "",
			params = {
				event = 'deleteclientserverkit',
				isServer = false,
			}
		},
		{
			header = "Close Menu",
			txt = '',
			params = {
				event = 'qbr-menu:closeMenu',
			}
		},
	})
end)
RegisterNetEvent('qbr-moonshiner:client:water', function()
	exports['qbr-menu']:openMenu({
		{
			header = "Moonshine",
			isMenuHeader = true,
		},
		{
			header = "Add water 1x",
			txt = "",
			params = {
				event = 'addwater',
				isServer = false,
			}
		},
		{
			header = "Destroy the moonshine kit",
			txt = "",
			params = {
				event = 'deleteclientserverkit',
				isServer = false,
			}
		},
		{
			header = "Close Menu",
			txt = '',
			params = {
				event = 'qbr-menu:closeMenu',
			}
		},
	})
end)
RegisterNetEvent('qbr-moonshiner:client:bp', function(burnproces)
	exports['qbr-menu']:openMenu({
		{
			header = "Burning proces "..burnproces.." %",
			isMenuHeader = true,
		},
		{
			header = "Destroy the moonshine kit",
			txt = "",
			params = {
				event = 'deleteclientserverkit',
				isServer = false,
			}
		},
		{
			header = "Close Menu",
			txt = '',
			params = {
				event = 'qbr-menu:closeMenu',
			}
		},
	})
end)
RegisterNetEvent('qbr-moonshiner:client:harvest', function()
	exports['qbr-menu']:openMenu({
		{
			header = "Moonshine",
			isMenuHeader = true,
		},
		{
			header = "Take your moonshine",
			txt = "",
			params = {
				event = 'harvest',
				isServer = false,
			}
		},
		{
			header = "Destroy the moonshine kit",
			txt = "",
			params = {
				event = 'deleteclientserverkit',
				isServer = false,
			}
		},
		{
			header = "Close Menu",
			txt = '',
			params = {
				event = 'qbr-menu:closeMenu',
			}
		},
	})
end)



RegisterNetEvent("openclmenu",function()
	local ped = PlayerPedId()
	local kit = GetClosestkit()
	TriggerServerEvent("openmenu",kit.kitid)
end)



