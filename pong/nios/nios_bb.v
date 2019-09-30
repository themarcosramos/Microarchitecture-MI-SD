
module nios (
	busy_export,
	bx_export,
	by_export,
	clk_clk,
	lcd_out_rs,
	lcd_out_rw,
	lcd_out_en,
	lcd_out_db,
	p1x_export,
	p1y_export,
	p2x_export,
	p2y_export,
	player1_export,
	player_2_export,
	reset_reset_n,
	start_export,
	random_export);	

	input		busy_export;
	output	[9:0]	bx_export;
	output	[9:0]	by_export;
	input		clk_clk;
	output		lcd_out_rs;
	output		lcd_out_rw;
	output		lcd_out_en;
	output	[7:0]	lcd_out_db;
	output	[9:0]	p1x_export;
	output	[9:0]	p1y_export;
	output	[9:0]	p2x_export;
	output	[9:0]	p2y_export;
	input	[7:0]	player1_export;
	input	[7:0]	player_2_export;
	input		reset_reset_n;
	input		start_export;
	input	[1:0]	random_export;
endmodule
