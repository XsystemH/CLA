module pre_1_adder(
  input ain,
  input bin,
  input cin,

  output SO,
  output Gi,
  output Pi
  );

  assign Gi = ain & bin;
  assign Pi = ain | bin;
  
  assign SO = ain ^ bin ^ cin;
    
endmodule //pre_1_adder

module cla_4(
  input [3:0] P,
  input [3:0] G,
  input cin,

  output [4:1] Ci,
  output Gm,
  output Pm
  );

  assign Ci[1] = G[0]|P[0]&cin;
  assign Ci[2] = G[1]|P[1]&G[0]|P[1]&P[0]&cin;
  assign Ci[3] = G[2]|P[2]&G[1]|P[2]&P[1]&G[0]|P[2]&P[1]&P[0]&cin;
	assign Ci[4] = G[3]|P[3]&G[2]|P[3]&P[2]&G[1]|P[3]&P[2]&P[1]&G[0]|P[3]&P[2]&P[1]&P[0]&cin;

  assign Gm = G[3]|P[3]&G[2]|P[3]&P[2]&G[1]|P[3]&P[2]&P[1]&G[0];
  assign Pm = P[3]&P[2]&P[1]&P[0];
    
endmodule //cla_4

module top_module(
  input [3:0] ain,
  input [3:0] bin,
  input cin,

  output [3:0] SO,
  output Pm,
  output Gm,
  output CO
  );

  wire [4:1] CI;
  wire [3:0] Pi;
  wire [3:0] Gi;

pre_1_adder a0(
  .ain (ain[0]),
  .bin (bin[0]),
  .cin (cin),

  .SO (SO[0]),
  .Gi (Gi[0]),
  .Pi (Pi[0])
  );

pre_1_adder a1(
  .ain (ain[1]),
  .bin (bin[1]),
  .cin (CI[1]),

  .SO (SO[1]),
  .Gi (Gi[1]),
  .Pi (Pi[1])
  );

pre_1_adder a2(
  .ain (ain[2]),
  .bin (bin[2]),
  .cin (CI[2]),

  .SO (SO[2]),
  .Gi (Gi[2]),
  .Pi (Pi[2])
  );

pre_1_adder a3(
  .ain (ain[3]),
  .bin (bin[3]),
  .cin (CI[3]),

  .SO (SO[3]),
  .Gi (Gi[3]),
  .Pi (Pi[3])
  );

cla_4 cla(
  .P (Pi),
  .G (Gi),
  .cin (cin),

  .Ci (CI),
  .Gm (Gm),
  .Pm (Pm)
  );

  assign CO = CI[4];

endmodule // top_module