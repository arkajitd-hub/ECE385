module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     SUM,
    output  logic           CO
	 
	 
	 
);
		
		logic [2:0] c;
		
		ripple_cArry_4Bit cA1(.A(A[3:0]), .B(B[3:0]), .Cin(1'B0), .SUM(SUM[3:0]), .CO(c[0]));
		cArry_select_4Bit_slice slice1(.A(A[7:4]), .B(B[7:4]), .Cin(c[0]), .SUM(SUM[7:4]), .CO(c[1]));
		cArry_select_4Bit_slice slice2(.A(A[11:8]), .B(B[11:8]), .Cin(c[1]), .SUM(SUM[11:8]), .CO(c[2]));
		cArry_select_4Bit_slice slice3(.A(A[15:12]), .B(B[15:12]), .Cin(c[2]), .SUM(SUM[15:12]), .CO(CO));
     
endmodule


module cArry_select_4Bit_slice
(
	input logic[3:0] A,B,
	input logic Cin,
	output logic[3:0] SUM,
	output logic CO
	
);

		logic [3:0] s0,s1;
		logic c0,c1;
		
		ripple_cArry_4Bit cA1(.A(A[3:0]), .B(B[3:0]), .Cin(1'B0), .SUM(s0[3:0]), .CO(c0));
		ripple_cArry_4Bit cA2(.A(A[3:0]), .B(B[3:0]), .Cin(1'B1), .SUM(s1[3:0]), .CO(c1));
		mux2X1 ms0(.in1(s0[3:0]), .in2(s1[3:0]), .select(Cin), .out(SUM[3:0]));
		logic_1 L1(.A(c0), .B(c1), .C(Cin), .CO(CO));

endmodule
		
module ripple_cArry_4Bit
(
	input logic [3:0] A,B,
	input logic Cin,
	output logic [3:0] SUM,
	output logic CO

);

		logic c1,c2,c3;
		
		full_Adder_1Bit Bit0(.A(A[0]), .B(B[0]), .Cin(Cin), .SUM(SUM[0]), .CO(c1));
		full_Adder_1Bit Bit1(.A(A[1]), .B(B[1]), .Cin(c1), .SUM(SUM[1]), .CO(c2));
		full_Adder_1Bit Bit2(.A(A[2]), .B(B[2]), .Cin(c2), .SUM(SUM[2]), .CO(c3));
		full_Adder_1Bit Bit3(.A(A[3]), .B(B[3]), .Cin(c3), .SUM(SUM[3]), .CO(CO));

endmodule
		
		

module full_Adder_1Bit
(
		input logic A,B,Cin,
		output logic SUM,CO
		
);

		assign SUM = A ^ B^ Cin;
		assign CO = (A&B) | (B&Cin) | (Cin&A);

endmodule


module mux2X1(in1,in2,select,out);


		input logic [3:0] in1,in2;
		input logic select;
		output logic [3:0] out;
		assign out=(select)?in2:in1;


endmodule


module logic_1
(
	input logic A,B,C,
	output logic CO
);

	assign out1 = B & C;
	assign CO = out1 | A;
	
		
		

endmodule
