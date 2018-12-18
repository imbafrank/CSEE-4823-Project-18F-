
module lfsr1 ( clk, rst, calc_1, calc_in, agg_out2alu, agg_out_acted );
  output [11:0] agg_out2alu;
  input clk, rst, calc_1, calc_in;
  output agg_out_acted;
  wire   n124, n125, n4, n5, n6, n7, n8, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n121, n122, n123;
  wire   [11:0] alu_out;

  DFFRHQX4TS u_agg_agg_out2alu_reg_9_ ( .D(alu_out[9]), .CK(clk), .RN(n113), 
        .Q(agg_out2alu[9]) );
  DFFSHQX8TS u_agg_agg_out2alu_reg_6_ ( .D(n122), .CK(clk), .SN(n113), .Q(n119) );
  DFFRHQX4TS u_agg_agg_out2alu_reg_8_ ( .D(alu_out[8]), .CK(clk), .RN(n115), 
        .Q(agg_out2alu[8]) );
  DFFRHQX4TS u_agg_agg_out2alu_reg_10_ ( .D(alu_out[10]), .CK(clk), .RN(n115), 
        .Q(agg_out2alu[10]) );
  DFFSHQX8TS u_agg_agg_out2alu_reg_4_ ( .D(n123), .CK(clk), .SN(n114), .Q(n118) );
  DFFSHQX8TS u_agg_agg_out2alu_reg_5_ ( .D(n121), .CK(clk), .SN(n115), .Q(n117) );
  DFFRHQX4TS u_agg_agg_out2alu_reg_7_ ( .D(alu_out[7]), .CK(clk), .RN(n113), 
        .Q(agg_out2alu[7]) );
  DFFRHQX4TS u_agg_agg_out2alu_reg_3_ ( .D(alu_out[3]), .CK(clk), .RN(n114), 
        .Q(agg_out2alu[3]) );
  DFFRHQX4TS u_agg_agg_out2alu_reg_2_ ( .D(alu_out[2]), .CK(clk), .RN(n115), 
        .Q(agg_out2alu[2]) );
  DFFRHQX4TS u_agg_agg_out2alu_reg_0_ ( .D(alu_out[0]), .CK(clk), .RN(n113), 
        .Q(n125) );
  DFFRHQX4TS u_agg_agg_out2alu_reg_1_ ( .D(alu_out[1]), .CK(clk), .RN(n114), 
        .Q(n124) );
  EDFFHQX4TS u_agg_agg_out_acted_reg ( .D(alu_out[11]), .E(n112), .CK(clk), 
        .Q(n116) );
  DFFRHQX1TS u_agg_agg_out2alu_reg_11_ ( .D(alu_out[11]), .CK(clk), .RN(n114), 
        .Q(agg_out2alu[11]) );
  CLKBUFX2TS U4 ( .A(rst), .Y(n40) );
  CLKINVX2TS U5 ( .A(n71), .Y(n72) );
  CLKBUFX2TS U6 ( .A(n104), .Y(n11) );
  INVX1TS U7 ( .A(n125), .Y(n76) );
  NAND2X1TS U8 ( .A(n5), .B(agg_out2alu[9]), .Y(n101) );
  INVX2TS U9 ( .A(n32), .Y(n30) );
  CLKINVX6TS U10 ( .A(n118), .Y(agg_out2alu[4]) );
  INVX4TS U11 ( .A(n29), .Y(n5) );
  INVX6TS U12 ( .A(n29), .Y(n36) );
  INVX2TS U13 ( .A(n29), .Y(n4) );
  INVX6TS U14 ( .A(n23), .Y(n29) );
  CLKINVX1TS U15 ( .A(n62), .Y(n6) );
  NAND2BX4TS U16 ( .AN(n104), .B(n103), .Y(n105) );
  NAND2X1TS U17 ( .A(n4), .B(agg_out2alu[2]), .Y(n7) );
  CLKINVX1TS U18 ( .A(n97), .Y(n37) );
  NOR2X1TS U19 ( .A(n36), .B(agg_out2alu[10]), .Y(n97) );
  BUFX6TS U20 ( .A(calc_in), .Y(n23) );
  CLKAND2X2TS U21 ( .A(n30), .B(agg_out2alu[3]), .Y(n16) );
  NAND2X4TS U22 ( .A(n36), .B(agg_out2alu[2]), .Y(n80) );
  AND2X6TS U23 ( .A(n29), .B(n117), .Y(n53) );
  CLKINVX1TS U24 ( .A(n19), .Y(n8) );
  NOR2X1TS U25 ( .A(n96), .B(n95), .Y(n100) );
  NAND2BX1TS U26 ( .AN(n43), .B(n89), .Y(n91) );
  CLKBUFX2TS U27 ( .A(n124), .Y(agg_out2alu[1]) );
  AOI21X4TS U28 ( .A0(n106), .A1(n89), .B0(n43), .Y(n47) );
  NAND2X8TS U29 ( .A(n42), .B(n41), .Y(n106) );
  NAND2BX2TS U30 ( .AN(n32), .B(agg_out2alu[4]), .Y(n73) );
  INVX1TS U31 ( .A(n104), .Y(n33) );
  NAND2X2TS U32 ( .A(n13), .B(n44), .Y(n104) );
  INVX2TS U33 ( .A(n13), .Y(n43) );
  INVX2TS U34 ( .A(n95), .Y(n45) );
  INVX4TS U35 ( .A(n119), .Y(agg_out2alu[6]) );
  XOR2X2TS U36 ( .A(n47), .B(n46), .Y(alu_out[8]) );
  AOI21X1TS U37 ( .A0(n94), .A1(n56), .B0(n55), .Y(n61) );
  INVX4TS U38 ( .A(n25), .Y(n26) );
  NAND2X1TS U39 ( .A(n102), .B(n37), .Y(n38) );
  NAND2X1TS U40 ( .A(n31), .B(n101), .Y(n14) );
  INVX1TS U41 ( .A(n85), .Y(n15) );
  INVX2TS U42 ( .A(n98), .Y(n31) );
  NOR2X4TS U43 ( .A(agg_out2alu[7]), .B(n5), .Y(n96) );
  INVX2TS U44 ( .A(n117), .Y(agg_out2alu[5]) );
  INVX2TS U45 ( .A(agg_out2alu[7]), .Y(n12) );
  INVX1TS U46 ( .A(n40), .Y(n115) );
  INVX1TS U47 ( .A(n40), .Y(n114) );
  INVX1TS U48 ( .A(n40), .Y(n113) );
  INVX1TS U49 ( .A(n19), .Y(n18) );
  XOR2X4TS U50 ( .A(n39), .B(n38), .Y(alu_out[10]) );
  OAI2BB1X4TS U51 ( .A0N(n8), .A1N(n125), .B0(n83), .Y(n20) );
  CLKBUFX2TS U52 ( .A(n125), .Y(agg_out2alu[0]) );
  AND2X2TS U53 ( .A(n48), .B(n31), .Y(n35) );
  AND2X4TS U54 ( .A(n100), .B(n99), .Y(n17) );
  NOR2X8TS U55 ( .A(n28), .B(n10), .Y(n41) );
  NAND2X2TS U56 ( .A(n65), .B(n63), .Y(n55) );
  NOR2X6TS U57 ( .A(agg_out2alu[8]), .B(n30), .Y(n95) );
  NAND2X4TS U58 ( .A(n70), .B(n73), .Y(n10) );
  NOR2X4TS U59 ( .A(n95), .B(n96), .Y(n48) );
  INVX8TS U60 ( .A(n23), .Y(n32) );
  INVX12TS U61 ( .A(n32), .Y(n107) );
  XNOR2X2TS U62 ( .A(n90), .B(n91), .Y(alu_out[7]) );
  NAND2X6TS U63 ( .A(n27), .B(n26), .Y(n42) );
  NOR2X4TS U64 ( .A(agg_out2alu[3]), .B(n23), .Y(n69) );
  NAND2BX2TS U65 ( .AN(n12), .B(n5), .Y(n13) );
  NOR2X8TS U66 ( .A(agg_out2alu[4]), .B(n107), .Y(n71) );
  AOI21X4TS U67 ( .A0(n90), .A1(n48), .B0(n11), .Y(n49) );
  AOI21X4TS U68 ( .A0(n90), .A1(n35), .B0(n34), .Y(n39) );
  XOR2X4TS U69 ( .A(n49), .B(n14), .Y(alu_out[9]) );
  INVX2TS U70 ( .A(n77), .Y(n85) );
  NAND2X4TS U71 ( .A(n65), .B(n58), .Y(n28) );
  NOR2X4TS U72 ( .A(n53), .B(n57), .Y(n24) );
  NOR2X1TS U73 ( .A(n62), .B(n54), .Y(n56) );
  INVX2TS U74 ( .A(n116), .Y(agg_out_acted) );
  INVX2TS U75 ( .A(calc_1), .Y(n19) );
  INVX2TS U76 ( .A(n124), .Y(n21) );
  NAND2X2TS U77 ( .A(n23), .B(n19), .Y(n83) );
  NAND2X2TS U78 ( .A(n32), .B(n21), .Y(n77) );
  NAND2X4TS U79 ( .A(n77), .B(n20), .Y(n51) );
  NOR2X4TS U80 ( .A(agg_out2alu[2]), .B(n107), .Y(n78) );
  NAND2X4TS U81 ( .A(n107), .B(n124), .Y(n86) );
  NAND2X4TS U82 ( .A(n86), .B(n80), .Y(n22) );
  CLKINVX6TS U83 ( .A(n22), .Y(n50) );
  OAI21X4TS U84 ( .A0(n51), .A1(n78), .B0(n50), .Y(n27) );
  NOR2X4TS U85 ( .A(n107), .B(agg_out2alu[6]), .Y(n57) );
  NOR2X4TS U86 ( .A(n71), .B(n69), .Y(n52) );
  NAND2X4TS U87 ( .A(n24), .B(n52), .Y(n25) );
  NAND2X2TS U88 ( .A(n36), .B(agg_out2alu[3]), .Y(n70) );
  NAND2X2TS U89 ( .A(n36), .B(agg_out2alu[5]), .Y(n65) );
  NAND2X2TS U90 ( .A(n4), .B(agg_out2alu[6]), .Y(n58) );
  NAND2X4TS U91 ( .A(n42), .B(n41), .Y(n90) );
  NOR2X2TS U92 ( .A(n30), .B(agg_out2alu[9]), .Y(n98) );
  NAND2X2TS U93 ( .A(n4), .B(agg_out2alu[8]), .Y(n44) );
  NAND2X1TS U94 ( .A(n101), .B(n33), .Y(n34) );
  NAND2X1TS U95 ( .A(agg_out2alu[10]), .B(n30), .Y(n102) );
  INVX2TS U96 ( .A(n40), .Y(n112) );
  INVX2TS U97 ( .A(n96), .Y(n89) );
  NAND2X1TS U98 ( .A(n45), .B(n44), .Y(n46) );
  OAI21X2TS U99 ( .A0(n51), .A1(n78), .B0(n50), .Y(n94) );
  CLKINVX1TS U100 ( .A(n52), .Y(n62) );
  CLKINVX1TS U101 ( .A(n53), .Y(n66) );
  CLKINVX1TS U102 ( .A(n66), .Y(n54) );
  AND2X2TS U103 ( .A(n73), .B(n70), .Y(n63) );
  CLKINVX1TS U104 ( .A(n57), .Y(n59) );
  NAND2X1TS U105 ( .A(n59), .B(n58), .Y(n60) );
  XNOR2X1TS U106 ( .A(n61), .B(n60), .Y(n122) );
  INVX2TS U107 ( .A(n63), .Y(n64) );
  AOI21X1TS U108 ( .A0(n94), .A1(n6), .B0(n64), .Y(n68) );
  NAND2X1TS U109 ( .A(n65), .B(n66), .Y(n67) );
  XNOR2X1TS U110 ( .A(n68), .B(n67), .Y(n121) );
  INVX2TS U111 ( .A(n69), .Y(n92) );
  AOI21X1TS U112 ( .A0(n94), .A1(n92), .B0(n16), .Y(n75) );
  NAND2X1TS U113 ( .A(n73), .B(n72), .Y(n74) );
  XNOR2X1TS U114 ( .A(n75), .B(n74), .Y(n123) );
  OA21X1TS U115 ( .A0(n19), .A1(n76), .B0(n83), .Y(n87) );
  OAI21X1TS U116 ( .A0(n87), .A1(n85), .B0(n86), .Y(n82) );
  CLKINVX1TS U117 ( .A(n78), .Y(n79) );
  NAND2X1TS U118 ( .A(n7), .B(n79), .Y(n81) );
  XNOR2X1TS U119 ( .A(n82), .B(n81), .Y(alu_out[2]) );
  NAND2XLTS U120 ( .A(n18), .B(n83), .Y(n84) );
  XNOR2X1TS U121 ( .A(agg_out2alu[0]), .B(n84), .Y(alu_out[0]) );
  NAND2X1TS U122 ( .A(n86), .B(n15), .Y(n88) );
  XOR2X1TS U123 ( .A(n88), .B(n87), .Y(alu_out[1]) );
  NAND2X1TS U124 ( .A(n92), .B(n70), .Y(n93) );
  XNOR2X1TS U125 ( .A(n94), .B(n93), .Y(alu_out[3]) );
  NOR2X1TS U126 ( .A(n98), .B(n97), .Y(n99) );
  AND2X4TS U127 ( .A(n102), .B(n101), .Y(n103) );
  AOI21X4TS U128 ( .A0(n106), .A1(n17), .B0(n105), .Y(n111) );
  OR2X2TS U129 ( .A(agg_out2alu[11]), .B(n4), .Y(n109) );
  NAND2X1TS U130 ( .A(n5), .B(agg_out2alu[11]), .Y(n108) );
  NAND2X2TS U131 ( .A(n109), .B(n108), .Y(n110) );
  XOR2X4TS U132 ( .A(n111), .B(n110), .Y(alu_out[11]) );
endmodule

