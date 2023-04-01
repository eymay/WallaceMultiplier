module Compressor_42_tb();

reg [31:0] x [3:0];
reg  [31:0] cin;
wire [31:0] cout;
wire [31:0] c;
wire [31:0] s;

integer i, j, idx;
reg [31:0] inputs;
Compressor_42 compressor_42 (.x(x), .cin(cin), .cout(cout), .c(c), .s(s));

initial begin 
    $dumpfile("Compressor_42.vcd");
    $dumpvars(0, Compressor_42_tb);
    for (idx = 0; idx < 4; idx = idx + 1) $dumpvars(0, x[idx]);

    for(i = 0; i < 10; i = i + 1) begin
        inputs = 040190218 + i + 5;
        cin = inputs;
        for(j = 0; j < 4; j = j + 1) begin
            inputs = 040190218+ i + j;
            $display("inputs = %d, %b", inputs, inputs);
            x[j] = inputs;
        end
        #10;
    end
    
    cin = 32'hFFFFFFFF;
    x[0] = 32'hFFFFFFFF;
    x[1] = 32'hFFFFFFFF;
    x[2] = 32'hFFFFFFFF;
    x[3] = 32'hFFFFFFFF;
    #10;

$finish;
end

endmodule
