function remote_init()
	local items=
	{
		--Transport buttons
		{name="Rewind", 		input="button"},
		{name="FastForward", 	input="button"},
		{name="Stop", 			input="button"},
		{name="Play", 			input="button"},
		{name="Record", 		input="button"},
		{name="Loop", 			input="button"},
		
		--Knobs:
		--Bank_1
		{name="Cutoff_1", 		input="delta"},
		{name="Resonance_1", 	input="delta"},
		{name="LFORate_1", 		input="delta"},
		{name="LFOAmount_1", 	input="delta"},
		{name="Chorus_1", 		input="delta"},
		{name="Param1_1", 		input="delta"},
		{name="Param2_1", 		input="delta"},
		{name="Param3_1", 		input="delta"},
		{name="Param4_1", 		input="delta"},
		{name="Delay_1", 		input="delta"},
		
		--Knobs:
		--Bank_2
		{name="Cutoff_2", 		input="delta"},
		{name="Resonance_2", 	input="delta"},
		{name="LFORate_2", 		input="delta"},
		{name="LFOAmount_2", 	input="delta"},
		{name="Chorus_2", 		input="delta"},
		{name="Param1_2", 		input="delta"},
		{name="Param2_2", 		input="delta"},
		{name="Param3_2", 		input="delta"},
		{name="Param4_2", 		input="delta"},
		{name="Delay_2", 		input="delta"},
		
		--Faders:
		--Bank_1
		{name="Atack1_1", 		input="value", min=0, max=127},
		{name="Decay1_1", 		input="value", min=0, max=127},
		{name="Sustain1_1", 	input="value", min=0, max=127},
		{name="Release1_1", 	input="value", min=0, max=127},

		{name="Atack2_1", 		input="value", min=0, max=127},
		{name="Decay2_1", 		input="value", min=0, max=127},
		{name="Sustain2_1", 	input="value", min=0, max=127},
		{name="Release2_1", 	input="value", min=0, max=127},
		{name="Fader9_1", 		input="value", min=0, max=127},
		
		--Faders:
		--Bank_2
		{name="Atack1_2", 		input="value", min=0, max=127},
		{name="Decay1_2", 		input="value", min=0, max=127},
		{name="Sustain1_2", 	input="value", min=0, max=127},
		{name="Release1_2", 	input="value", min=0, max=127},

		{name="Atack2_2", 		input="value", min=0, max=127},
		{name="Decay2_2", 		input="value", min=0, max=127},
		{name="Sustain2_2", 	input="value", min=0, max=127},
		{name="Release2_2", 	input="value", min=0, max=127},
		{name="Fader9_2", 		input="value", min=0, max=127},
	}
	remote.define_items(items)
	
	local inputs=
	{
		--Transport buttons
		{pattern="F0 7F 7F 06 05 F7", 	name="Rewind", 		value="1"},
		{pattern="F0 7F 7F 06 04 F7", 	name="FastForward", value="1"},
		{pattern="F0 7F 7F 06 01 F7", 	name="Stop", 		value="1"},
		{pattern="F0 7F 7F 06 02 F7", 	name="Play", 		value="1"},
		{pattern="F0 7F 7F 06 06 F7", 	name="Record", 		value="1"},
		{pattern="B0 37 xx", 			name="Loop", 		value="1"},	--ToDo: Find a way to use switch as global value
		
		--Knobs:
		--Bank_1
		{pattern="B0 4A xx", name="Cutoff_1", 		value="(64 - x)* -1"},
		{pattern="B0 47 xx", name="Resonance_1", 	value="(64 - x)* -1"},
		{pattern="B0 4C xx", name="LFORate_1", 		value="(64 - x)* -1"},
		{pattern="B0 4D xx", name="LFOAmount_1", 	value="(64 - x)* -1"},
		{pattern="B0 5D xx", name="Chorus_1", 		value="(64 - x)* -1"},		
		{pattern="B0 12 xx", name="Param1_1", 		value="(64 - x)* -1"},
		{pattern="B0 13 xx", name="Param2_1", 		value="(64 - x)* -1"},
		{pattern="B0 10 xx", name="Param3_1", 		value="(64 - x)* -1"},
		{pattern="B0 11 xx", name="Param4_1", 		value="(64 - x)* -1"},
		{pattern="B0 5B xx", name="Delay_1", 		value="(64 - x)* -1"},
		
		--Knobs:
		--Bank_2
		{pattern="B0 23 xx", name="Cutoff_2", 		value="(64 - x)* -1"},
		{pattern="B0 24 xx", name="Resonance_2", 	value="(64 - x)* -1"},
		{pattern="B0 25 xx", name="LFORate_2", 		value="(64 - x)* -1"},
		{pattern="B0 26 xx", name="LFOAmount_2", 	value="(64 - x)* -1"},
		{pattern="B0 27 xx", name="Chorus_2", 		value="(64 - x)* -1"},		
		{pattern="B0 28 xx", name="Param1_2", 		value="(64 - x)* -1"},
		{pattern="B0 29 xx", name="Param2_2", 		value="(64 - x)* -1"},
		{pattern="B0 2A xx", name="Param3_2", 		value="(64 - x)* -1"},
		{pattern="B0 2B xx", name="Param4_2", 		value="(64 - x)* -1"},
		{pattern="B0 2C xx", name="Delay_2", 		value="(64 - x)* -1"},
		
		--Faders:
		--Bank_1:
		{pattern="b0 49 xx", name="Atack1_1"},
		{pattern="b0 4B xx", name="Decay1_1"},
		{pattern="b0 4F xx", name="Sustain1_1"},
		{pattern="b0 48 xx", name="Release1_1"},

		{pattern="b0 50 xx", name="Atack2_1"},
		{pattern="b0 51 xx", name="Decay2_1"},
		{pattern="b0 52 xx", name="Sustain2_1"},
		{pattern="b0 53 xx", name="Release2_1"},
		{pattern="b0 55 xx", name="Fader9_1"},
		
		--Faders:
		--Bank_2
		{pattern="b0 43 xx", name="Atack1_2"},
		{pattern="b0 44 xx", name="Decay1_2"},
		{pattern="b0 45 xx", name="Sustain1_2"},
		{pattern="b0 46 xx", name="Release1_2"},

		{pattern="b0 57 xx", name="Atack2_2"},
		{pattern="b0 58 xx", name="Decay2_2"},
		{pattern="b0 59 xx", name="Sustain2_2"},
		{pattern="b0 5A xx", name="Release2_2"},
		{pattern="b0 5C xx", name="Fader9_2"},
		
	}
	remote.define_auto_inputs(inputs)
end

function remote_probe()
	local controlRequest = "F0 7E 7F 06 01 F7"
	-- for example: Keylab49: 	"F0 7E 00 06 02 00 20 6B 02 00 05 02 ?? ?? ?? ?? F7"
	local controlResponse=		"F0 7E 00 06 02 00 20 6B 02 00 05 48 ?? ?? ?? ?? F7"
	return 
	{
		request=controlRequest,
		response=controlResponse
	}
end