function remote_init()
	local items=
	{
		--Transport buttons
		{name="Rewind", input="button"},
		{name="FastForward", input="button"},
		{name="Stop", input="button"},
		{name="Play", input="button"},
		{name="Record", input="button"},
		{name="Loop", input="button"},
	}
	remote.define_items(items)
	
	local inputs=
	{
		--Transport buttons
		{pattern="F0 7F 7F 06 05 F7", name="Rewind", value="1"},
		{pattern="F0 7F 7F 06 04 F7", name="FastForward", value="1"},
		{pattern="F0 7F 7F 06 01 F7", name="Stop", value="1"},
		{pattern="F0 7F 7F 06 02 F7", name="Play", value="1"},
		{pattern="F0 7F 7F 06 06 F7", name="Record", value="1"},
		{pattern="B0 37 xx", name="Loop", value="1"},	--ToDo: Find a way to use switch as global value
	}
	remote.define_auto_inputs(inputs)
end

function remote_probe()
	local controlRequest="F0 7E 7F 06 01 F7"
	-- for example: Keylab49: 	"F0 7E 00 06 02 00 20 6B 02 00 05 02 ?? ?? ?? ?? F7"
	local controlResponse=		"F0 7E 00 06 02 00 20 6B 02 00 05 48 ?? ?? ?? ?? F7"
	return 
	{
		request=controlRequest,
		response=controlResponse
	}
end