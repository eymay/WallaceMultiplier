module Compressor_42(
    input [31:0] x [3:0],
    input [31:0] cin,
    output [31:0] cout,
    output [31:0] c,
    output [31:0] s
    );
    wire [31:0] sum_fa1;
    FA #(.N(32)) fa1 (.A(x[0]), .B(x[1]), .Cin(x[2]), .S(sum_fa1), .Cout(cout));
    FA #(.N(32)) fa2 (.A(x[3]), .B(sum_fa1), .Cin(cin), .S(s), .Cout(c));

endmodule
