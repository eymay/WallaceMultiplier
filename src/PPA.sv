module PPA(
    input [31:0] x [15:0],
    output [31:0] s,
    output [31:0] c
);

wire [31:0] level1connector [7:0];
wire [31:0] level2connector [3:0];
wire [31:0] level3connector [3:0];

wire [31:0] level1Carryconnector [4:0];
wire [31:0] level2Carryconnector [2:0];
wire [31:0] level3Carryconnector ;


/*
Compressor_42 level1_1(
    .x(x[3:0]),
    .cin(0),
    .cout(carryconnector[0]),
    .c(level1connector[1]),
    .s(level1connector[0])
    );
*/
assign level1Carryconnector[0] = 0;
assign level2Carryconnector[0] = 0;
genvar i, j;
generate 
for(i = 0; i < 4; i = i + 1) begin : level1
wire [31:0] temp1 [3:0];
    for(j= 0; j < 4; j = j + 1) begin : level1_inner
        assign temp1[j] = x[4*i + j];
    end
    Compressor_42 level1(
        .x(temp1),
        .cin(level1Carryconnector[i]),
        .cout(level1Carryconnector[i+1]),
        .c(level1connector[2*i+1]),
        .s(level1connector[2*i])
        );
end

for(i = 0; i < 2; i = i + 1) begin : level2
wire [31:0] temp2 [3:0];
    for(j= 0; j < 4; j = j + 1) begin : level2_inner
        assign temp2[j] = level1connector[4*i + j];
    end
    Compressor_42 level2(
        .x(temp2),
        .cin(level2Carryconnector[i]),
        .cout(level2Carryconnector[i+1]),
        .c(level2connector[2*i+1]),
        .s(level2connector[2*i])
        );
end
endgenerate

//level 3
Compressor_42 level3(
    .x(level2connector),
    .cin(0),
    .cout(level3Carryconnector),
    .c(level3connector[1]),
    .s(level3connector[0])
    );

wire [31:0] outOfTreeconnector [3:0];
assign outOfTreeconnector[0] = level1Carryconnector[4];
assign outOfTreeconnector[1] = 32'b0;
assign outOfTreeconnector[2] = 32'b0;
assign outOfTreeconnector[3] = level2Carryconnector[1];

wire [31:0] unused_cout;
Compressor_42 level3_outOfTree(
    .x(outOfTreeconnector),
    .cin(level3Carryconnector),
    .cout(unused_cout),
    .c(level3connector[3]),
    .s(level3connector[2])
    );

//level 4 
//
wire [31:0] cout_fix;
Compressor_42 level4(
    .x(level3connector),
    .cin(cout_fix),
    .cout(cout_fix),
    .c(c),
    .s(s)
    );
endmodule
