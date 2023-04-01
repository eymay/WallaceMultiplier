module RCA #(
    parameter N = 32
) (
    input Cin, 
    input [N-1:0] A, 
    input [N-1:0] B,
    output Cout,
    output [N-1:0] S
);
    
    wire [N:0] carry_connector;
    wire [N-1:0] B_xor;
    assign carry_connector[0] = Cin;

    genvar i;
    generate
    for (i = 0; i< N; i= i+ 1) begin: ripple
       FA #(.N(1)) full_adder(.A(A[i]), .B(B[i]), .Cin(carry_connector[i]),
         .S(S[i]), .Cout(carry_connector[i+1]));
    end
    endgenerate

    assign Cout = carry_connector[N];
endmodule
