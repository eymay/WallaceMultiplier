module PPA_tb ();

reg [31:0] PP [15:0];
wire [31:0] S;
wire [31:0] C;

integer idx;
integer i,j;
reg [31:0] inputs;
PPA PPA_inst (
    .x(PP),
    .s(S),
    .c(C)
);

initial begin 
    $dumpfile("PPA.vcd");
    $dumpvars(0, PPA_tb);
    for (idx = 0; idx < 16; idx = idx + 1) $dumpvars(0, PP[idx]);

    for(i = 0; i < 10; i = i + 1) begin
        for(j = 0; j < 16; j = j + 1) begin
            inputs = 040190218+ i + j;
            $display("inputs = %d, %b", inputs, inputs);
            PP[j] = inputs;
        end
        #20;
    end
$finish;
end
endmodule
