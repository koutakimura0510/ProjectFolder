-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity affine_scale_control_s_axi is
generic (
    C_S_AXI_ADDR_WIDTH    : INTEGER := 8;
    C_S_AXI_DATA_WIDTH    : INTEGER := 32);
port (
    ACLK                  :in   STD_LOGIC;
    ARESET                :in   STD_LOGIC;
    ACLK_EN               :in   STD_LOGIC;
    AWADDR                :in   STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH-1 downto 0);
    AWVALID               :in   STD_LOGIC;
    AWREADY               :out  STD_LOGIC;
    WDATA                 :in   STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
    WSTRB                 :in   STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH/8-1 downto 0);
    WVALID                :in   STD_LOGIC;
    WREADY                :out  STD_LOGIC;
    BRESP                 :out  STD_LOGIC_VECTOR(1 downto 0);
    BVALID                :out  STD_LOGIC;
    BREADY                :in   STD_LOGIC;
    ARADDR                :in   STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH-1 downto 0);
    ARVALID               :in   STD_LOGIC;
    ARREADY               :out  STD_LOGIC;
    RDATA                 :out  STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
    RRESP                 :out  STD_LOGIC_VECTOR(1 downto 0);
    RVALID                :out  STD_LOGIC;
    RREADY                :in   STD_LOGIC;
    interrupt             :out  STD_LOGIC;
    srcin                 :out  STD_LOGIC_VECTOR(63 downto 0);
    dstin                 :out  STD_LOGIC_VECTOR(63 downto 0);
    dstout                :out  STD_LOGIC_VECTOR(63 downto 0);
    mapchip_maxwidth      :out  STD_LOGIC_VECTOR(31 downto 0);
    mapchip_maxheight     :out  STD_LOGIC_VECTOR(31 downto 0);
    mapchip_draw_xsize    :out  STD_LOGIC_VECTOR(31 downto 0);
    mapchip_draw_ysize    :out  STD_LOGIC_VECTOR(31 downto 0);
    xstart_pos            :out  STD_LOGIC_VECTOR(31 downto 0);
    ystart_pos            :out  STD_LOGIC_VECTOR(31 downto 0);
    frame_size            :out  STD_LOGIC_VECTOR(31 downto 0);
    alpha                 :out  STD_LOGIC_VECTOR(7 downto 0);
    id                    :out  STD_LOGIC_VECTOR(31 downto 0);
    a                     :out  STD_LOGIC_VECTOR(31 downto 0);
    b                     :out  STD_LOGIC_VECTOR(31 downto 0);
    c                     :out  STD_LOGIC_VECTOR(31 downto 0);
    d                     :out  STD_LOGIC_VECTOR(31 downto 0);
    m                     :out  STD_LOGIC_VECTOR(31 downto 0);
    n                     :out  STD_LOGIC_VECTOR(31 downto 0);
    ap_start              :out  STD_LOGIC;
    ap_done               :in   STD_LOGIC;
    ap_ready              :in   STD_LOGIC;
    ap_idle               :in   STD_LOGIC
);
end entity affine_scale_control_s_axi;

-- ------------------------Address Info-------------------
-- 0x00 : Control signals
--        bit 0  - ap_start (Read/Write/COH)
--        bit 1  - ap_done (Read/COR)
--        bit 2  - ap_idle (Read)
--        bit 3  - ap_ready (Read)
--        bit 7  - auto_restart (Read/Write)
--        others - reserved
-- 0x04 : Global Interrupt Enable Register
--        bit 0  - Global Interrupt Enable (Read/Write)
--        others - reserved
-- 0x08 : IP Interrupt Enable Register (Read/Write)
--        bit 0  - enable ap_done interrupt (Read/Write)
--        bit 1  - enable ap_ready interrupt (Read/Write)
--        others - reserved
-- 0x0c : IP Interrupt Status Register (Read/TOW)
--        bit 0  - ap_done (COR/TOW)
--        bit 1  - ap_ready (COR/TOW)
--        others - reserved
-- 0x10 : Data signal of srcin
--        bit 31~0 - srcin[31:0] (Read/Write)
-- 0x14 : Data signal of srcin
--        bit 31~0 - srcin[63:32] (Read/Write)
-- 0x18 : reserved
-- 0x1c : Data signal of dstin
--        bit 31~0 - dstin[31:0] (Read/Write)
-- 0x20 : Data signal of dstin
--        bit 31~0 - dstin[63:32] (Read/Write)
-- 0x24 : reserved
-- 0x28 : Data signal of dstout
--        bit 31~0 - dstout[31:0] (Read/Write)
-- 0x2c : Data signal of dstout
--        bit 31~0 - dstout[63:32] (Read/Write)
-- 0x30 : reserved
-- 0x34 : Data signal of mapchip_maxwidth
--        bit 31~0 - mapchip_maxwidth[31:0] (Read/Write)
-- 0x38 : reserved
-- 0x3c : Data signal of mapchip_maxheight
--        bit 31~0 - mapchip_maxheight[31:0] (Read/Write)
-- 0x40 : reserved
-- 0x44 : Data signal of mapchip_draw_xsize
--        bit 31~0 - mapchip_draw_xsize[31:0] (Read/Write)
-- 0x48 : reserved
-- 0x4c : Data signal of mapchip_draw_ysize
--        bit 31~0 - mapchip_draw_ysize[31:0] (Read/Write)
-- 0x50 : reserved
-- 0x54 : Data signal of xstart_pos
--        bit 31~0 - xstart_pos[31:0] (Read/Write)
-- 0x58 : reserved
-- 0x5c : Data signal of ystart_pos
--        bit 31~0 - ystart_pos[31:0] (Read/Write)
-- 0x60 : reserved
-- 0x64 : Data signal of frame_size
--        bit 31~0 - frame_size[31:0] (Read/Write)
-- 0x68 : reserved
-- 0x6c : Data signal of alpha
--        bit 7~0 - alpha[7:0] (Read/Write)
--        others  - reserved
-- 0x70 : reserved
-- 0x74 : Data signal of id
--        bit 31~0 - id[31:0] (Read/Write)
-- 0x78 : reserved
-- 0x7c : Data signal of a
--        bit 31~0 - a[31:0] (Read/Write)
-- 0x80 : reserved
-- 0x84 : Data signal of b
--        bit 31~0 - b[31:0] (Read/Write)
-- 0x88 : reserved
-- 0x8c : Data signal of c
--        bit 31~0 - c[31:0] (Read/Write)
-- 0x90 : reserved
-- 0x94 : Data signal of d
--        bit 31~0 - d[31:0] (Read/Write)
-- 0x98 : reserved
-- 0x9c : Data signal of m
--        bit 31~0 - m[31:0] (Read/Write)
-- 0xa0 : reserved
-- 0xa4 : Data signal of n
--        bit 31~0 - n[31:0] (Read/Write)
-- 0xa8 : reserved
-- (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

architecture behave of affine_scale_control_s_axi is
    type states is (wridle, wrdata, wrresp, wrreset, rdidle, rddata, rdreset);  -- read and write fsm states
    signal wstate  : states := wrreset;
    signal rstate  : states := rdreset;
    signal wnext, rnext: states;
    constant ADDR_AP_CTRL                   : INTEGER := 16#00#;
    constant ADDR_GIE                       : INTEGER := 16#04#;
    constant ADDR_IER                       : INTEGER := 16#08#;
    constant ADDR_ISR                       : INTEGER := 16#0c#;
    constant ADDR_SRCIN_DATA_0              : INTEGER := 16#10#;
    constant ADDR_SRCIN_DATA_1              : INTEGER := 16#14#;
    constant ADDR_SRCIN_CTRL                : INTEGER := 16#18#;
    constant ADDR_DSTIN_DATA_0              : INTEGER := 16#1c#;
    constant ADDR_DSTIN_DATA_1              : INTEGER := 16#20#;
    constant ADDR_DSTIN_CTRL                : INTEGER := 16#24#;
    constant ADDR_DSTOUT_DATA_0             : INTEGER := 16#28#;
    constant ADDR_DSTOUT_DATA_1             : INTEGER := 16#2c#;
    constant ADDR_DSTOUT_CTRL               : INTEGER := 16#30#;
    constant ADDR_MAPCHIP_MAXWIDTH_DATA_0   : INTEGER := 16#34#;
    constant ADDR_MAPCHIP_MAXWIDTH_CTRL     : INTEGER := 16#38#;
    constant ADDR_MAPCHIP_MAXHEIGHT_DATA_0  : INTEGER := 16#3c#;
    constant ADDR_MAPCHIP_MAXHEIGHT_CTRL    : INTEGER := 16#40#;
    constant ADDR_MAPCHIP_DRAW_XSIZE_DATA_0 : INTEGER := 16#44#;
    constant ADDR_MAPCHIP_DRAW_XSIZE_CTRL   : INTEGER := 16#48#;
    constant ADDR_MAPCHIP_DRAW_YSIZE_DATA_0 : INTEGER := 16#4c#;
    constant ADDR_MAPCHIP_DRAW_YSIZE_CTRL   : INTEGER := 16#50#;
    constant ADDR_XSTART_POS_DATA_0         : INTEGER := 16#54#;
    constant ADDR_XSTART_POS_CTRL           : INTEGER := 16#58#;
    constant ADDR_YSTART_POS_DATA_0         : INTEGER := 16#5c#;
    constant ADDR_YSTART_POS_CTRL           : INTEGER := 16#60#;
    constant ADDR_FRAME_SIZE_DATA_0         : INTEGER := 16#64#;
    constant ADDR_FRAME_SIZE_CTRL           : INTEGER := 16#68#;
    constant ADDR_ALPHA_DATA_0              : INTEGER := 16#6c#;
    constant ADDR_ALPHA_CTRL                : INTEGER := 16#70#;
    constant ADDR_ID_DATA_0                 : INTEGER := 16#74#;
    constant ADDR_ID_CTRL                   : INTEGER := 16#78#;
    constant ADDR_A_DATA_0                  : INTEGER := 16#7c#;
    constant ADDR_A_CTRL                    : INTEGER := 16#80#;
    constant ADDR_B_DATA_0                  : INTEGER := 16#84#;
    constant ADDR_B_CTRL                    : INTEGER := 16#88#;
    constant ADDR_C_DATA_0                  : INTEGER := 16#8c#;
    constant ADDR_C_CTRL                    : INTEGER := 16#90#;
    constant ADDR_D_DATA_0                  : INTEGER := 16#94#;
    constant ADDR_D_CTRL                    : INTEGER := 16#98#;
    constant ADDR_M_DATA_0                  : INTEGER := 16#9c#;
    constant ADDR_M_CTRL                    : INTEGER := 16#a0#;
    constant ADDR_N_DATA_0                  : INTEGER := 16#a4#;
    constant ADDR_N_CTRL                    : INTEGER := 16#a8#;
    constant ADDR_BITS         : INTEGER := 8;

    signal waddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal wmask               : UNSIGNED(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal aw_hs               : STD_LOGIC;
    signal w_hs                : STD_LOGIC;
    signal rdata_data          : UNSIGNED(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal ar_hs               : STD_LOGIC;
    signal raddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal AWREADY_t           : STD_LOGIC;
    signal WREADY_t            : STD_LOGIC;
    signal ARREADY_t           : STD_LOGIC;
    signal RVALID_t            : STD_LOGIC;
    -- internal registers
    signal int_ap_idle         : STD_LOGIC;
    signal int_ap_ready        : STD_LOGIC;
    signal int_ap_done         : STD_LOGIC := '0';
    signal int_ap_start        : STD_LOGIC := '0';
    signal int_auto_restart    : STD_LOGIC := '0';
    signal int_gie             : STD_LOGIC := '0';
    signal int_ier             : UNSIGNED(1 downto 0) := (others => '0');
    signal int_isr             : UNSIGNED(1 downto 0) := (others => '0');
    signal int_srcin           : UNSIGNED(63 downto 0) := (others => '0');
    signal int_dstin           : UNSIGNED(63 downto 0) := (others => '0');
    signal int_dstout          : UNSIGNED(63 downto 0) := (others => '0');
    signal int_mapchip_maxwidth : UNSIGNED(31 downto 0) := (others => '0');
    signal int_mapchip_maxheight : UNSIGNED(31 downto 0) := (others => '0');
    signal int_mapchip_draw_xsize : UNSIGNED(31 downto 0) := (others => '0');
    signal int_mapchip_draw_ysize : UNSIGNED(31 downto 0) := (others => '0');
    signal int_xstart_pos      : UNSIGNED(31 downto 0) := (others => '0');
    signal int_ystart_pos      : UNSIGNED(31 downto 0) := (others => '0');
    signal int_frame_size      : UNSIGNED(31 downto 0) := (others => '0');
    signal int_alpha           : UNSIGNED(7 downto 0) := (others => '0');
    signal int_id              : UNSIGNED(31 downto 0) := (others => '0');
    signal int_a               : UNSIGNED(31 downto 0) := (others => '0');
    signal int_b               : UNSIGNED(31 downto 0) := (others => '0');
    signal int_c               : UNSIGNED(31 downto 0) := (others => '0');
    signal int_d               : UNSIGNED(31 downto 0) := (others => '0');
    signal int_m               : UNSIGNED(31 downto 0) := (others => '0');
    signal int_n               : UNSIGNED(31 downto 0) := (others => '0');


begin
-- ----------------------- Instantiation------------------


-- ----------------------- AXI WRITE ---------------------
    AWREADY_t <=  '1' when wstate = wridle else '0';
    AWREADY   <=  AWREADY_t;
    WREADY_t  <=  '1' when wstate = wrdata else '0';
    WREADY    <=  WREADY_t;
    BRESP     <=  "00";  -- OKAY
    BVALID    <=  '1' when wstate = wrresp else '0';
    wmask     <=  (31 downto 24 => WSTRB(3), 23 downto 16 => WSTRB(2), 15 downto 8 => WSTRB(1), 7 downto 0 => WSTRB(0));
    aw_hs     <=  AWVALID and AWREADY_t;
    w_hs      <=  WVALID and WREADY_t;

    -- write FSM
    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                wstate <= wrreset;
            elsif (ACLK_EN = '1') then
                wstate <= wnext;
            end if;
        end if;
    end process;

    process (wstate, AWVALID, WVALID, BREADY)
    begin
        case (wstate) is
        when wridle =>
            if (AWVALID = '1') then
                wnext <= wrdata;
            else
                wnext <= wridle;
            end if;
        when wrdata =>
            if (WVALID = '1') then
                wnext <= wrresp;
            else
                wnext <= wrdata;
            end if;
        when wrresp =>
            if (BREADY = '1') then
                wnext <= wridle;
            else
                wnext <= wrresp;
            end if;
        when others =>
            wnext <= wridle;
        end case;
    end process;

    waddr_proc : process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (aw_hs = '1') then
                    waddr <= UNSIGNED(AWADDR(ADDR_BITS-1 downto 0));
                end if;
            end if;
        end if;
    end process;

-- ----------------------- AXI READ ----------------------
    ARREADY_t <= '1' when (rstate = rdidle) else '0';
    ARREADY <= ARREADY_t;
    RDATA   <= STD_LOGIC_VECTOR(rdata_data);
    RRESP   <= "00";  -- OKAY
    RVALID_t  <= '1' when (rstate = rddata) else '0';
    RVALID    <= RVALID_t;
    ar_hs   <= ARVALID and ARREADY_t;
    raddr   <= UNSIGNED(ARADDR(ADDR_BITS-1 downto 0));

    -- read FSM
    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                rstate <= rdreset;
            elsif (ACLK_EN = '1') then
                rstate <= rnext;
            end if;
        end if;
    end process;

    process (rstate, ARVALID, RREADY, RVALID_t)
    begin
        case (rstate) is
        when rdidle =>
            if (ARVALID = '1') then
                rnext <= rddata;
            else
                rnext <= rdidle;
            end if;
        when rddata =>
            if (RREADY = '1' and RVALID_t = '1') then
                rnext <= rdidle;
            else
                rnext <= rddata;
            end if;
        when others =>
            rnext <= rdidle;
        end case;
    end process;

    rdata_proc : process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (ar_hs = '1') then
                    rdata_data <= (others => '0');
                    case (TO_INTEGER(raddr)) is
                    when ADDR_AP_CTRL =>
                        rdata_data(7) <= int_auto_restart;
                        rdata_data(3) <= int_ap_ready;
                        rdata_data(2) <= int_ap_idle;
                        rdata_data(1) <= int_ap_done;
                        rdata_data(0) <= int_ap_start;
                    when ADDR_GIE =>
                        rdata_data(0) <= int_gie;
                    when ADDR_IER =>
                        rdata_data(1 downto 0) <= int_ier;
                    when ADDR_ISR =>
                        rdata_data(1 downto 0) <= int_isr;
                    when ADDR_SRCIN_DATA_0 =>
                        rdata_data <= RESIZE(int_srcin(31 downto 0), 32);
                    when ADDR_SRCIN_DATA_1 =>
                        rdata_data <= RESIZE(int_srcin(63 downto 32), 32);
                    when ADDR_DSTIN_DATA_0 =>
                        rdata_data <= RESIZE(int_dstin(31 downto 0), 32);
                    when ADDR_DSTIN_DATA_1 =>
                        rdata_data <= RESIZE(int_dstin(63 downto 32), 32);
                    when ADDR_DSTOUT_DATA_0 =>
                        rdata_data <= RESIZE(int_dstout(31 downto 0), 32);
                    when ADDR_DSTOUT_DATA_1 =>
                        rdata_data <= RESIZE(int_dstout(63 downto 32), 32);
                    when ADDR_MAPCHIP_MAXWIDTH_DATA_0 =>
                        rdata_data <= RESIZE(int_mapchip_maxwidth(31 downto 0), 32);
                    when ADDR_MAPCHIP_MAXHEIGHT_DATA_0 =>
                        rdata_data <= RESIZE(int_mapchip_maxheight(31 downto 0), 32);
                    when ADDR_MAPCHIP_DRAW_XSIZE_DATA_0 =>
                        rdata_data <= RESIZE(int_mapchip_draw_xsize(31 downto 0), 32);
                    when ADDR_MAPCHIP_DRAW_YSIZE_DATA_0 =>
                        rdata_data <= RESIZE(int_mapchip_draw_ysize(31 downto 0), 32);
                    when ADDR_XSTART_POS_DATA_0 =>
                        rdata_data <= RESIZE(int_xstart_pos(31 downto 0), 32);
                    when ADDR_YSTART_POS_DATA_0 =>
                        rdata_data <= RESIZE(int_ystart_pos(31 downto 0), 32);
                    when ADDR_FRAME_SIZE_DATA_0 =>
                        rdata_data <= RESIZE(int_frame_size(31 downto 0), 32);
                    when ADDR_ALPHA_DATA_0 =>
                        rdata_data <= RESIZE(int_alpha(7 downto 0), 32);
                    when ADDR_ID_DATA_0 =>
                        rdata_data <= RESIZE(int_id(31 downto 0), 32);
                    when ADDR_A_DATA_0 =>
                        rdata_data <= RESIZE(int_a(31 downto 0), 32);
                    when ADDR_B_DATA_0 =>
                        rdata_data <= RESIZE(int_b(31 downto 0), 32);
                    when ADDR_C_DATA_0 =>
                        rdata_data <= RESIZE(int_c(31 downto 0), 32);
                    when ADDR_D_DATA_0 =>
                        rdata_data <= RESIZE(int_d(31 downto 0), 32);
                    when ADDR_M_DATA_0 =>
                        rdata_data <= RESIZE(int_m(31 downto 0), 32);
                    when ADDR_N_DATA_0 =>
                        rdata_data <= RESIZE(int_n(31 downto 0), 32);
                    when others =>
                        NULL;
                    end case;
                end if;
            end if;
        end if;
    end process;

-- ----------------------- Register logic ----------------
    interrupt            <= int_gie and (int_isr(0) or int_isr(1));
    ap_start             <= int_ap_start;
    srcin                <= STD_LOGIC_VECTOR(int_srcin);
    dstin                <= STD_LOGIC_VECTOR(int_dstin);
    dstout               <= STD_LOGIC_VECTOR(int_dstout);
    mapchip_maxwidth     <= STD_LOGIC_VECTOR(int_mapchip_maxwidth);
    mapchip_maxheight    <= STD_LOGIC_VECTOR(int_mapchip_maxheight);
    mapchip_draw_xsize   <= STD_LOGIC_VECTOR(int_mapchip_draw_xsize);
    mapchip_draw_ysize   <= STD_LOGIC_VECTOR(int_mapchip_draw_ysize);
    xstart_pos           <= STD_LOGIC_VECTOR(int_xstart_pos);
    ystart_pos           <= STD_LOGIC_VECTOR(int_ystart_pos);
    frame_size           <= STD_LOGIC_VECTOR(int_frame_size);
    alpha                <= STD_LOGIC_VECTOR(int_alpha);
    id                   <= STD_LOGIC_VECTOR(int_id);
    a                    <= STD_LOGIC_VECTOR(int_a);
    b                    <= STD_LOGIC_VECTOR(int_b);
    c                    <= STD_LOGIC_VECTOR(int_c);
    d                    <= STD_LOGIC_VECTOR(int_d);
    m                    <= STD_LOGIC_VECTOR(int_m);
    n                    <= STD_LOGIC_VECTOR(int_n);

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_start <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_AP_CTRL and WSTRB(0) = '1' and WDATA(0) = '1') then
                    int_ap_start <= '1';
                elsif (ap_ready = '1') then
                    int_ap_start <= int_auto_restart; -- clear on handshake/auto restart
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_done <= '0';
            elsif (ACLK_EN = '1') then
                if (ap_done = '1') then
                    int_ap_done <= '1';
                elsif (ar_hs = '1' and raddr = ADDR_AP_CTRL) then
                    int_ap_done <= '0'; -- clear on read
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_idle <= '0';
            elsif (ACLK_EN = '1') then
                if (true) then
                    int_ap_idle <= ap_idle;
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_ready <= '0';
            elsif (ACLK_EN = '1') then
                if (true) then
                    int_ap_ready <= ap_ready;
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_auto_restart <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_AP_CTRL and WSTRB(0) = '1') then
                    int_auto_restart <= WDATA(7);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_gie <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_GIE and WSTRB(0) = '1') then
                    int_gie <= WDATA(0);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ier <= "00";
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_IER and WSTRB(0) = '1') then
                    int_ier <= UNSIGNED(WDATA(1 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_isr(0) <= '0';
            elsif (ACLK_EN = '1') then
                if (int_ier(0) = '1' and ap_done = '1') then
                    int_isr(0) <= '1';
                elsif (w_hs = '1' and waddr = ADDR_ISR and WSTRB(0) = '1') then
                    int_isr(0) <= int_isr(0) xor WDATA(0); -- toggle on write
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_isr(1) <= '0';
            elsif (ACLK_EN = '1') then
                if (int_ier(1) = '1' and ap_ready = '1') then
                    int_isr(1) <= '1';
                elsif (w_hs = '1' and waddr = ADDR_ISR and WSTRB(0) = '1') then
                    int_isr(1) <= int_isr(1) xor WDATA(1); -- toggle on write
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_SRCIN_DATA_0) then
                    int_srcin(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_srcin(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_SRCIN_DATA_1) then
                    int_srcin(63 downto 32) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_srcin(63 downto 32));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_DSTIN_DATA_0) then
                    int_dstin(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_dstin(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_DSTIN_DATA_1) then
                    int_dstin(63 downto 32) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_dstin(63 downto 32));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_DSTOUT_DATA_0) then
                    int_dstout(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_dstout(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_DSTOUT_DATA_1) then
                    int_dstout(63 downto 32) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_dstout(63 downto 32));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_MAPCHIP_MAXWIDTH_DATA_0) then
                    int_mapchip_maxwidth(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_mapchip_maxwidth(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_MAPCHIP_MAXHEIGHT_DATA_0) then
                    int_mapchip_maxheight(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_mapchip_maxheight(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_MAPCHIP_DRAW_XSIZE_DATA_0) then
                    int_mapchip_draw_xsize(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_mapchip_draw_xsize(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_MAPCHIP_DRAW_YSIZE_DATA_0) then
                    int_mapchip_draw_ysize(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_mapchip_draw_ysize(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_XSTART_POS_DATA_0) then
                    int_xstart_pos(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_xstart_pos(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_YSTART_POS_DATA_0) then
                    int_ystart_pos(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_ystart_pos(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_FRAME_SIZE_DATA_0) then
                    int_frame_size(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_frame_size(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ALPHA_DATA_0) then
                    int_alpha(7 downto 0) <= (UNSIGNED(WDATA(7 downto 0)) and wmask(7 downto 0)) or ((not wmask(7 downto 0)) and int_alpha(7 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ID_DATA_0) then
                    int_id(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_id(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_A_DATA_0) then
                    int_a(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_a(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_B_DATA_0) then
                    int_b(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_b(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_C_DATA_0) then
                    int_c(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_c(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_D_DATA_0) then
                    int_d(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_d(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_M_DATA_0) then
                    int_m(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_m(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_N_DATA_0) then
                    int_n(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_n(31 downto 0));
                end if;
            end if;
        end if;
    end process;


-- ----------------------- Memory logic ------------------

end architecture behave;
