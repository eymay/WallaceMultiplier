module PPA (
	x,
	s,
	c
);
	input [511:0] x;
	output wire [31:0] s;
	output wire [31:0] c;
	wire [31:0] level1connector [7:0];
	wire [127:0] level2connector;
	wire [127:0] level3connector;
	wire [31:0] level1Carryconnector [4:0];
	wire [31:0] level2Carryconnector [2:0];
	wire [31:0] level3Carryconnector;
	assign level1Carryconnector[0] = 0;
	assign level2Carryconnector[0] = 0;
	genvar i;
	genvar j;
	generate
		for (i = 0; i < 4; i = i + 1) begin : level1
			wire [127:0] temp1;
			for (j = 0; j < 4; j = j + 1) begin : level1_inner
				assign temp1[j * 32+:32] = x[((4 * i) + j) * 32+:32];
			end
			Compressor_42 level1(
				.x(temp1),
				.cin(level1Carryconnector[i]),
				.cout(level1Carryconnector[i + 1]),
				.c(level1connector[(2 * i) + 1]),
				.s(level1connector[2 * i])
			);
		end
		for (i = 0; i < 2; i = i + 1) begin : level2
			wire [127:0] temp2;
			for (j = 0; j < 4; j = j + 1) begin : level2_inner
				assign temp2[j * 32+:32] = level1connector[(4 * i) + j];
			end
			Compressor_42 level2(
				.x(temp2),
				.cin(level2Carryconnector[i]),
				.cout(level2Carryconnector[i + 1]),
				.c(level2connector[((2 * i) + 1) * 32+:32]),
				.s(level2connector[(2 * i) * 32+:32])
			);
		end
	endgenerate
	Compressor_42 level3(
		.x(level2connector),
		.cin(0),
		.cout(level3Carryconnector),
		.c(level3connector[32+:32]),
		.s(level3connector[0+:32])
	);
	wire [127:0] outOfTreeconnector;
	assign outOfTreeconnector[0+:32] = level1Carryconnector[4];
	assign outOfTreeconnector[32+:32] = 32'b00000000000000000000000000000000;
	assign outOfTreeconnector[64+:32] = 32'b00000000000000000000000000000000;
	assign outOfTreeconnector[96+:32] = level2Carryconnector[1];
	wire [31:0] unused_cout;
	Compressor_42 level3_outOfTree(
		.x(outOfTreeconnector),
		.cin(level3Carryconnector),
		.cout(unused_cout),
		.c(level3connector[96+:32]),
		.s(level3connector[64+:32])
	);
	wire [31:0] cout_fix;
	Compressor_42 level4(
		.x(level3connector),
		.cin(cout_fix),
		.cout(cout_fix),
		.c(c),
		.s(s)
	);
endmodule
