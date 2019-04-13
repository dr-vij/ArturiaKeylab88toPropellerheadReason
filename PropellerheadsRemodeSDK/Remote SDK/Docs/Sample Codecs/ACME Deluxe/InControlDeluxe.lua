function remote_init(manufacturer, model)
	assert(model=="In Control Deluxe")
	local items={
		{name="Keyboard", input="keyboard"},
		{name="Pitch Bend", input="value", min=0, max=16383},
		{name="Modulation", input="value", min=0, max=127},
		{name="Joystick X", input="value", output="text", min=0, max=127},
		{name="Joystick Y", input="value", output="text", min=0, max=127},
		{name="Fader 1", input="value", output="value", min=0, max=127},
		{name="Fader 2", input="value", output="value", min=0, max=127},
		{name="Fader 3", input="value", output="value", min=0, max=127},
		{name="Fader 4", input="value", output="value", min=0, max=127},
		{name="Encoder 1", input="delta", output="value", min=0, max=10},
		{name="Encoder 2", input="delta", output="value", min=0, max=10},
		{name="Encoder 3", input="delta", output="value", min=0, max=10},
		{name="Encoder 4", input="delta", output="value", min=0, max=10},
		{name="Button 1", input="button", output="value"},
		{name="Button 2", input="button", output="value"},
		{name="Button 3", input="button", output="value"},
		{name="Button 4", input="button", output="value"},
		{name="LCD", output="text"},
	}
	remote.define_items(items)

	g_lcd_index=table.getn(items)
	g_joystick_x_index=4
	g_joystick_y_index=5

	local inputs={
		{pattern="b? 40 xx", name="Fader 1"},
		{pattern="b? 41 xx", name="Fader 2"},
		{pattern="b? 42 xx", name="Fader 3"},
		{pattern="b? 43 xx", name="Fader 4"},
		{pattern="e? xx yy", name="Pitch Bend", value="y*128 + x"},
		{pattern="b? 01 xx", name="Modulation"},
		{pattern="9? xx 00", name="Keyboard", value="0", note="x", velocity="64"},
		{pattern="<100x>? yy zz", name="Keyboard"},
		{pattern="b? 50 <???y>x", name="Encoder 1", value="x*(1-2*y)"},
		{pattern="b? 51 <???y>x", name="Encoder 2", value="x*(1-2*y)"},
		{pattern="b? 52 <???y>x", name="Encoder 3", value="x*(1-2*y)"},
		{pattern="b? 53 <???y>x", name="Encoder 4", value="x*(1-2*y)"},
		{pattern="b? 60 ?<???x>", name="Button 1"},
		{pattern="b? 61 ?<???x>", name="Button 2"},
		{pattern="b? 62 ?<???x>", name="Button 3"},
		{pattern="b? 63 ?<???x>", name="Button 4"},
	}
	remote.define_auto_inputs(inputs)

	local outputs={
		{name="Fader 1", pattern="b0 40 xx"},
		{name="Fader 2", pattern="b0 41 xx"},
		{name="Fader 3", pattern="b0 42 xx"},
		{name="Fader 4", pattern="b0 43 xx"},
		{name="Encoder 1", pattern="b0 50 0x", x="enabled*(value+1)"},
		{name="Encoder 2", pattern="b0 51 0x", x="enabled*(value+1)"},
		{name="Encoder 3", pattern="b0 52 0x", x="enabled*(value+1)"},
		{name="Encoder 4", pattern="b0 53 0x", x="enabled*(value+1)"},
		{name="Button 1", pattern="b0 60 0<000x>"},
		{name="Button 2", pattern="b0 60 0<000x>"},
		{name="Button 3", pattern="b0 60 0<000x>"},
		{name="Button 4", pattern="b0 60 0<000x>"},
	}
	remote.define_auto_outputs(outputs)
end

function remote_probe(manufacturer,model)
	assert(model=="In Control Deluxe")
	return {
		request="f0 7e 7f 06 01 f7",
		response="f0 7e 7f 06 02 56 66 66 01 03 ?? ?? ?? ?? f7"
	}
end

g_last_input_time=-2000
g_last_input_item=nil

function remote_on_auto_input(item_index)
	if item_index>3 then
		g_last_input_time=remote.get_time_ms()
		g_last_input_item=item_index
	end
end

g_last_joystick_x=-1
g_last_joystick_y=-1

function remote_process_midi(event)
	ret=remote.match_midi("f0 11 22 xx yy f7",event)
	if ret~=nil then
		if g_last_joystick_x~=ret.x then
			local msg={ time_stamp=event.time_stamp, item=g_joystick_x_index, value=ret.x }
			remote.handle_input(msg)
			g_last_joystick_x=ret.x
			remote_on_auto_input(g_joystick_x_index)
		end
		if g_last_joystick_y~=ret.y then
			local msg={ time_stamp=event.time_stamp, item=g_joystick_y_index, value=ret.y }
			remote.handle_input(msg)
			g_last_joystick_y=ret.y
			remote_on_auto_input(g_joystick_y_index)
		end
		return true
	end
	return false
end

g_is_lcd_enabled=false
g_lcd_state=string.format("%-16.16s"," ")
g_delivered_lcd_state=string.format("%-16.16s","#")

g_feedback_enabled=false

function remote_set_state(changed_items)
	for i,item_index in ipairs(changed_items) do
		if item_index==g_lcd_index then
			g_is_lcd_enabled=remote.is_item_enabled(item_index)
			new_text=remote.get_item_text_value(item_index)
			g_lcd_state=string.format("%-16.16s",new_text)
		end
	end

	local now_ms = remote.get_time_ms()
	if (now_ms-g_last_input_time) < 1000 then
		if remote.is_item_enabled(g_last_input_item) then
			local feedback_text=remote.get_item_name_and_value(g_last_input_item)
			if string.len(feedback_text)>0 then
				g_feedback_enabled=true
				g_lcd_state=string.format("%-16.16s",feedback_text)
			end
		end
	elseif g_feedback_enabled then
		g_feedback_enabled=false
		if g_is_lcd_enabled then
			old_text=remote.get_item_text_value(g_lcd_index)
		else
			old_text=" "
		end
		g_lcd_state=string.format("%-16.16s",old_text)
	end
end

local function make_lcd_midi_message(text)
	local event=remote.make_midi("f0 11 22 33 10")
	start=6
	stop=6+string.len(text)-1
	for i=start,stop do
		sourcePos=i-start+1
		event[i] = string.byte(text,sourcePos)
	end
	event[stop+1] = 247         -- hex f7
	return event
end

function remote_deliver_midi()
	local ret_events={}
	local new_text=g_lcd_state
	if g_delivered_lcd_state~=new_text then
		assert(string.len(new_text)==16)
		local lcd_event=make_lcd_midi_message(new_text)
		table.insert(ret_events,lcd_event)
		g_delivered_lcd_state=new_text
	end
	return ret_events
end

function remote_prepare_for_use()
	g_delivered_lcd_state=string.format("%-16.16s","ACME In Control")
	return {
		remote.make_midi("f0 11 22 21 01 f7"),
		make_lcd_midi_message("ACME In Control")
	}
end

function remote_release_from_use()
	return {
		make_lcd_midi_message("Remote disconnect")
	}
end
