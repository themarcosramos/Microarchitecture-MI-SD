	component nios is
		port (
			busy_export     : in  std_logic                    := 'X';             -- export
			bx_export       : out std_logic_vector(9 downto 0);                    -- export
			by_export       : out std_logic_vector(9 downto 0);                    -- export
			clk_clk         : in  std_logic                    := 'X';             -- clk
			lcd_out_rs      : out std_logic;                                       -- rs
			lcd_out_rw      : out std_logic;                                       -- rw
			lcd_out_en      : out std_logic;                                       -- en
			lcd_out_db      : out std_logic_vector(7 downto 0);                    -- db
			p1x_export      : out std_logic_vector(9 downto 0);                    -- export
			p1y_export      : out std_logic_vector(9 downto 0);                    -- export
			p2x_export      : out std_logic_vector(9 downto 0);                    -- export
			p2y_export      : out std_logic_vector(9 downto 0);                    -- export
			player1_export  : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			player_2_export : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			reset_reset_n   : in  std_logic                    := 'X';             -- reset_n
			start_export    : in  std_logic                    := 'X';             -- export
			random_export   : in  std_logic_vector(1 downto 0) := (others => 'X')  -- export
		);
	end component nios;

	u0 : component nios
		port map (
			busy_export     => CONNECTED_TO_busy_export,     --     busy.export
			bx_export       => CONNECTED_TO_bx_export,       --       bx.export
			by_export       => CONNECTED_TO_by_export,       --       by.export
			clk_clk         => CONNECTED_TO_clk_clk,         --      clk.clk
			lcd_out_rs      => CONNECTED_TO_lcd_out_rs,      --  lcd_out.rs
			lcd_out_rw      => CONNECTED_TO_lcd_out_rw,      --         .rw
			lcd_out_en      => CONNECTED_TO_lcd_out_en,      --         .en
			lcd_out_db      => CONNECTED_TO_lcd_out_db,      --         .db
			p1x_export      => CONNECTED_TO_p1x_export,      --      p1x.export
			p1y_export      => CONNECTED_TO_p1y_export,      --      p1y.export
			p2x_export      => CONNECTED_TO_p2x_export,      --      p2x.export
			p2y_export      => CONNECTED_TO_p2y_export,      --      p2y.export
			player1_export  => CONNECTED_TO_player1_export,  --  player1.export
			player_2_export => CONNECTED_TO_player_2_export, -- player_2.export
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --    reset.reset_n
			start_export    => CONNECTED_TO_start_export,    --    start.export
			random_export   => CONNECTED_TO_random_export    --   random.export
		);

