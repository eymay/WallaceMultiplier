module MUL_tb();

reg [15:0] X;
reg [15:0] Y;

wire [31:0] P;

MUL MUL0(
    .X(X),
    .Y(Y),
    .P(P)
);

//10 random inputs for X and Y
//Check the output P is correct
initial begin
    $dumpfile("MUL.vcd");
    $dumpvars(0, MUL_tb);
    for (int i = 0; i < 100000; i = i + 1) begin
        X = $random;
        Y = $random;
        #10;
        $display("X = %h, Y = %h, P = %h", X, Y, P);
        //if P is not equal to X*Y, then the test fails
        if (P != X*Y) begin
            $display("Test failed");
        end

    end
$finish;
end
endmodule
