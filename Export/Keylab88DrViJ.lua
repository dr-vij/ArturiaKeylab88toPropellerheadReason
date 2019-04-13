function remote_init()
	local items=
	{
		{name="Keyboard", input="keyboard"},
		
		--Pedals and modulators
		{name="PitchBend", 			input="value", 		min=0, max=16384},
		{name="ModWheel", 			input="value", 		min=0, max=127},
		{name="Expression", 		input="value", 		min=0, max=127},
		{name="Breath", 			input="value", 		min=0, max=127},
		{name="ChannelPressure", 	input="value", 		min=0, max=127},
		{name="DamperPedal", 		input="value", 		min=0, max=127},
	
		--Extra knobs
		{name="Volume", 		input="value", 			min=0, max=127},
		{name="Category", 		input="delta"},
		{name="Preset", 		input="delta"},
		{name="PresetPress", 	input="button"},
		{name="CategoryPress", 	input="button"},
	
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
		
		--Snapshot buttons (short press): 
		{name="Snap1_Short", input="button"},
		{name="Snap2_Short", input="button"},
		{name="Snap3_Short", input="button"},
		{name="Snap4_Short", input="button"},
		{name="Snap5_Short", input="button"},
		{name="Snap6_Short", input="button"},
		{name="Snap7_Short", input="button"},
		{name="Snap8_Short", input="button"},
		{name="Snap9_Short", input="button"},
		{name="Snap10_Short", input="button"},
		
		--Snapshot buttons (long press): 
		{name="Snap1_Long", 	input="button"},
		{name="Snap2_Long", 	input="button"},
		{name="Snap3_Long", 	input="button"},
		{name="Snap4_Long", 	input="button"},
		{name="Snap5_Long", 	input="button"},
		{name="Snap6_Long", 	input="button"},
		{name="Snap7_Long", 	input="button"},
		{name="Snap8_Long", 	input="button"},
		{name="Snap9_Long", 	input="button"},
		{name="Snap10_Long", 	input="button"},
	}
	remote.define_items(items)
	
	local inputs=
	{
		--Keys:
		--bit-wize patterns for keys and pads. <100x> = 9 if 1001 and 8 if 1000
		{pattern="8z xx yy", 		name="Keyboard", value="0", note="x", velocity="64"},	
		{pattern="9z xx 00", 		name="Keyboard", value="0", note="x", velocity="64"},
		{pattern="<100x>0 yy zz", 	name="Keyboard"},
		{pattern="<100x>9 yy zz", 	name="Keyboard"},

		--Pedals and modulators:
		{pattern="E? xx yy", 	name="PitchBend", value="y*128 + x"},
		{pattern="B0 01 xx", 	name="ModWheel"},
		{pattern="B0 0B xx", 	name="Expression"},
		{pattern="B0 02 xx", 	name="Breath"},
		{pattern="B0 40 xx", 	name="DamperPedal"},
		{pattern="D0 xx", 		name="ChannelPressure"},	

		--Extra knobs:
		{pattern="B0 07 xx", 	name="Volume"},
		{pattern="B0 70 xx", 	name="Category", value="(64 - x) * -1"},	
		{pattern="B0 72 xx", 	name="Preset", value="(64 - x) * -1"},
		{pattern="B0 73 xx", 	name="PresetPress", value="1"},
		{pattern="B0 71 xx", 	name="CategoryPress", value="1"},
		
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
		{pattern="B0 49 xx", name="Atack1_1"},
		{pattern="B0 4B xx", name="Decay1_1"},
		{pattern="B0 4F xx", name="Sustain1_1"},
		{pattern="B0 48 xx", name="Release1_1"},

		{pattern="B0 50 xx", name="Atack2_1"},
		{pattern="B0 51 xx", name="Decay2_1"},
		{pattern="B0 52 xx", name="Sustain2_1"},
		{pattern="B0 53 xx", name="Release2_1"},
		{pattern="B0 55 xx", name="Fader9_1"},
		
		--Faders:
		--Bank_2
		{pattern="B0 43 xx", name="Atack1_2"},
		{pattern="B0 44 xx", name="Decay1_2"},
		{pattern="B0 45 xx", name="Sustain1_2"},
		{pattern="B0 46 xx", name="Release1_2"},

		{pattern="B0 57 xx", name="Atack2_2"},
		{pattern="B0 58 xx", name="Decay2_2"},
		{pattern="B0 59 xx", name="Sustain2_2"},
		{pattern="B0 5A xx", name="Release2_2"},
		{pattern="B0 5C xx", name="Fader9_2"},		
		
		--Snapshot buttons (short press)
		{pattern="B0 16 7F", name="Snap1_Short", 	value="1"},
		{pattern="B0 17 7F", name="Snap2_Short", 	value="1"},
		{pattern="B0 18 7F", name="Snap3_Short", 	value="1"},
		{pattern="B0 19 7F", name="Snap4_Short", 	value="1"},
		{pattern="B0 1A 7F", name="Snap5_Short", 	value="1"},
		{pattern="B0 1B 7F", name="Snap6_Short", 	value="1"},
		{pattern="B0 1C 7F", name="Snap7_Short", 	value="1"},
		{pattern="B0 1D 7F", name="Snap8_Short", 	value="1"},
		{pattern="B0 1E 7F", name="Snap9_Short", 	value="1"},
		{pattern="B0 1F 7F", name="Snap10_Short", 	value="1"},
		
		--Snapshot buttons (long press)
		{pattern="B0 68 7F", name="Snap1_Long", 	value="1"},
		{pattern="B0 69 7F", name="Snap2_Long", 	value="1"},
		{pattern="B0 6A 7F", name="Snap3_Long", 	value="1"},
		{pattern="B0 6B 7F", name="Snap4_Long", 	value="1"},
		{pattern="B0 6C 7F", name="Snap5_Long", 	value="1"},
		{pattern="B0 6D 7F", name="Snap6_Long", 	value="1"},
		{pattern="B0 6E 7F", name="Snap7_Long", 	value="1"},
		{pattern="B0 6F 7F", name="Snap8_Long", 	value="1"},
		{pattern="B0 74 7F", name="Snap9_Long", 	value="1"},
		{pattern="B0 75 7F", name="Snap10_Long", 	value="1"},
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