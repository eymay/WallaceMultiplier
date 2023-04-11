/* verilator lint_off WIDTH */
module FA #(
    parameter N = 32
)(
    input [N-1:0] A,
    input [N-1:0] B,
    input [N-1:0] Cin,
    output [N-1:0] S,
    output [N-1:0] Cout
    );
    
assign {Cout, S} = A + B + Cin;

endmodule
