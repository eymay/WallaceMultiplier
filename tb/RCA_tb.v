module RCA_tb();

reg [31:0] A;
reg [31:0] B;
reg Cin;
wire [31:0] S;
wire Cout;

RCA #(.N(32)) rca(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
reg [31:0] input_A;
reg [31:0] input_B;
integer i;
initial begin
    $dumpfile("RCA.vcd");
    $dumpvars(0, RCA_tb);
    Cin = 0;
    for(i = 0; i < 10; i = i + 1) begin
            input_A = 040190218+ i + 6;
            input_B = 040190218+ i + 7;
            A = input_A[31:0];
            B = input_B[31:0];
        #20;
    end
$finish;
end

endmodule
