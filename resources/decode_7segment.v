module decode_7segment (decimal, display);
  input [3:0] decimal;
  output [6:0] display;

/*
The binary encoded decimal digit is contained in decimal[0] to decimal[3].
Each element of display drives one segment of the output.


Boolean operation symbols:
   & = AND   e.g. (A & B)
   | = OR    e.g. (A | B)
   ~ = NOT   e.g. ( ~A)
*/

/* These are not correct...*/
assign display[0] = decimal[0];
assign display[1] = decimal[1];
assign display[2] = decimal[2];
assign display[3] = decimal[3];
assign display[4] = decimal[0] & decimal[1];
assign display[5] = decimal[3] | decimal[2];
assign display[6] = decimal[3] ^ decimal[3];

endmodule
