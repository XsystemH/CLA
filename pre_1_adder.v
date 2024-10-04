module pre_1_adder(
  input ain,
  input bin,
  input cin,

  output SO,
  output Gi,
  output Pi,
  );

  assign Gi = ain & bin;
  assign Pi = ain | bin;
  
  assign SO = ain ^ bin ^ cin;
    
endmodule //pre_1_adder

