module PPG (
	X,
	Y,
	PP
);
	input [15:0] X;
	input [15:0] Y;
	output reg [511:0] PP;
	genvar i;
	genvar j;
	generate
		for (i = 0; i < 16; i = i + 1) begin : genblk1
			wire [32:1] sv2v_tmp_440D0;
			assign sv2v_tmp_440D0 = {16'b0000000000000000, X[15:0] & {16 {Y[i]}}} << i;
			always @(*) PP[i * 32+:32] = sv2v_tmp_440D0;
		end
	endgenerate
endmodule
