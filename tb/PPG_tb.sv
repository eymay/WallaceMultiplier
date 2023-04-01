module PPG_tb ();

reg [15:0] X;
reg [15:0] Y;
wire [31:0] PP [15:0];

integer idx;
integer i;
reg [31:0] inputs;
PPG PPG_inst (
    .X(X),
    .Y(Y),
    .PP(PP)
);

initial begin 
    $dumpfile("PPG.vcd");
    $dumpvars(0, PPG_tb);
    for (idx = 0; idx < 16; idx = idx + 1) $dumpvars(0, PP[idx]);

    for(i = 0; i < 10; i = i + 1) begin
        inputs = 040190218+i;
        $display("inputs = %d, %b", inputs, inputs);
        {X, Y} = inputs;
        #10;
    end
    X = 16'h0007;
    Y = 16'h0003;
    #10;
    X = 16'hFFFF;
    Y = 16'h0003;
    #10;

    X = 16'hF00F;
    Y = 16'hFFFF;
    #10;
$finish;
end
endmodule
