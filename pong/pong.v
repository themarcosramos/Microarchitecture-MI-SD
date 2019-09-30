module pong(clock_50MHz, KEY, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B, LCD_D, LCD_EN, LCD_RS, LCD_RW,ADC_DOUT, ADC_CNVST, ADC_CS_N, ADC_REFSEL, ADC_SCLK, ADC_SD, ADC_UB,ADC_SEL);

	input clock_50MHz;
	input [11:0] KEY;
	input [1:0]ADC_DOUT;
	
	output ADC_CNVST;
	output ADC_CS_N;
	output ADC_REFSEL;
	output ADC_SCLK;
	output ADC_SD;
	output ADC_UB;
	output ADC_SEL;
	output VGA_HS;
	output VGA_VS;
	output [3:0] VGA_R;
	output [3:0] VGA_G;
	output [3:0] VGA_B;
	output [7:0] LCD_D;
	output LCD_EN;
	output LCD_RS;
	output LCD_RW;
	
	wire [9:0] x1;
	wire [9:0] y1;
	
	wire [9:0] x2;
	wire [9:0] y2;
	
	wire [9:0] xb;
	wire [9:0] yb;
	
	wire busy;
	wire [7:0] player1;
	wire [7:0] player2;
	
	wire [1:0] rnd;
	
	vgaDriver vgaDriver(
		.clock_50MHz(clock_50MHz),
		.rst(KEY[0]),
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.x1(x1),
		.y1(y1),
		.x2(x2),
		.y2(y2),
		.xb(xb),
		.yb(yb)
	);
	
	
    nios nios (
        .busy_export     (busy),     //     busy.export
        .bx_export       (xb),       //       bx.export
        .by_export       (yb),       //       by.export
        .clk_clk         (clock_50MHz),         //      clk.clk
        .lcd_out_rs      (LCD_RS),      //  lcd_out.rs
        .lcd_out_rw      (LCD_RW),      //         .rw
        .lcd_out_en      (LCD_EN),      //         .en
        .lcd_out_db      (LCD_D),      //         .db
        .p1x_export      (x1),      //      p1x.export
        .p1y_export      (y1),      //      p1y.export
        .p2x_export      (x2),      //      p2x.export
        .p2y_export      (y2),      //      p2y.export
        .player1_export  (player1),  //  player1.export
        .player_2_export (player2), // player_2.export
        .reset_reset_n   (~KEY[0]),   //    reset.reset_n
        .start_export    (KEY[11]),    //    start.export
        .random_export   (rnd)    //   random.export
    );
	
	
	random random (
		.clk(clock_50MHz),
		.out(rnd)
	);
	
	AD AD(
		.RESET_n(~KEY[0]), 
		.CLOCK_50MHz(clock_50MHz), 
		.ADC_OUT(ADC_DOUT), 
		.ADC_CNVST(ADC_CNVST), 
		.ADC_CS_N(ADC_CS_N), 
		.ADC_REFSEL(ADC_REFSEL), 
		.ADC_SCLK(ADC_SCLK), 
		.ADC_SD(ADC_SD), 
		.ADC_UB(ADC_UB),
		.ADC_SEL(ADC_SEL),
		.BUSY(busy),
		.DATA_AD0(player1),
		.DATA_AD1(player2)
	);

endmodule