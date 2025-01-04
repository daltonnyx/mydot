local function setup()
	ps.sub("hover", function()
		local current_mime = cx.active.current.hovered
		ya.err("hovered: ", current_mime:mime())
	end)
end

return { setup = setup }
