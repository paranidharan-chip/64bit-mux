module mux2_1(
  input [1:0] d_in,
  input sel,
  output reg  out
 );
  always @(*) begin
      if(sel)begin
        out = d_in[1];
      end
      else  begin
        out=d_in[0];
      end
  end
  endmodule
  module mux4_1(
    input [3:0] d_in,

    input [1:0] sel,
    output  out
  );
    wire w1 , w2;
    mux2_1 mux1(.d_in(d_in[1:0]),.sel(sel[0]),.out(w1));

    mux2_1 mux2(.d_in(d_in[3:2]),.sel(sel[0]),.out(w2));

    mux2_1 mux3(.d_in({w2,w1}),.sel(sel[1]),.out(out));

    endmodule
  module mux8x1(
    input [7:0] in,
    input [2:0] sel,
    output out
  );
    wire w3,w4;
    mux4_1 mux1(.d_in(in[3:0]),.sel(sel[1:0]),.out(w3));

    mux4_1 mux2(.d_in(in[7:4]),.sel(sel[1:0]),.out(w4));

    mux2_1 mux3(.d_in({w4,w3}),.sel(sel[2]),.out(out));
  endmodule
  module mux16x1(
    input [15:0] in,
    input [3:0] sel,
    output out
  );
   wire w5,w6;
   mux8x1 mux1(.in(in[7:0]),.sel(sel[2:0]),.out(w5));

   mux8x1 mux2(.in(in[15:8]),.sel(sel[2:0]),.out(w6));

   mux2_1 mux3(.d_in({w6,w5}),.sel(sel[3]),.out(out));
   endmodule
   module mux32x1(
     input [31:0] in,
     input [4:0] sel,
     output out
   );
     wire w7,w8;
     mux16x1 mux1(.in(in[15:0]),.sel(sel[3:0]),.out(w7));
     mux16x1 mux2(.in(in[31:16]),.sel(sel[3:0]),.out(w8));
     mux2_1  mux3(.d_in({w8,w7}),.sel(sel[4]),.out(out));
   endmodule
   module mux64x1(
     input [63:0] in,
     input [5:0] sel,
     output out
   );
     wire w9,w10;
     mux32x1 mux1(.in(in[31:0]),.sel(sel[4:0]),.out(w9));
     mux32x1 mux2(.in(in[63:32]),.sel(sel[4:0]),.out(w10));

     mux2_1 mux3(.d_in({w10,w9}),.sel(sel[5]),.out(out));
     endmodule






