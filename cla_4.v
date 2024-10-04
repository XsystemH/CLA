module cla_4(
  input [3:0] P,
  input [3:0] G,
  input cin,

  output [4:1] Ci,
  output Gm,
  output Pm
  );

  assign Ci[1] = G[0]|p[0]&cin;
  assign Ci[2] = G[1]|P[1]&G[0]|P[1]&P[0]&cin;
  assign Ci[3] = G[2]|P[2]&G[1]|P[2]&P[1]&G[0]|P[2]&P[1]&P[0]&cin;
	assign Ci[4] = G[3]|P[3]&G[2]|P[3]&P[2]&G[1]|P[3]&P[2]&P[1]&G[0]|P[3]&P[2]&P[1]&P[0]&cin;

  assign Gm = G[3]|P[3]&G[2]|P[3]&P[2]&G[1]|P[3]&P[2]&P[1]&G[0];
  assign Pm = P[3]&P[2]&P[1]&P[0];
    
endmodule //cla_4
