`include "ctrl_encode_def.v"

module NPC(
input		[1:0]	NPCOp,
input		[31:0]	PC,
input		[25:0]	IMM,
input		[31:0]	RD1,

output	reg	[31:0]	NPC
);
	wire [31:0] PCPLUS4;
	assign PCPLUS4 = PC + 4;
	
	always@(*) begin
		case(NPCOp)
			`NPC_PLUS4:		NPC = PCPLUS4;
			`NPC_BRANCH:	NPC = PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00};
			`NPC_JUMP:		NPC = {PCPLUS4[31:28], IMM[25:0], 2'b00};
			`NPC_JUMPR:		NPC = RD1;
			default:		NPC = PCPLUS4;
		endcase
	end
	
endmodule