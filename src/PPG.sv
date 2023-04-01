module PPG (
    input [15:0] X,
    input [15:0] Y,
    output reg [31:0] PP [15:0]
);
genvar i, j;
for(i=0; i<16; i=i+1) begin
    assign PP[i] = {16'b0, X[15:0] & {16 {Y[i]}}} << i ;
end
endmodule

