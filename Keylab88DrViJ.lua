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


-- Knobs answers
-- 3F - down
-- 41 - up
--In:  B0  4A  3F  |  Ch 1 CC 74 - Brightness P1
-- In:  B0  47  3F  |  Ch 1 CC 71 - Timbre/Harmonic Intens. P2
--In:  B0  4C  3F  |  Ch 1 CC 76 - Vibrato Rate P3
--In:  B0  4C  41  |  Ch 1 CC 76 - Vibrato Rate
-- In:  B0  4D  00  |  Ch 1 CC 77 - Vibrato Depth P4
--  In:  B0  5D  05  |  Ch 1 CC 93 - Chorus Send Level P5

--In:  B0  12  00  |  Ch 1 CC 18 - General Purpose Controller 3   P6
--In:  B0  13  00  |  Ch 1 CC 19 - General Purpose Controller 4		P7
--In:  B0  10  05  |  Ch 1 CC 16 - General Purpose Controller 1		P8	
--In:  B0  11  06  |  Ch 1 CC 17 - General Purpose Controller 2		P9
--In:  B0  5B  03  |  Ch 1 CC 91 - Reverb Send Level				P10

-- In:  B0  23  00  |  Ch 1 CC 35 - Undefined				P1-2
--In:  B0  24  03  |  Ch 1 CC 36 - Foot Controller LSB		p2-2
--In:  B0  25  00  |  Ch 1 CC 37 - Portamento Time LSB		p3-2
-- In:  B0  26  00  |  Ch 1 CC 38 - Data Entry LSB			p4-2
--In:  B0  27  00  |  Ch 1 CC 39 - Channel Volume LSB		p5-2

-- In:  B0  28  06  |  Ch 1 CC 40 - Balance LSB					p6-2
-- In:  B0  29  00  |  Ch 1 CC 41 - Undefined					p7-2
--  In:  B0  2A  00  |  Ch 1 CC 42 - Pan LSB					p8-2
--In:  B0  2B  00  |  Ch 1 CC 43 - Expression Controller LSB	p9-2
--In:  B0  2C  00  |  Ch 1 CC 44 - Effect Control 1 LSB 		p10-2


