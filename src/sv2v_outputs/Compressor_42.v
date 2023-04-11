module Compressor_42 (
	x,
	cin,
	cout,
	c,
	s
);
	input [127:0] x;
	input [31:0] cin;
	output wire [31:0] cout;
	output wire [31:0] c;
	output wire [31:0] s;
	wire [31:0] sum_fa1;
	FA #(.N(32)) fa1(
		.A(x[0+:32]),
		.B(x[32+:32]),
		.Cin(x[64+:32]),
		.S(sum_fa1),
		.Cout(cout)
	);
	FA #(.N(32)) fa2(
		.A(x[96+:32]),
		.B(sum_fa1),
		.Cin(cin),
		.S(s),
		.Cout(c)
	);
endmodule
