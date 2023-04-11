module MUL (
	X,
	Y,
	P
);
	input [15:0] X;
	input [15:0] Y;
	output wire [31:0] P;
	wire [511:0] PP;
	PPG PPG0(
		.X(X),
		.Y(Y),
		.PP(PP)
	);
	wire [31:0] s;
	wire [31:0] c;
	PPA PPA0(
		.x(PP),
		.s(s),
		.c(c)
	);
	wire cout;
	RCA RCA0(
		.Cin(1'b0),
		.A(s),
		.B(c),
		.S(P),
		.Cout(cout)
	);
endmodule
