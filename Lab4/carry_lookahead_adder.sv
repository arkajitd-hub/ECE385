module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     SUM,
    output  logic           CO,
	 input 	logic 			 Cin
	 );
	 
	 logic c1,c2,c3;
	 
	 look_ahead_4_bits(.A(A[3:0]), .B(B[3:0]), .Cin(Cin), .SUM(SUM[3:0]), .CO(c1));
	 look_ahead_4_bits(.A(A[7:4]), .B(B[7:4]), .Cin(c1), .SUM(SUM[7:4]), .CO(c2));
	 look_ahead_4_bits(.A(A[11:8]), .B(B[11:8]), .Cin(c2), .SUM(SUM[11:8]), .CO(c3));
	 look_ahead_4_bits(.A(A[15:12]), .B(B[15:12]), .Cin(c3), .SUM(SUM[15:12]), .CO(CO));


    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     
endmodule

module look_ahead_4_bits(A,B, Cin, SUM, CO);
input [3:0] A,B;
input Cin;
output logic [3:0] SUM;
output CO;

wire [3:0] p,g,c;

assign p[0] = A[0]^B[0];
assign p[1] = A[1]^B[1];
assign p[2] = A[2]^B[2];
assign p[3] = A[3]^B[3];
assign g[0] = A[0]&B[0];
assign g[1] = A[1]&B[1];
assign g[2] = A[2]&B[2];
assign g[3] = A[3]&B[3];

assign c[0] = Cin;
assign c[1] = (g[0] | p[0]&c[0]);
assign c[2] = (g[1] | p[1]&c[1]);
assign c[3] = (g[2] | p[2]&c[2]);
assign CO = (g[3] | p[3]&c[3]);
assign SUM[0] = p[0] ^ c[0];
assign SUM[1] = p[1] ^ c[1];
assign SUM[2] = p[2] ^ c[2];
assign SUM[3] = p[3] ^ c[3];

endmodule
