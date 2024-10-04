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

module pre_4_adder(
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

endmodule // pre_4_adder

module pre_16_adder(
  input [15:0] a,
  input [15:0] b,
  input cin,

  output [15:0] sum,
  output carry
  );

  wire [3:0] Gi;
  wire [3:0] Pi;
  wire [4:1] CI;

pre_4_adder a0(
  .ain (a[3:0]),
  .bin (b[3:0]),
  .cin (cin),

  .SO (sum[3:0]),
  .Gm (Gi[0]),
  .Pm (Pi[0]),
  .CO (CI[1])
  );

pre_4_adder a1(
  .ain (a[7:4]),
  .bin (b[7:4]),
  .cin (CI[1]),

  .SO (sum[7:4]),
  .Gm (Gi[1]),
  .Pm (Pi[1]),
  .CO (CI[2])
  );

pre_4_adder a2(
  .ain (a[11:8]),
  .bin (b[11:8]),
  .cin (CI[2]),

  .SO (sum[11:8]),
  .Gm (Gi[2]),
  .Pm (Pi[2]),
  .CO (CI[3])
  );

pre_4_adder a3(
  .ain (a[15:12]),
  .bin (b[15:12]),
  .cin (CI[3]),

  .SO (sum[15:12]),
  .Gm (Gi[3]),
  .Pm (Pi[3]),
  .CO (carry)
  );

cla_4 cla (
  .P (Pi),
  .G (Gi),
  .cin (cin),

  .Ci (CI)
);
    
endmodule //pre_16_adder

module Add(
  input [31:0] a,
  input [31:0] b,

  output [31:0] sum,
  output carry
  );

  wire carry_internal;

  pre_16_adder a0(
    .a (a[15:0]),
    .b (b[15:0]),
    .cin (1'b0),

    .sum (sum[15:0]),
    .carry (carry_internal)
  );

  pre_16_adder a1(
    .a (a[31:16]),
    .b (b[31:16]),
    .cin (carry_internal),

    .sum (sum[31:16]),
    .carry (carry)
  );

endmodule // Add