function remote_init()
	local items=
	{
		{name="Rewind", input="button"},
		{name="FastForward", input="button"},
		{name="Play", input="button"},
		{name="Stop", input="button"},
		{name="Record", input="button"},
		{name="Forward", input="button"},
	}
	remote.define_items(items)
end