// Generator : SpinalHDL v1.4.1    git head : 6deea7f7a1a48691f442df66ca70d5188f898b56
// Component : Axi4_2x32_1x256
// Git hash  : 6c38d15ac215e6c4dd72a9165b44ff5aecf921c3



module Axi4_2x32_1x256 (
  input               io_inputs_0_aw_valid,
  output              io_inputs_0_aw_ready,
  input      [31:0]   io_inputs_0_aw_payload_addr,
  input      [3:0]    io_inputs_0_aw_payload_id,
  input      [3:0]    io_inputs_0_aw_payload_region,
  input      [7:0]    io_inputs_0_aw_payload_len,
  input      [2:0]    io_inputs_0_aw_payload_size,
  input      [1:0]    io_inputs_0_aw_payload_burst,
  input      [0:0]    io_inputs_0_aw_payload_lock,
  input      [3:0]    io_inputs_0_aw_payload_cache,
  input      [3:0]    io_inputs_0_aw_payload_qos,
  input      [2:0]    io_inputs_0_aw_payload_prot,
  input               io_inputs_0_w_valid,
  output              io_inputs_0_w_ready,
  input      [31:0]   io_inputs_0_w_payload_data,
  input      [3:0]    io_inputs_0_w_payload_strb,
  input               io_inputs_0_w_payload_last,
  output              io_inputs_0_b_valid,
  input               io_inputs_0_b_ready,
  output     [3:0]    io_inputs_0_b_payload_id,
  output     [1:0]    io_inputs_0_b_payload_resp,
  input               io_inputs_0_ar_valid,
  output              io_inputs_0_ar_ready,
  input      [31:0]   io_inputs_0_ar_payload_addr,
  input      [3:0]    io_inputs_0_ar_payload_id,
  input      [3:0]    io_inputs_0_ar_payload_region,
  input      [7:0]    io_inputs_0_ar_payload_len,
  input      [2:0]    io_inputs_0_ar_payload_size,
  input      [1:0]    io_inputs_0_ar_payload_burst,
  input      [0:0]    io_inputs_0_ar_payload_lock,
  input      [3:0]    io_inputs_0_ar_payload_cache,
  input      [3:0]    io_inputs_0_ar_payload_qos,
  input      [2:0]    io_inputs_0_ar_payload_prot,
  output              io_inputs_0_r_valid,
  input               io_inputs_0_r_ready,
  output     [31:0]   io_inputs_0_r_payload_data,
  output     [3:0]    io_inputs_0_r_payload_id,
  output     [1:0]    io_inputs_0_r_payload_resp,
  output              io_inputs_0_r_payload_last,
  input               io_inputs_1_aw_valid,
  output              io_inputs_1_aw_ready,
  input      [31:0]   io_inputs_1_aw_payload_addr,
  input      [3:0]    io_inputs_1_aw_payload_id,
  input      [3:0]    io_inputs_1_aw_payload_region,
  input      [7:0]    io_inputs_1_aw_payload_len,
  input      [2:0]    io_inputs_1_aw_payload_size,
  input      [1:0]    io_inputs_1_aw_payload_burst,
  input      [0:0]    io_inputs_1_aw_payload_lock,
  input      [3:0]    io_inputs_1_aw_payload_cache,
  input      [3:0]    io_inputs_1_aw_payload_qos,
  input      [2:0]    io_inputs_1_aw_payload_prot,
  input               io_inputs_1_w_valid,
  output              io_inputs_1_w_ready,
  input      [31:0]   io_inputs_1_w_payload_data,
  input      [3:0]    io_inputs_1_w_payload_strb,
  input               io_inputs_1_w_payload_last,
  output              io_inputs_1_b_valid,
  input               io_inputs_1_b_ready,
  output     [3:0]    io_inputs_1_b_payload_id,
  output     [1:0]    io_inputs_1_b_payload_resp,
  input               io_inputs_1_ar_valid,
  output              io_inputs_1_ar_ready,
  input      [31:0]   io_inputs_1_ar_payload_addr,
  input      [3:0]    io_inputs_1_ar_payload_id,
  input      [3:0]    io_inputs_1_ar_payload_region,
  input      [7:0]    io_inputs_1_ar_payload_len,
  input      [2:0]    io_inputs_1_ar_payload_size,
  input      [1:0]    io_inputs_1_ar_payload_burst,
  input      [0:0]    io_inputs_1_ar_payload_lock,
  input      [3:0]    io_inputs_1_ar_payload_cache,
  input      [3:0]    io_inputs_1_ar_payload_qos,
  input      [2:0]    io_inputs_1_ar_payload_prot,
  output              io_inputs_1_r_valid,
  input               io_inputs_1_r_ready,
  output     [31:0]   io_inputs_1_r_payload_data,
  output     [3:0]    io_inputs_1_r_payload_id,
  output     [1:0]    io_inputs_1_r_payload_resp,
  output              io_inputs_1_r_payload_last,
  output              io_output_arw_valid,
  input               io_output_arw_ready,
  output     [31:0]   io_output_arw_payload_addr,
  output     [4:0]    io_output_arw_payload_id,
  output     [3:0]    io_output_arw_payload_region,
  output     [7:0]    io_output_arw_payload_len,
  output     [2:0]    io_output_arw_payload_size,
  output     [1:0]    io_output_arw_payload_burst,
  output     [0:0]    io_output_arw_payload_lock,
  output     [3:0]    io_output_arw_payload_cache,
  output     [3:0]    io_output_arw_payload_qos,
  output     [2:0]    io_output_arw_payload_prot,
  output              io_output_arw_payload_write,
  output              io_output_w_valid,
  input               io_output_w_ready,
  output     [255:0]  io_output_w_payload_data,
  output     [31:0]   io_output_w_payload_strb,
  output              io_output_w_payload_last,
  input               io_output_b_valid,
  output              io_output_b_ready,
  input      [4:0]    io_output_b_payload_id,
  input      [1:0]    io_output_b_payload_resp,
  input               io_output_r_valid,
  output              io_output_r_ready,
  input      [255:0]  io_output_r_payload_data,
  input      [4:0]    io_output_r_payload_id,
  input      [1:0]    io_output_r_payload_resp,
  input               io_output_r_payload_last,
  output     [4:0]    io_output_arw_id,
  input               clk,
  input               reset
);
  wire                _zz_1;
  wire                up_0_logic_io_input_ar_ready;
  wire                up_0_logic_io_input_aw_ready;
  wire                up_0_logic_io_input_w_ready;
  wire                up_0_logic_io_input_r_valid;
  wire       [31:0]   up_0_logic_io_input_r_payload_data;
  wire       [3:0]    up_0_logic_io_input_r_payload_id;
  wire       [1:0]    up_0_logic_io_input_r_payload_resp;
  wire                up_0_logic_io_input_r_payload_last;
  wire                up_0_logic_io_input_b_valid;
  wire       [3:0]    up_0_logic_io_input_b_payload_id;
  wire       [1:0]    up_0_logic_io_input_b_payload_resp;
  wire                up_0_logic_io_output_ar_valid;
  wire       [31:0]   up_0_logic_io_output_ar_payload_addr;
  wire       [3:0]    up_0_logic_io_output_ar_payload_id;
  wire       [3:0]    up_0_logic_io_output_ar_payload_region;
  wire       [7:0]    up_0_logic_io_output_ar_payload_len;
  wire       [2:0]    up_0_logic_io_output_ar_payload_size;
  wire       [1:0]    up_0_logic_io_output_ar_payload_burst;
  wire       [0:0]    up_0_logic_io_output_ar_payload_lock;
  wire       [3:0]    up_0_logic_io_output_ar_payload_cache;
  wire       [3:0]    up_0_logic_io_output_ar_payload_qos;
  wire       [2:0]    up_0_logic_io_output_ar_payload_prot;
  wire                up_0_logic_io_output_aw_valid;
  wire       [31:0]   up_0_logic_io_output_aw_payload_addr;
  wire       [3:0]    up_0_logic_io_output_aw_payload_id;
  wire       [3:0]    up_0_logic_io_output_aw_payload_region;
  wire       [7:0]    up_0_logic_io_output_aw_payload_len;
  wire       [2:0]    up_0_logic_io_output_aw_payload_size;
  wire       [1:0]    up_0_logic_io_output_aw_payload_burst;
  wire       [0:0]    up_0_logic_io_output_aw_payload_lock;
  wire       [3:0]    up_0_logic_io_output_aw_payload_cache;
  wire       [3:0]    up_0_logic_io_output_aw_payload_qos;
  wire       [2:0]    up_0_logic_io_output_aw_payload_prot;
  wire                up_0_logic_io_output_w_valid;
  wire       [255:0]  up_0_logic_io_output_w_payload_data;
  wire       [31:0]   up_0_logic_io_output_w_payload_strb;
  wire                up_0_logic_io_output_w_payload_last;
  wire                up_0_logic_io_output_r_ready;
  wire                up_0_logic_io_output_b_ready;
  wire                up_1_logic_io_input_ar_ready;
  wire                up_1_logic_io_input_aw_ready;
  wire                up_1_logic_io_input_w_ready;
  wire                up_1_logic_io_input_r_valid;
  wire       [31:0]   up_1_logic_io_input_r_payload_data;
  wire       [3:0]    up_1_logic_io_input_r_payload_id;
  wire       [1:0]    up_1_logic_io_input_r_payload_resp;
  wire                up_1_logic_io_input_r_payload_last;
  wire                up_1_logic_io_input_b_valid;
  wire       [3:0]    up_1_logic_io_input_b_payload_id;
  wire       [1:0]    up_1_logic_io_input_b_payload_resp;
  wire                up_1_logic_io_output_ar_valid;
  wire       [31:0]   up_1_logic_io_output_ar_payload_addr;
  wire       [3:0]    up_1_logic_io_output_ar_payload_id;
  wire       [3:0]    up_1_logic_io_output_ar_payload_region;
  wire       [7:0]    up_1_logic_io_output_ar_payload_len;
  wire       [2:0]    up_1_logic_io_output_ar_payload_size;
  wire       [1:0]    up_1_logic_io_output_ar_payload_burst;
  wire       [0:0]    up_1_logic_io_output_ar_payload_lock;
  wire       [3:0]    up_1_logic_io_output_ar_payload_cache;
  wire       [3:0]    up_1_logic_io_output_ar_payload_qos;
  wire       [2:0]    up_1_logic_io_output_ar_payload_prot;
  wire                up_1_logic_io_output_aw_valid;
  wire       [31:0]   up_1_logic_io_output_aw_payload_addr;
  wire       [3:0]    up_1_logic_io_output_aw_payload_id;
  wire       [3:0]    up_1_logic_io_output_aw_payload_region;
  wire       [7:0]    up_1_logic_io_output_aw_payload_len;
  wire       [2:0]    up_1_logic_io_output_aw_payload_size;
  wire       [1:0]    up_1_logic_io_output_aw_payload_burst;
  wire       [0:0]    up_1_logic_io_output_aw_payload_lock;
  wire       [3:0]    up_1_logic_io_output_aw_payload_cache;
  wire       [3:0]    up_1_logic_io_output_aw_payload_qos;
  wire       [2:0]    up_1_logic_io_output_aw_payload_prot;
  wire                up_1_logic_io_output_w_valid;
  wire       [255:0]  up_1_logic_io_output_w_payload_data;
  wire       [31:0]   up_1_logic_io_output_w_payload_strb;
  wire                up_1_logic_io_output_w_payload_last;
  wire                up_1_logic_io_output_r_ready;
  wire                up_1_logic_io_output_b_ready;
  wire                arbiter_readOnly_io_inputs_0_ar_ready;
  wire                arbiter_readOnly_io_inputs_0_r_valid;
  wire       [255:0]  arbiter_readOnly_io_inputs_0_r_payload_data;
  wire       [3:0]    arbiter_readOnly_io_inputs_0_r_payload_id;
  wire       [1:0]    arbiter_readOnly_io_inputs_0_r_payload_resp;
  wire                arbiter_readOnly_io_inputs_0_r_payload_last;
  wire                arbiter_readOnly_io_inputs_1_ar_ready;
  wire                arbiter_readOnly_io_inputs_1_r_valid;
  wire       [255:0]  arbiter_readOnly_io_inputs_1_r_payload_data;
  wire       [3:0]    arbiter_readOnly_io_inputs_1_r_payload_id;
  wire       [1:0]    arbiter_readOnly_io_inputs_1_r_payload_resp;
  wire                arbiter_readOnly_io_inputs_1_r_payload_last;
  wire                arbiter_readOnly_io_output_ar_valid;
  wire       [31:0]   arbiter_readOnly_io_output_ar_payload_addr;
  wire       [4:0]    arbiter_readOnly_io_output_ar_payload_id;
  wire       [3:0]    arbiter_readOnly_io_output_ar_payload_region;
  wire       [7:0]    arbiter_readOnly_io_output_ar_payload_len;
  wire       [2:0]    arbiter_readOnly_io_output_ar_payload_size;
  wire       [1:0]    arbiter_readOnly_io_output_ar_payload_burst;
  wire       [0:0]    arbiter_readOnly_io_output_ar_payload_lock;
  wire       [3:0]    arbiter_readOnly_io_output_ar_payload_cache;
  wire       [3:0]    arbiter_readOnly_io_output_ar_payload_qos;
  wire       [2:0]    arbiter_readOnly_io_output_ar_payload_prot;
  wire                arbiter_readOnly_io_output_r_ready;
  wire                arbiter_writeOnly_io_inputs_0_aw_ready;
  wire                arbiter_writeOnly_io_inputs_0_w_ready;
  wire                arbiter_writeOnly_io_inputs_0_b_valid;
  wire       [3:0]    arbiter_writeOnly_io_inputs_0_b_payload_id;
  wire       [1:0]    arbiter_writeOnly_io_inputs_0_b_payload_resp;
  wire                arbiter_writeOnly_io_inputs_1_aw_ready;
  wire                arbiter_writeOnly_io_inputs_1_w_ready;
  wire                arbiter_writeOnly_io_inputs_1_b_valid;
  wire       [3:0]    arbiter_writeOnly_io_inputs_1_b_payload_id;
  wire       [1:0]    arbiter_writeOnly_io_inputs_1_b_payload_resp;
  wire                arbiter_writeOnly_io_output_aw_valid;
  wire       [31:0]   arbiter_writeOnly_io_output_aw_payload_addr;
  wire       [4:0]    arbiter_writeOnly_io_output_aw_payload_id;
  wire       [3:0]    arbiter_writeOnly_io_output_aw_payload_region;
  wire       [7:0]    arbiter_writeOnly_io_output_aw_payload_len;
  wire       [2:0]    arbiter_writeOnly_io_output_aw_payload_size;
  wire       [1:0]    arbiter_writeOnly_io_output_aw_payload_burst;
  wire       [0:0]    arbiter_writeOnly_io_output_aw_payload_lock;
  wire       [3:0]    arbiter_writeOnly_io_output_aw_payload_cache;
  wire       [3:0]    arbiter_writeOnly_io_output_aw_payload_qos;
  wire       [2:0]    arbiter_writeOnly_io_output_aw_payload_prot;
  wire                arbiter_writeOnly_io_output_w_valid;
  wire       [255:0]  arbiter_writeOnly_io_output_w_payload_data;
  wire       [31:0]   arbiter_writeOnly_io_output_w_payload_strb;
  wire                arbiter_writeOnly_io_output_w_payload_last;
  wire                arbiter_writeOnly_io_output_b_ready;
  wire                streamArbiter_3_io_inputs_0_ready;
  wire                streamArbiter_3_io_inputs_1_ready;
  wire                streamArbiter_3_io_output_valid;
  wire       [31:0]   streamArbiter_3_io_output_payload_addr;
  wire       [4:0]    streamArbiter_3_io_output_payload_id;
  wire       [3:0]    streamArbiter_3_io_output_payload_region;
  wire       [7:0]    streamArbiter_3_io_output_payload_len;
  wire       [2:0]    streamArbiter_3_io_output_payload_size;
  wire       [1:0]    streamArbiter_3_io_output_payload_burst;
  wire       [0:0]    streamArbiter_3_io_output_payload_lock;
  wire       [3:0]    streamArbiter_3_io_output_payload_cache;
  wire       [3:0]    streamArbiter_3_io_output_payload_qos;
  wire       [2:0]    streamArbiter_3_io_output_payload_prot;
  wire       [0:0]    streamArbiter_3_io_chosen;
  wire       [1:0]    streamArbiter_3_io_chosenOH;
  wire                toAxi3_io_input_arw_ready;
  wire                toAxi3_io_input_w_ready;
  wire                toAxi3_io_input_b_valid;
  wire       [4:0]    toAxi3_io_input_b_payload_id;
  wire       [1:0]    toAxi3_io_input_b_payload_resp;
  wire                toAxi3_io_input_r_valid;
  wire       [255:0]  toAxi3_io_input_r_payload_data;
  wire       [4:0]    toAxi3_io_input_r_payload_id;
  wire       [1:0]    toAxi3_io_input_r_payload_resp;
  wire                toAxi3_io_input_r_payload_last;
  wire                toAxi3_io_output_arw_valid;
  wire       [31:0]   toAxi3_io_output_arw_payload_addr;
  wire       [4:0]    toAxi3_io_output_arw_payload_id;
  wire       [3:0]    toAxi3_io_output_arw_payload_region;
  wire       [7:0]    toAxi3_io_output_arw_payload_len;
  wire       [2:0]    toAxi3_io_output_arw_payload_size;
  wire       [1:0]    toAxi3_io_output_arw_payload_burst;
  wire       [0:0]    toAxi3_io_output_arw_payload_lock;
  wire       [3:0]    toAxi3_io_output_arw_payload_cache;
  wire       [3:0]    toAxi3_io_output_arw_payload_qos;
  wire       [2:0]    toAxi3_io_output_arw_payload_prot;
  wire                toAxi3_io_output_arw_payload_write;
  wire                toAxi3_io_output_w_valid;
  wire       [255:0]  toAxi3_io_output_w_payload_data;
  wire       [31:0]   toAxi3_io_output_w_payload_strb;
  wire                toAxi3_io_output_w_payload_last;
  wire                toAxi3_io_output_b_ready;
  wire                toAxi3_io_output_r_ready;
  wire       [4:0]    toAxi3_io_output_aw_id;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire                _zz_5;
  wire                _zz_6;
  wire                arbiter_axi4_aw_valid;
  wire                arbiter_axi4_aw_ready;
  wire       [31:0]   arbiter_axi4_aw_payload_addr;
  wire       [4:0]    arbiter_axi4_aw_payload_id;
  wire       [3:0]    arbiter_axi4_aw_payload_region;
  wire       [7:0]    arbiter_axi4_aw_payload_len;
  wire       [2:0]    arbiter_axi4_aw_payload_size;
  wire       [1:0]    arbiter_axi4_aw_payload_burst;
  wire       [0:0]    arbiter_axi4_aw_payload_lock;
  wire       [3:0]    arbiter_axi4_aw_payload_cache;
  wire       [3:0]    arbiter_axi4_aw_payload_qos;
  wire       [2:0]    arbiter_axi4_aw_payload_prot;
  wire                arbiter_axi4_w_valid;
  wire                arbiter_axi4_w_ready;
  wire       [255:0]  arbiter_axi4_w_payload_data;
  wire       [31:0]   arbiter_axi4_w_payload_strb;
  wire                arbiter_axi4_w_payload_last;
  wire                arbiter_axi4_b_valid;
  wire                arbiter_axi4_b_ready;
  wire       [4:0]    arbiter_axi4_b_payload_id;
  wire       [1:0]    arbiter_axi4_b_payload_resp;
  wire                arbiter_axi4_ar_valid;
  wire                arbiter_axi4_ar_ready;
  wire       [31:0]   arbiter_axi4_ar_payload_addr;
  wire       [4:0]    arbiter_axi4_ar_payload_id;
  wire       [3:0]    arbiter_axi4_ar_payload_region;
  wire       [7:0]    arbiter_axi4_ar_payload_len;
  wire       [2:0]    arbiter_axi4_ar_payload_size;
  wire       [1:0]    arbiter_axi4_ar_payload_burst;
  wire       [0:0]    arbiter_axi4_ar_payload_lock;
  wire       [3:0]    arbiter_axi4_ar_payload_cache;
  wire       [3:0]    arbiter_axi4_ar_payload_qos;
  wire       [2:0]    arbiter_axi4_ar_payload_prot;
  wire                arbiter_axi4_r_valid;
  wire                arbiter_axi4_r_ready;
  wire       [255:0]  arbiter_axi4_r_payload_data;
  wire       [4:0]    arbiter_axi4_r_payload_id;
  wire       [1:0]    arbiter_axi4_r_payload_resp;
  wire                arbiter_axi4_r_payload_last;
  wire                arbiter_readOnly_io_output_ar_halfPipe_valid;
  wire                arbiter_readOnly_io_output_ar_halfPipe_ready;
  wire       [31:0]   arbiter_readOnly_io_output_ar_halfPipe_payload_addr;
  wire       [4:0]    arbiter_readOnly_io_output_ar_halfPipe_payload_id;
  wire       [3:0]    arbiter_readOnly_io_output_ar_halfPipe_payload_region;
  wire       [7:0]    arbiter_readOnly_io_output_ar_halfPipe_payload_len;
  wire       [2:0]    arbiter_readOnly_io_output_ar_halfPipe_payload_size;
  wire       [1:0]    arbiter_readOnly_io_output_ar_halfPipe_payload_burst;
  wire       [0:0]    arbiter_readOnly_io_output_ar_halfPipe_payload_lock;
  wire       [3:0]    arbiter_readOnly_io_output_ar_halfPipe_payload_cache;
  wire       [3:0]    arbiter_readOnly_io_output_ar_halfPipe_payload_qos;
  wire       [2:0]    arbiter_readOnly_io_output_ar_halfPipe_payload_prot;
  reg                 arbiter_readOnly_io_output_ar_halfPipe_regs_valid;
  reg                 arbiter_readOnly_io_output_ar_halfPipe_regs_ready;
  reg        [31:0]   arbiter_readOnly_io_output_ar_halfPipe_regs_payload_addr;
  reg        [4:0]    arbiter_readOnly_io_output_ar_halfPipe_regs_payload_id;
  reg        [3:0]    arbiter_readOnly_io_output_ar_halfPipe_regs_payload_region;
  reg        [7:0]    arbiter_readOnly_io_output_ar_halfPipe_regs_payload_len;
  reg        [2:0]    arbiter_readOnly_io_output_ar_halfPipe_regs_payload_size;
  reg        [1:0]    arbiter_readOnly_io_output_ar_halfPipe_regs_payload_burst;
  reg        [0:0]    arbiter_readOnly_io_output_ar_halfPipe_regs_payload_lock;
  reg        [3:0]    arbiter_readOnly_io_output_ar_halfPipe_regs_payload_cache;
  reg        [3:0]    arbiter_readOnly_io_output_ar_halfPipe_regs_payload_qos;
  reg        [2:0]    arbiter_readOnly_io_output_ar_halfPipe_regs_payload_prot;
  wire                arbiter_axi4_r_m2sPipe_valid;
  wire                arbiter_axi4_r_m2sPipe_ready;
  wire       [255:0]  arbiter_axi4_r_m2sPipe_payload_data;
  wire       [4:0]    arbiter_axi4_r_m2sPipe_payload_id;
  wire       [1:0]    arbiter_axi4_r_m2sPipe_payload_resp;
  wire                arbiter_axi4_r_m2sPipe_payload_last;
  reg                 arbiter_axi4_r_m2sPipe_rValid;
  reg        [255:0]  arbiter_axi4_r_m2sPipe_rData_data;
  reg        [4:0]    arbiter_axi4_r_m2sPipe_rData_id;
  reg        [1:0]    arbiter_axi4_r_m2sPipe_rData_resp;
  reg                 arbiter_axi4_r_m2sPipe_rData_last;
  wire                arbiter_axi4_r_m2sPipe_s2mPipe_valid;
  wire                arbiter_axi4_r_m2sPipe_s2mPipe_ready;
  wire       [255:0]  arbiter_axi4_r_m2sPipe_s2mPipe_payload_data;
  wire       [4:0]    arbiter_axi4_r_m2sPipe_s2mPipe_payload_id;
  wire       [1:0]    arbiter_axi4_r_m2sPipe_s2mPipe_payload_resp;
  wire                arbiter_axi4_r_m2sPipe_s2mPipe_payload_last;
  reg                 arbiter_axi4_r_m2sPipe_s2mPipe_rValid;
  reg        [255:0]  arbiter_axi4_r_m2sPipe_s2mPipe_rData_data;
  reg        [4:0]    arbiter_axi4_r_m2sPipe_s2mPipe_rData_id;
  reg        [1:0]    arbiter_axi4_r_m2sPipe_s2mPipe_rData_resp;
  reg                 arbiter_axi4_r_m2sPipe_s2mPipe_rData_last;
  wire                arbiter_writeOnly_io_output_aw_halfPipe_valid;
  wire                arbiter_writeOnly_io_output_aw_halfPipe_ready;
  wire       [31:0]   arbiter_writeOnly_io_output_aw_halfPipe_payload_addr;
  wire       [4:0]    arbiter_writeOnly_io_output_aw_halfPipe_payload_id;
  wire       [3:0]    arbiter_writeOnly_io_output_aw_halfPipe_payload_region;
  wire       [7:0]    arbiter_writeOnly_io_output_aw_halfPipe_payload_len;
  wire       [2:0]    arbiter_writeOnly_io_output_aw_halfPipe_payload_size;
  wire       [1:0]    arbiter_writeOnly_io_output_aw_halfPipe_payload_burst;
  wire       [0:0]    arbiter_writeOnly_io_output_aw_halfPipe_payload_lock;
  wire       [3:0]    arbiter_writeOnly_io_output_aw_halfPipe_payload_cache;
  wire       [3:0]    arbiter_writeOnly_io_output_aw_halfPipe_payload_qos;
  wire       [2:0]    arbiter_writeOnly_io_output_aw_halfPipe_payload_prot;
  reg                 arbiter_writeOnly_io_output_aw_halfPipe_regs_valid;
  reg                 arbiter_writeOnly_io_output_aw_halfPipe_regs_ready;
  reg        [31:0]   arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_addr;
  reg        [4:0]    arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_id;
  reg        [3:0]    arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_region;
  reg        [7:0]    arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_len;
  reg        [2:0]    arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_size;
  reg        [1:0]    arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_burst;
  reg        [0:0]    arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_lock;
  reg        [3:0]    arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_cache;
  reg        [3:0]    arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_qos;
  reg        [2:0]    arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_prot;
  wire                arbiter_writeOnly_io_output_w_m2sPipe_valid;
  wire                arbiter_writeOnly_io_output_w_m2sPipe_ready;
  wire       [255:0]  arbiter_writeOnly_io_output_w_m2sPipe_payload_data;
  wire       [31:0]   arbiter_writeOnly_io_output_w_m2sPipe_payload_strb;
  wire                arbiter_writeOnly_io_output_w_m2sPipe_payload_last;
  reg                 arbiter_writeOnly_io_output_w_m2sPipe_rValid;
  reg        [255:0]  arbiter_writeOnly_io_output_w_m2sPipe_rData_data;
  reg        [31:0]   arbiter_writeOnly_io_output_w_m2sPipe_rData_strb;
  reg                 arbiter_writeOnly_io_output_w_m2sPipe_rData_last;
  wire                arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_valid;
  wire                arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_ready;
  wire       [255:0]  arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_payload_data;
  wire       [31:0]   arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_payload_strb;
  wire                arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_payload_last;
  reg                 arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rValid;
  reg        [255:0]  arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rData_data;
  reg        [31:0]   arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rData_strb;
  reg                 arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rData_last;
  wire                arbiter_axi4_b_halfPipe_valid;
  wire                arbiter_axi4_b_halfPipe_ready;
  wire       [4:0]    arbiter_axi4_b_halfPipe_payload_id;
  wire       [1:0]    arbiter_axi4_b_halfPipe_payload_resp;
  reg                 arbiter_axi4_b_halfPipe_regs_valid;
  reg                 arbiter_axi4_b_halfPipe_regs_ready;
  reg        [4:0]    arbiter_axi4_b_halfPipe_regs_payload_id;
  reg        [1:0]    arbiter_axi4_b_halfPipe_regs_payload_resp;
  wire                shared_arw_valid;
  wire                shared_arw_ready;
  wire       [31:0]   shared_arw_payload_addr;
  wire       [4:0]    shared_arw_payload_id;
  wire       [3:0]    shared_arw_payload_region;
  wire       [7:0]    shared_arw_payload_len;
  wire       [2:0]    shared_arw_payload_size;
  wire       [1:0]    shared_arw_payload_burst;
  wire       [0:0]    shared_arw_payload_lock;
  wire       [3:0]    shared_arw_payload_cache;
  wire       [3:0]    shared_arw_payload_qos;
  wire       [2:0]    shared_arw_payload_prot;
  wire                shared_arw_payload_write;
  wire                shared_w_valid;
  wire                shared_w_ready;
  wire       [255:0]  shared_w_payload_data;
  wire       [31:0]   shared_w_payload_strb;
  wire                shared_w_payload_last;
  wire                shared_b_valid;
  wire                shared_b_ready;
  wire       [4:0]    shared_b_payload_id;
  wire       [1:0]    shared_b_payload_resp;
  wire                shared_r_valid;
  wire                shared_r_ready;
  wire       [255:0]  shared_r_payload_data;
  wire       [4:0]    shared_r_payload_id;
  wire       [1:0]    shared_r_payload_resp;
  wire                shared_r_payload_last;

  assign _zz_2 = (! arbiter_readOnly_io_output_ar_halfPipe_regs_valid);
  assign _zz_3 = (arbiter_axi4_r_m2sPipe_ready && (! arbiter_axi4_r_m2sPipe_s2mPipe_ready));
  assign _zz_4 = (! arbiter_writeOnly_io_output_aw_halfPipe_regs_valid);
  assign _zz_5 = (arbiter_writeOnly_io_output_w_m2sPipe_ready && (! arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_ready));
  assign _zz_6 = (! arbiter_axi4_b_halfPipe_regs_valid);
  Axi4Upsizer up_0_logic (
    .io_input_aw_valid              (io_inputs_0_aw_valid                                ), //i
    .io_input_aw_ready              (up_0_logic_io_input_aw_ready                        ), //o
    .io_input_aw_payload_addr       (io_inputs_0_aw_payload_addr[31:0]                   ), //i
    .io_input_aw_payload_id         (io_inputs_0_aw_payload_id[3:0]                      ), //i
    .io_input_aw_payload_region     (io_inputs_0_aw_payload_region[3:0]                  ), //i
    .io_input_aw_payload_len        (io_inputs_0_aw_payload_len[7:0]                     ), //i
    .io_input_aw_payload_size       (io_inputs_0_aw_payload_size[2:0]                    ), //i
    .io_input_aw_payload_burst      (io_inputs_0_aw_payload_burst[1:0]                   ), //i
    .io_input_aw_payload_lock       (io_inputs_0_aw_payload_lock                         ), //i
    .io_input_aw_payload_cache      (io_inputs_0_aw_payload_cache[3:0]                   ), //i
    .io_input_aw_payload_qos        (io_inputs_0_aw_payload_qos[3:0]                     ), //i
    .io_input_aw_payload_prot       (io_inputs_0_aw_payload_prot[2:0]                    ), //i
    .io_input_w_valid               (io_inputs_0_w_valid                                 ), //i
    .io_input_w_ready               (up_0_logic_io_input_w_ready                         ), //o
    .io_input_w_payload_data        (io_inputs_0_w_payload_data[31:0]                    ), //i
    .io_input_w_payload_strb        (io_inputs_0_w_payload_strb[3:0]                     ), //i
    .io_input_w_payload_last        (io_inputs_0_w_payload_last                          ), //i
    .io_input_b_valid               (up_0_logic_io_input_b_valid                         ), //o
    .io_input_b_ready               (io_inputs_0_b_ready                                 ), //i
    .io_input_b_payload_id          (up_0_logic_io_input_b_payload_id[3:0]               ), //o
    .io_input_b_payload_resp        (up_0_logic_io_input_b_payload_resp[1:0]             ), //o
    .io_input_ar_valid              (io_inputs_0_ar_valid                                ), //i
    .io_input_ar_ready              (up_0_logic_io_input_ar_ready                        ), //o
    .io_input_ar_payload_addr       (io_inputs_0_ar_payload_addr[31:0]                   ), //i
    .io_input_ar_payload_id         (io_inputs_0_ar_payload_id[3:0]                      ), //i
    .io_input_ar_payload_region     (io_inputs_0_ar_payload_region[3:0]                  ), //i
    .io_input_ar_payload_len        (io_inputs_0_ar_payload_len[7:0]                     ), //i
    .io_input_ar_payload_size       (io_inputs_0_ar_payload_size[2:0]                    ), //i
    .io_input_ar_payload_burst      (io_inputs_0_ar_payload_burst[1:0]                   ), //i
    .io_input_ar_payload_lock       (io_inputs_0_ar_payload_lock                         ), //i
    .io_input_ar_payload_cache      (io_inputs_0_ar_payload_cache[3:0]                   ), //i
    .io_input_ar_payload_qos        (io_inputs_0_ar_payload_qos[3:0]                     ), //i
    .io_input_ar_payload_prot       (io_inputs_0_ar_payload_prot[2:0]                    ), //i
    .io_input_r_valid               (up_0_logic_io_input_r_valid                         ), //o
    .io_input_r_ready               (io_inputs_0_r_ready                                 ), //i
    .io_input_r_payload_data        (up_0_logic_io_input_r_payload_data[31:0]            ), //o
    .io_input_r_payload_id          (up_0_logic_io_input_r_payload_id[3:0]               ), //o
    .io_input_r_payload_resp        (up_0_logic_io_input_r_payload_resp[1:0]             ), //o
    .io_input_r_payload_last        (up_0_logic_io_input_r_payload_last                  ), //o
    .io_output_aw_valid             (up_0_logic_io_output_aw_valid                       ), //o
    .io_output_aw_ready             (arbiter_writeOnly_io_inputs_0_aw_ready              ), //i
    .io_output_aw_payload_addr      (up_0_logic_io_output_aw_payload_addr[31:0]          ), //o
    .io_output_aw_payload_id        (up_0_logic_io_output_aw_payload_id[3:0]             ), //o
    .io_output_aw_payload_region    (up_0_logic_io_output_aw_payload_region[3:0]         ), //o
    .io_output_aw_payload_len       (up_0_logic_io_output_aw_payload_len[7:0]            ), //o
    .io_output_aw_payload_size      (up_0_logic_io_output_aw_payload_size[2:0]           ), //o
    .io_output_aw_payload_burst     (up_0_logic_io_output_aw_payload_burst[1:0]          ), //o
    .io_output_aw_payload_lock      (up_0_logic_io_output_aw_payload_lock                ), //o
    .io_output_aw_payload_cache     (up_0_logic_io_output_aw_payload_cache[3:0]          ), //o
    .io_output_aw_payload_qos       (up_0_logic_io_output_aw_payload_qos[3:0]            ), //o
    .io_output_aw_payload_prot      (up_0_logic_io_output_aw_payload_prot[2:0]           ), //o
    .io_output_w_valid              (up_0_logic_io_output_w_valid                        ), //o
    .io_output_w_ready              (arbiter_writeOnly_io_inputs_0_w_ready               ), //i
    .io_output_w_payload_data       (up_0_logic_io_output_w_payload_data[255:0]          ), //o
    .io_output_w_payload_strb       (up_0_logic_io_output_w_payload_strb[31:0]           ), //o
    .io_output_w_payload_last       (up_0_logic_io_output_w_payload_last                 ), //o
    .io_output_b_valid              (arbiter_writeOnly_io_inputs_0_b_valid               ), //i
    .io_output_b_ready              (up_0_logic_io_output_b_ready                        ), //o
    .io_output_b_payload_id         (arbiter_writeOnly_io_inputs_0_b_payload_id[3:0]     ), //i
    .io_output_b_payload_resp       (arbiter_writeOnly_io_inputs_0_b_payload_resp[1:0]   ), //i
    .io_output_ar_valid             (up_0_logic_io_output_ar_valid                       ), //o
    .io_output_ar_ready             (arbiter_readOnly_io_inputs_0_ar_ready               ), //i
    .io_output_ar_payload_addr      (up_0_logic_io_output_ar_payload_addr[31:0]          ), //o
    .io_output_ar_payload_id        (up_0_logic_io_output_ar_payload_id[3:0]             ), //o
    .io_output_ar_payload_region    (up_0_logic_io_output_ar_payload_region[3:0]         ), //o
    .io_output_ar_payload_len       (up_0_logic_io_output_ar_payload_len[7:0]            ), //o
    .io_output_ar_payload_size      (up_0_logic_io_output_ar_payload_size[2:0]           ), //o
    .io_output_ar_payload_burst     (up_0_logic_io_output_ar_payload_burst[1:0]          ), //o
    .io_output_ar_payload_lock      (up_0_logic_io_output_ar_payload_lock                ), //o
    .io_output_ar_payload_cache     (up_0_logic_io_output_ar_payload_cache[3:0]          ), //o
    .io_output_ar_payload_qos       (up_0_logic_io_output_ar_payload_qos[3:0]            ), //o
    .io_output_ar_payload_prot      (up_0_logic_io_output_ar_payload_prot[2:0]           ), //o
    .io_output_r_valid              (arbiter_readOnly_io_inputs_0_r_valid                ), //i
    .io_output_r_ready              (up_0_logic_io_output_r_ready                        ), //o
    .io_output_r_payload_data       (arbiter_readOnly_io_inputs_0_r_payload_data[255:0]  ), //i
    .io_output_r_payload_id         (arbiter_readOnly_io_inputs_0_r_payload_id[3:0]      ), //i
    .io_output_r_payload_resp       (arbiter_readOnly_io_inputs_0_r_payload_resp[1:0]    ), //i
    .io_output_r_payload_last       (arbiter_readOnly_io_inputs_0_r_payload_last         ), //i
    .clk                            (clk                                                 ), //i
    .reset                          (reset                                               )  //i
  );
  Axi4Upsizer up_1_logic (
    .io_input_aw_valid              (io_inputs_1_aw_valid                                ), //i
    .io_input_aw_ready              (up_1_logic_io_input_aw_ready                        ), //o
    .io_input_aw_payload_addr       (io_inputs_1_aw_payload_addr[31:0]                   ), //i
    .io_input_aw_payload_id         (io_inputs_1_aw_payload_id[3:0]                      ), //i
    .io_input_aw_payload_region     (io_inputs_1_aw_payload_region[3:0]                  ), //i
    .io_input_aw_payload_len        (io_inputs_1_aw_payload_len[7:0]                     ), //i
    .io_input_aw_payload_size       (io_inputs_1_aw_payload_size[2:0]                    ), //i
    .io_input_aw_payload_burst      (io_inputs_1_aw_payload_burst[1:0]                   ), //i
    .io_input_aw_payload_lock       (io_inputs_1_aw_payload_lock                         ), //i
    .io_input_aw_payload_cache      (io_inputs_1_aw_payload_cache[3:0]                   ), //i
    .io_input_aw_payload_qos        (io_inputs_1_aw_payload_qos[3:0]                     ), //i
    .io_input_aw_payload_prot       (io_inputs_1_aw_payload_prot[2:0]                    ), //i
    .io_input_w_valid               (io_inputs_1_w_valid                                 ), //i
    .io_input_w_ready               (up_1_logic_io_input_w_ready                         ), //o
    .io_input_w_payload_data        (io_inputs_1_w_payload_data[31:0]                    ), //i
    .io_input_w_payload_strb        (io_inputs_1_w_payload_strb[3:0]                     ), //i
    .io_input_w_payload_last        (io_inputs_1_w_payload_last                          ), //i
    .io_input_b_valid               (up_1_logic_io_input_b_valid                         ), //o
    .io_input_b_ready               (io_inputs_1_b_ready                                 ), //i
    .io_input_b_payload_id          (up_1_logic_io_input_b_payload_id[3:0]               ), //o
    .io_input_b_payload_resp        (up_1_logic_io_input_b_payload_resp[1:0]             ), //o
    .io_input_ar_valid              (io_inputs_1_ar_valid                                ), //i
    .io_input_ar_ready              (up_1_logic_io_input_ar_ready                        ), //o
    .io_input_ar_payload_addr       (io_inputs_1_ar_payload_addr[31:0]                   ), //i
    .io_input_ar_payload_id         (io_inputs_1_ar_payload_id[3:0]                      ), //i
    .io_input_ar_payload_region     (io_inputs_1_ar_payload_region[3:0]                  ), //i
    .io_input_ar_payload_len        (io_inputs_1_ar_payload_len[7:0]                     ), //i
    .io_input_ar_payload_size       (io_inputs_1_ar_payload_size[2:0]                    ), //i
    .io_input_ar_payload_burst      (io_inputs_1_ar_payload_burst[1:0]                   ), //i
    .io_input_ar_payload_lock       (io_inputs_1_ar_payload_lock                         ), //i
    .io_input_ar_payload_cache      (io_inputs_1_ar_payload_cache[3:0]                   ), //i
    .io_input_ar_payload_qos        (io_inputs_1_ar_payload_qos[3:0]                     ), //i
    .io_input_ar_payload_prot       (io_inputs_1_ar_payload_prot[2:0]                    ), //i
    .io_input_r_valid               (up_1_logic_io_input_r_valid                         ), //o
    .io_input_r_ready               (io_inputs_1_r_ready                                 ), //i
    .io_input_r_payload_data        (up_1_logic_io_input_r_payload_data[31:0]            ), //o
    .io_input_r_payload_id          (up_1_logic_io_input_r_payload_id[3:0]               ), //o
    .io_input_r_payload_resp        (up_1_logic_io_input_r_payload_resp[1:0]             ), //o
    .io_input_r_payload_last        (up_1_logic_io_input_r_payload_last                  ), //o
    .io_output_aw_valid             (up_1_logic_io_output_aw_valid                       ), //o
    .io_output_aw_ready             (arbiter_writeOnly_io_inputs_1_aw_ready              ), //i
    .io_output_aw_payload_addr      (up_1_logic_io_output_aw_payload_addr[31:0]          ), //o
    .io_output_aw_payload_id        (up_1_logic_io_output_aw_payload_id[3:0]             ), //o
    .io_output_aw_payload_region    (up_1_logic_io_output_aw_payload_region[3:0]         ), //o
    .io_output_aw_payload_len       (up_1_logic_io_output_aw_payload_len[7:0]            ), //o
    .io_output_aw_payload_size      (up_1_logic_io_output_aw_payload_size[2:0]           ), //o
    .io_output_aw_payload_burst     (up_1_logic_io_output_aw_payload_burst[1:0]          ), //o
    .io_output_aw_payload_lock      (up_1_logic_io_output_aw_payload_lock                ), //o
    .io_output_aw_payload_cache     (up_1_logic_io_output_aw_payload_cache[3:0]          ), //o
    .io_output_aw_payload_qos       (up_1_logic_io_output_aw_payload_qos[3:0]            ), //o
    .io_output_aw_payload_prot      (up_1_logic_io_output_aw_payload_prot[2:0]           ), //o
    .io_output_w_valid              (up_1_logic_io_output_w_valid                        ), //o
    .io_output_w_ready              (arbiter_writeOnly_io_inputs_1_w_ready               ), //i
    .io_output_w_payload_data       (up_1_logic_io_output_w_payload_data[255:0]          ), //o
    .io_output_w_payload_strb       (up_1_logic_io_output_w_payload_strb[31:0]           ), //o
    .io_output_w_payload_last       (up_1_logic_io_output_w_payload_last                 ), //o
    .io_output_b_valid              (arbiter_writeOnly_io_inputs_1_b_valid               ), //i
    .io_output_b_ready              (up_1_logic_io_output_b_ready                        ), //o
    .io_output_b_payload_id         (arbiter_writeOnly_io_inputs_1_b_payload_id[3:0]     ), //i
    .io_output_b_payload_resp       (arbiter_writeOnly_io_inputs_1_b_payload_resp[1:0]   ), //i
    .io_output_ar_valid             (up_1_logic_io_output_ar_valid                       ), //o
    .io_output_ar_ready             (arbiter_readOnly_io_inputs_1_ar_ready               ), //i
    .io_output_ar_payload_addr      (up_1_logic_io_output_ar_payload_addr[31:0]          ), //o
    .io_output_ar_payload_id        (up_1_logic_io_output_ar_payload_id[3:0]             ), //o
    .io_output_ar_payload_region    (up_1_logic_io_output_ar_payload_region[3:0]         ), //o
    .io_output_ar_payload_len       (up_1_logic_io_output_ar_payload_len[7:0]            ), //o
    .io_output_ar_payload_size      (up_1_logic_io_output_ar_payload_size[2:0]           ), //o
    .io_output_ar_payload_burst     (up_1_logic_io_output_ar_payload_burst[1:0]          ), //o
    .io_output_ar_payload_lock      (up_1_logic_io_output_ar_payload_lock                ), //o
    .io_output_ar_payload_cache     (up_1_logic_io_output_ar_payload_cache[3:0]          ), //o
    .io_output_ar_payload_qos       (up_1_logic_io_output_ar_payload_qos[3:0]            ), //o
    .io_output_ar_payload_prot      (up_1_logic_io_output_ar_payload_prot[2:0]           ), //o
    .io_output_r_valid              (arbiter_readOnly_io_inputs_1_r_valid                ), //i
    .io_output_r_ready              (up_1_logic_io_output_r_ready                        ), //o
    .io_output_r_payload_data       (arbiter_readOnly_io_inputs_1_r_payload_data[255:0]  ), //i
    .io_output_r_payload_id         (arbiter_readOnly_io_inputs_1_r_payload_id[3:0]      ), //i
    .io_output_r_payload_resp       (arbiter_readOnly_io_inputs_1_r_payload_resp[1:0]    ), //i
    .io_output_r_payload_last       (arbiter_readOnly_io_inputs_1_r_payload_last         ), //i
    .clk                            (clk                                                 ), //i
    .reset                          (reset                                               )  //i
  );
  Axi4ReadOnlyArbiter arbiter_readOnly (
    .io_inputs_0_ar_valid             (up_0_logic_io_output_ar_valid                       ), //i
    .io_inputs_0_ar_ready             (arbiter_readOnly_io_inputs_0_ar_ready               ), //o
    .io_inputs_0_ar_payload_addr      (up_0_logic_io_output_ar_payload_addr[31:0]          ), //i
    .io_inputs_0_ar_payload_id        (up_0_logic_io_output_ar_payload_id[3:0]             ), //i
    .io_inputs_0_ar_payload_region    (up_0_logic_io_output_ar_payload_region[3:0]         ), //i
    .io_inputs_0_ar_payload_len       (up_0_logic_io_output_ar_payload_len[7:0]            ), //i
    .io_inputs_0_ar_payload_size      (up_0_logic_io_output_ar_payload_size[2:0]           ), //i
    .io_inputs_0_ar_payload_burst     (up_0_logic_io_output_ar_payload_burst[1:0]          ), //i
    .io_inputs_0_ar_payload_lock      (up_0_logic_io_output_ar_payload_lock                ), //i
    .io_inputs_0_ar_payload_cache     (up_0_logic_io_output_ar_payload_cache[3:0]          ), //i
    .io_inputs_0_ar_payload_qos       (up_0_logic_io_output_ar_payload_qos[3:0]            ), //i
    .io_inputs_0_ar_payload_prot      (up_0_logic_io_output_ar_payload_prot[2:0]           ), //i
    .io_inputs_0_r_valid              (arbiter_readOnly_io_inputs_0_r_valid                ), //o
    .io_inputs_0_r_ready              (up_0_logic_io_output_r_ready                        ), //i
    .io_inputs_0_r_payload_data       (arbiter_readOnly_io_inputs_0_r_payload_data[255:0]  ), //o
    .io_inputs_0_r_payload_id         (arbiter_readOnly_io_inputs_0_r_payload_id[3:0]      ), //o
    .io_inputs_0_r_payload_resp       (arbiter_readOnly_io_inputs_0_r_payload_resp[1:0]    ), //o
    .io_inputs_0_r_payload_last       (arbiter_readOnly_io_inputs_0_r_payload_last         ), //o
    .io_inputs_1_ar_valid             (up_1_logic_io_output_ar_valid                       ), //i
    .io_inputs_1_ar_ready             (arbiter_readOnly_io_inputs_1_ar_ready               ), //o
    .io_inputs_1_ar_payload_addr      (up_1_logic_io_output_ar_payload_addr[31:0]          ), //i
    .io_inputs_1_ar_payload_id        (up_1_logic_io_output_ar_payload_id[3:0]             ), //i
    .io_inputs_1_ar_payload_region    (up_1_logic_io_output_ar_payload_region[3:0]         ), //i
    .io_inputs_1_ar_payload_len       (up_1_logic_io_output_ar_payload_len[7:0]            ), //i
    .io_inputs_1_ar_payload_size      (up_1_logic_io_output_ar_payload_size[2:0]           ), //i
    .io_inputs_1_ar_payload_burst     (up_1_logic_io_output_ar_payload_burst[1:0]          ), //i
    .io_inputs_1_ar_payload_lock      (up_1_logic_io_output_ar_payload_lock                ), //i
    .io_inputs_1_ar_payload_cache     (up_1_logic_io_output_ar_payload_cache[3:0]          ), //i
    .io_inputs_1_ar_payload_qos       (up_1_logic_io_output_ar_payload_qos[3:0]            ), //i
    .io_inputs_1_ar_payload_prot      (up_1_logic_io_output_ar_payload_prot[2:0]           ), //i
    .io_inputs_1_r_valid              (arbiter_readOnly_io_inputs_1_r_valid                ), //o
    .io_inputs_1_r_ready              (up_1_logic_io_output_r_ready                        ), //i
    .io_inputs_1_r_payload_data       (arbiter_readOnly_io_inputs_1_r_payload_data[255:0]  ), //o
    .io_inputs_1_r_payload_id         (arbiter_readOnly_io_inputs_1_r_payload_id[3:0]      ), //o
    .io_inputs_1_r_payload_resp       (arbiter_readOnly_io_inputs_1_r_payload_resp[1:0]    ), //o
    .io_inputs_1_r_payload_last       (arbiter_readOnly_io_inputs_1_r_payload_last         ), //o
    .io_output_ar_valid               (arbiter_readOnly_io_output_ar_valid                 ), //o
    .io_output_ar_ready               (arbiter_readOnly_io_output_ar_halfPipe_regs_ready   ), //i
    .io_output_ar_payload_addr        (arbiter_readOnly_io_output_ar_payload_addr[31:0]    ), //o
    .io_output_ar_payload_id          (arbiter_readOnly_io_output_ar_payload_id[4:0]       ), //o
    .io_output_ar_payload_region      (arbiter_readOnly_io_output_ar_payload_region[3:0]   ), //o
    .io_output_ar_payload_len         (arbiter_readOnly_io_output_ar_payload_len[7:0]      ), //o
    .io_output_ar_payload_size        (arbiter_readOnly_io_output_ar_payload_size[2:0]     ), //o
    .io_output_ar_payload_burst       (arbiter_readOnly_io_output_ar_payload_burst[1:0]    ), //o
    .io_output_ar_payload_lock        (arbiter_readOnly_io_output_ar_payload_lock          ), //o
    .io_output_ar_payload_cache       (arbiter_readOnly_io_output_ar_payload_cache[3:0]    ), //o
    .io_output_ar_payload_qos         (arbiter_readOnly_io_output_ar_payload_qos[3:0]      ), //o
    .io_output_ar_payload_prot        (arbiter_readOnly_io_output_ar_payload_prot[2:0]     ), //o
    .io_output_r_valid                (arbiter_axi4_r_m2sPipe_s2mPipe_valid                ), //i
    .io_output_r_ready                (arbiter_readOnly_io_output_r_ready                  ), //o
    .io_output_r_payload_data         (arbiter_axi4_r_m2sPipe_s2mPipe_payload_data[255:0]  ), //i
    .io_output_r_payload_id           (arbiter_axi4_r_m2sPipe_s2mPipe_payload_id[4:0]      ), //i
    .io_output_r_payload_resp         (arbiter_axi4_r_m2sPipe_s2mPipe_payload_resp[1:0]    ), //i
    .io_output_r_payload_last         (arbiter_axi4_r_m2sPipe_s2mPipe_payload_last         ), //i
    .clk                              (clk                                                 ), //i
    .reset                            (reset                                               )  //i
  );
  Axi4WriteOnlyArbiter arbiter_writeOnly (
    .io_inputs_0_aw_valid             (up_0_logic_io_output_aw_valid                       ), //i
    .io_inputs_0_aw_ready             (arbiter_writeOnly_io_inputs_0_aw_ready              ), //o
    .io_inputs_0_aw_payload_addr      (up_0_logic_io_output_aw_payload_addr[31:0]          ), //i
    .io_inputs_0_aw_payload_id        (up_0_logic_io_output_aw_payload_id[3:0]             ), //i
    .io_inputs_0_aw_payload_region    (up_0_logic_io_output_aw_payload_region[3:0]         ), //i
    .io_inputs_0_aw_payload_len       (up_0_logic_io_output_aw_payload_len[7:0]            ), //i
    .io_inputs_0_aw_payload_size      (up_0_logic_io_output_aw_payload_size[2:0]           ), //i
    .io_inputs_0_aw_payload_burst     (up_0_logic_io_output_aw_payload_burst[1:0]          ), //i
    .io_inputs_0_aw_payload_lock      (up_0_logic_io_output_aw_payload_lock                ), //i
    .io_inputs_0_aw_payload_cache     (up_0_logic_io_output_aw_payload_cache[3:0]          ), //i
    .io_inputs_0_aw_payload_qos       (up_0_logic_io_output_aw_payload_qos[3:0]            ), //i
    .io_inputs_0_aw_payload_prot      (up_0_logic_io_output_aw_payload_prot[2:0]           ), //i
    .io_inputs_0_w_valid              (up_0_logic_io_output_w_valid                        ), //i
    .io_inputs_0_w_ready              (arbiter_writeOnly_io_inputs_0_w_ready               ), //o
    .io_inputs_0_w_payload_data       (up_0_logic_io_output_w_payload_data[255:0]          ), //i
    .io_inputs_0_w_payload_strb       (up_0_logic_io_output_w_payload_strb[31:0]           ), //i
    .io_inputs_0_w_payload_last       (up_0_logic_io_output_w_payload_last                 ), //i
    .io_inputs_0_b_valid              (arbiter_writeOnly_io_inputs_0_b_valid               ), //o
    .io_inputs_0_b_ready              (up_0_logic_io_output_b_ready                        ), //i
    .io_inputs_0_b_payload_id         (arbiter_writeOnly_io_inputs_0_b_payload_id[3:0]     ), //o
    .io_inputs_0_b_payload_resp       (arbiter_writeOnly_io_inputs_0_b_payload_resp[1:0]   ), //o
    .io_inputs_1_aw_valid             (up_1_logic_io_output_aw_valid                       ), //i
    .io_inputs_1_aw_ready             (arbiter_writeOnly_io_inputs_1_aw_ready              ), //o
    .io_inputs_1_aw_payload_addr      (up_1_logic_io_output_aw_payload_addr[31:0]          ), //i
    .io_inputs_1_aw_payload_id        (up_1_logic_io_output_aw_payload_id[3:0]             ), //i
    .io_inputs_1_aw_payload_region    (up_1_logic_io_output_aw_payload_region[3:0]         ), //i
    .io_inputs_1_aw_payload_len       (up_1_logic_io_output_aw_payload_len[7:0]            ), //i
    .io_inputs_1_aw_payload_size      (up_1_logic_io_output_aw_payload_size[2:0]           ), //i
    .io_inputs_1_aw_payload_burst     (up_1_logic_io_output_aw_payload_burst[1:0]          ), //i
    .io_inputs_1_aw_payload_lock      (up_1_logic_io_output_aw_payload_lock                ), //i
    .io_inputs_1_aw_payload_cache     (up_1_logic_io_output_aw_payload_cache[3:0]          ), //i
    .io_inputs_1_aw_payload_qos       (up_1_logic_io_output_aw_payload_qos[3:0]            ), //i
    .io_inputs_1_aw_payload_prot      (up_1_logic_io_output_aw_payload_prot[2:0]           ), //i
    .io_inputs_1_w_valid              (up_1_logic_io_output_w_valid                        ), //i
    .io_inputs_1_w_ready              (arbiter_writeOnly_io_inputs_1_w_ready               ), //o
    .io_inputs_1_w_payload_data       (up_1_logic_io_output_w_payload_data[255:0]          ), //i
    .io_inputs_1_w_payload_strb       (up_1_logic_io_output_w_payload_strb[31:0]           ), //i
    .io_inputs_1_w_payload_last       (up_1_logic_io_output_w_payload_last                 ), //i
    .io_inputs_1_b_valid              (arbiter_writeOnly_io_inputs_1_b_valid               ), //o
    .io_inputs_1_b_ready              (up_1_logic_io_output_b_ready                        ), //i
    .io_inputs_1_b_payload_id         (arbiter_writeOnly_io_inputs_1_b_payload_id[3:0]     ), //o
    .io_inputs_1_b_payload_resp       (arbiter_writeOnly_io_inputs_1_b_payload_resp[1:0]   ), //o
    .io_output_aw_valid               (arbiter_writeOnly_io_output_aw_valid                ), //o
    .io_output_aw_ready               (arbiter_writeOnly_io_output_aw_halfPipe_regs_ready  ), //i
    .io_output_aw_payload_addr        (arbiter_writeOnly_io_output_aw_payload_addr[31:0]   ), //o
    .io_output_aw_payload_id          (arbiter_writeOnly_io_output_aw_payload_id[4:0]      ), //o
    .io_output_aw_payload_region      (arbiter_writeOnly_io_output_aw_payload_region[3:0]  ), //o
    .io_output_aw_payload_len         (arbiter_writeOnly_io_output_aw_payload_len[7:0]     ), //o
    .io_output_aw_payload_size        (arbiter_writeOnly_io_output_aw_payload_size[2:0]    ), //o
    .io_output_aw_payload_burst       (arbiter_writeOnly_io_output_aw_payload_burst[1:0]   ), //o
    .io_output_aw_payload_lock        (arbiter_writeOnly_io_output_aw_payload_lock         ), //o
    .io_output_aw_payload_cache       (arbiter_writeOnly_io_output_aw_payload_cache[3:0]   ), //o
    .io_output_aw_payload_qos         (arbiter_writeOnly_io_output_aw_payload_qos[3:0]     ), //o
    .io_output_aw_payload_prot        (arbiter_writeOnly_io_output_aw_payload_prot[2:0]    ), //o
    .io_output_w_valid                (arbiter_writeOnly_io_output_w_valid                 ), //o
    .io_output_w_ready                (_zz_1                                               ), //i
    .io_output_w_payload_data         (arbiter_writeOnly_io_output_w_payload_data[255:0]   ), //o
    .io_output_w_payload_strb         (arbiter_writeOnly_io_output_w_payload_strb[31:0]    ), //o
    .io_output_w_payload_last         (arbiter_writeOnly_io_output_w_payload_last          ), //o
    .io_output_b_valid                (arbiter_axi4_b_halfPipe_valid                       ), //i
    .io_output_b_ready                (arbiter_writeOnly_io_output_b_ready                 ), //o
    .io_output_b_payload_id           (arbiter_axi4_b_halfPipe_payload_id[4:0]             ), //i
    .io_output_b_payload_resp         (arbiter_axi4_b_halfPipe_payload_resp[1:0]           ), //i
    .clk                              (clk                                                 ), //i
    .reset                            (reset                                               )  //i
  );
  StreamArbiter_2 streamArbiter_3 (
    .io_inputs_0_valid             (arbiter_axi4_ar_valid                          ), //i
    .io_inputs_0_ready             (streamArbiter_3_io_inputs_0_ready              ), //o
    .io_inputs_0_payload_addr      (arbiter_axi4_ar_payload_addr[31:0]             ), //i
    .io_inputs_0_payload_id        (arbiter_axi4_ar_payload_id[4:0]                ), //i
    .io_inputs_0_payload_region    (arbiter_axi4_ar_payload_region[3:0]            ), //i
    .io_inputs_0_payload_len       (arbiter_axi4_ar_payload_len[7:0]               ), //i
    .io_inputs_0_payload_size      (arbiter_axi4_ar_payload_size[2:0]              ), //i
    .io_inputs_0_payload_burst     (arbiter_axi4_ar_payload_burst[1:0]             ), //i
    .io_inputs_0_payload_lock      (arbiter_axi4_ar_payload_lock                   ), //i
    .io_inputs_0_payload_cache     (arbiter_axi4_ar_payload_cache[3:0]             ), //i
    .io_inputs_0_payload_qos       (arbiter_axi4_ar_payload_qos[3:0]               ), //i
    .io_inputs_0_payload_prot      (arbiter_axi4_ar_payload_prot[2:0]              ), //i
    .io_inputs_1_valid             (arbiter_axi4_aw_valid                          ), //i
    .io_inputs_1_ready             (streamArbiter_3_io_inputs_1_ready              ), //o
    .io_inputs_1_payload_addr      (arbiter_axi4_aw_payload_addr[31:0]             ), //i
    .io_inputs_1_payload_id        (arbiter_axi4_aw_payload_id[4:0]                ), //i
    .io_inputs_1_payload_region    (arbiter_axi4_aw_payload_region[3:0]            ), //i
    .io_inputs_1_payload_len       (arbiter_axi4_aw_payload_len[7:0]               ), //i
    .io_inputs_1_payload_size      (arbiter_axi4_aw_payload_size[2:0]              ), //i
    .io_inputs_1_payload_burst     (arbiter_axi4_aw_payload_burst[1:0]             ), //i
    .io_inputs_1_payload_lock      (arbiter_axi4_aw_payload_lock                   ), //i
    .io_inputs_1_payload_cache     (arbiter_axi4_aw_payload_cache[3:0]             ), //i
    .io_inputs_1_payload_qos       (arbiter_axi4_aw_payload_qos[3:0]               ), //i
    .io_inputs_1_payload_prot      (arbiter_axi4_aw_payload_prot[2:0]              ), //i
    .io_output_valid               (streamArbiter_3_io_output_valid                ), //o
    .io_output_ready               (shared_arw_ready                               ), //i
    .io_output_payload_addr        (streamArbiter_3_io_output_payload_addr[31:0]   ), //o
    .io_output_payload_id          (streamArbiter_3_io_output_payload_id[4:0]      ), //o
    .io_output_payload_region      (streamArbiter_3_io_output_payload_region[3:0]  ), //o
    .io_output_payload_len         (streamArbiter_3_io_output_payload_len[7:0]     ), //o
    .io_output_payload_size        (streamArbiter_3_io_output_payload_size[2:0]    ), //o
    .io_output_payload_burst       (streamArbiter_3_io_output_payload_burst[1:0]   ), //o
    .io_output_payload_lock        (streamArbiter_3_io_output_payload_lock         ), //o
    .io_output_payload_cache       (streamArbiter_3_io_output_payload_cache[3:0]   ), //o
    .io_output_payload_qos         (streamArbiter_3_io_output_payload_qos[3:0]     ), //o
    .io_output_payload_prot        (streamArbiter_3_io_output_payload_prot[2:0]    ), //o
    .io_chosen                     (streamArbiter_3_io_chosen                      ), //o
    .io_chosenOH                   (streamArbiter_3_io_chosenOH[1:0]               ), //o
    .clk                           (clk                                            ), //i
    .reset                         (reset                                          )  //i
  );
  Axi4SharedToAxi3Shared toAxi3 (
    .io_input_arw_valid              (shared_arw_valid                          ), //i
    .io_input_arw_ready              (toAxi3_io_input_arw_ready                 ), //o
    .io_input_arw_payload_addr       (shared_arw_payload_addr[31:0]             ), //i
    .io_input_arw_payload_id         (shared_arw_payload_id[4:0]                ), //i
    .io_input_arw_payload_region     (shared_arw_payload_region[3:0]            ), //i
    .io_input_arw_payload_len        (shared_arw_payload_len[7:0]               ), //i
    .io_input_arw_payload_size       (shared_arw_payload_size[2:0]              ), //i
    .io_input_arw_payload_burst      (shared_arw_payload_burst[1:0]             ), //i
    .io_input_arw_payload_lock       (shared_arw_payload_lock                   ), //i
    .io_input_arw_payload_cache      (shared_arw_payload_cache[3:0]             ), //i
    .io_input_arw_payload_qos        (shared_arw_payload_qos[3:0]               ), //i
    .io_input_arw_payload_prot       (shared_arw_payload_prot[2:0]              ), //i
    .io_input_arw_payload_write      (shared_arw_payload_write                  ), //i
    .io_input_w_valid                (shared_w_valid                            ), //i
    .io_input_w_ready                (toAxi3_io_input_w_ready                   ), //o
    .io_input_w_payload_data         (shared_w_payload_data[255:0]              ), //i
    .io_input_w_payload_strb         (shared_w_payload_strb[31:0]               ), //i
    .io_input_w_payload_last         (shared_w_payload_last                     ), //i
    .io_input_b_valid                (toAxi3_io_input_b_valid                   ), //o
    .io_input_b_ready                (shared_b_ready                            ), //i
    .io_input_b_payload_id           (toAxi3_io_input_b_payload_id[4:0]         ), //o
    .io_input_b_payload_resp         (toAxi3_io_input_b_payload_resp[1:0]       ), //o
    .io_input_r_valid                (toAxi3_io_input_r_valid                   ), //o
    .io_input_r_ready                (shared_r_ready                            ), //i
    .io_input_r_payload_data         (toAxi3_io_input_r_payload_data[255:0]     ), //o
    .io_input_r_payload_id           (toAxi3_io_input_r_payload_id[4:0]         ), //o
    .io_input_r_payload_resp         (toAxi3_io_input_r_payload_resp[1:0]       ), //o
    .io_input_r_payload_last         (toAxi3_io_input_r_payload_last            ), //o
    .io_output_arw_valid             (toAxi3_io_output_arw_valid                ), //o
    .io_output_arw_ready             (io_output_arw_ready                       ), //i
    .io_output_arw_payload_addr      (toAxi3_io_output_arw_payload_addr[31:0]   ), //o
    .io_output_arw_payload_id        (toAxi3_io_output_arw_payload_id[4:0]      ), //o
    .io_output_arw_payload_region    (toAxi3_io_output_arw_payload_region[3:0]  ), //o
    .io_output_arw_payload_len       (toAxi3_io_output_arw_payload_len[7:0]     ), //o
    .io_output_arw_payload_size      (toAxi3_io_output_arw_payload_size[2:0]    ), //o
    .io_output_arw_payload_burst     (toAxi3_io_output_arw_payload_burst[1:0]   ), //o
    .io_output_arw_payload_lock      (toAxi3_io_output_arw_payload_lock         ), //o
    .io_output_arw_payload_cache     (toAxi3_io_output_arw_payload_cache[3:0]   ), //o
    .io_output_arw_payload_qos       (toAxi3_io_output_arw_payload_qos[3:0]     ), //o
    .io_output_arw_payload_prot      (toAxi3_io_output_arw_payload_prot[2:0]    ), //o
    .io_output_arw_payload_write     (toAxi3_io_output_arw_payload_write        ), //o
    .io_output_w_valid               (toAxi3_io_output_w_valid                  ), //o
    .io_output_w_ready               (io_output_w_ready                         ), //i
    .io_output_w_payload_data        (toAxi3_io_output_w_payload_data[255:0]    ), //o
    .io_output_w_payload_strb        (toAxi3_io_output_w_payload_strb[31:0]     ), //o
    .io_output_w_payload_last        (toAxi3_io_output_w_payload_last           ), //o
    .io_output_b_valid               (io_output_b_valid                         ), //i
    .io_output_b_ready               (toAxi3_io_output_b_ready                  ), //o
    .io_output_b_payload_id          (io_output_b_payload_id[4:0]               ), //i
    .io_output_b_payload_resp        (io_output_b_payload_resp[1:0]             ), //i
    .io_output_r_valid               (io_output_r_valid                         ), //i
    .io_output_r_ready               (toAxi3_io_output_r_ready                  ), //o
    .io_output_r_payload_data        (io_output_r_payload_data[255:0]           ), //i
    .io_output_r_payload_id          (io_output_r_payload_id[4:0]               ), //i
    .io_output_r_payload_resp        (io_output_r_payload_resp[1:0]             ), //i
    .io_output_r_payload_last        (io_output_r_payload_last                  ), //i
    .io_output_aw_id                 (toAxi3_io_output_aw_id[4:0]               ), //o
    .clk                             (clk                                       ), //i
    .reset                           (reset                                     )  //i
  );
  assign io_inputs_0_ar_ready = up_0_logic_io_input_ar_ready;
  assign io_inputs_0_aw_ready = up_0_logic_io_input_aw_ready;
  assign io_inputs_0_w_ready = up_0_logic_io_input_w_ready;
  assign io_inputs_0_r_valid = up_0_logic_io_input_r_valid;
  assign io_inputs_0_r_payload_data = up_0_logic_io_input_r_payload_data;
  assign io_inputs_0_r_payload_last = up_0_logic_io_input_r_payload_last;
  assign io_inputs_0_r_payload_id = up_0_logic_io_input_r_payload_id;
  assign io_inputs_0_r_payload_resp = up_0_logic_io_input_r_payload_resp;
  assign io_inputs_0_b_valid = up_0_logic_io_input_b_valid;
  assign io_inputs_0_b_payload_id = up_0_logic_io_input_b_payload_id;
  assign io_inputs_0_b_payload_resp = up_0_logic_io_input_b_payload_resp;
  assign io_inputs_1_ar_ready = up_1_logic_io_input_ar_ready;
  assign io_inputs_1_aw_ready = up_1_logic_io_input_aw_ready;
  assign io_inputs_1_w_ready = up_1_logic_io_input_w_ready;
  assign io_inputs_1_r_valid = up_1_logic_io_input_r_valid;
  assign io_inputs_1_r_payload_data = up_1_logic_io_input_r_payload_data;
  assign io_inputs_1_r_payload_last = up_1_logic_io_input_r_payload_last;
  assign io_inputs_1_r_payload_id = up_1_logic_io_input_r_payload_id;
  assign io_inputs_1_r_payload_resp = up_1_logic_io_input_r_payload_resp;
  assign io_inputs_1_b_valid = up_1_logic_io_input_b_valid;
  assign io_inputs_1_b_payload_id = up_1_logic_io_input_b_payload_id;
  assign io_inputs_1_b_payload_resp = up_1_logic_io_input_b_payload_resp;
  assign arbiter_readOnly_io_output_ar_halfPipe_valid = arbiter_readOnly_io_output_ar_halfPipe_regs_valid;
  assign arbiter_readOnly_io_output_ar_halfPipe_payload_addr = arbiter_readOnly_io_output_ar_halfPipe_regs_payload_addr;
  assign arbiter_readOnly_io_output_ar_halfPipe_payload_id = arbiter_readOnly_io_output_ar_halfPipe_regs_payload_id;
  assign arbiter_readOnly_io_output_ar_halfPipe_payload_region = arbiter_readOnly_io_output_ar_halfPipe_regs_payload_region;
  assign arbiter_readOnly_io_output_ar_halfPipe_payload_len = arbiter_readOnly_io_output_ar_halfPipe_regs_payload_len;
  assign arbiter_readOnly_io_output_ar_halfPipe_payload_size = arbiter_readOnly_io_output_ar_halfPipe_regs_payload_size;
  assign arbiter_readOnly_io_output_ar_halfPipe_payload_burst = arbiter_readOnly_io_output_ar_halfPipe_regs_payload_burst;
  assign arbiter_readOnly_io_output_ar_halfPipe_payload_lock = arbiter_readOnly_io_output_ar_halfPipe_regs_payload_lock;
  assign arbiter_readOnly_io_output_ar_halfPipe_payload_cache = arbiter_readOnly_io_output_ar_halfPipe_regs_payload_cache;
  assign arbiter_readOnly_io_output_ar_halfPipe_payload_qos = arbiter_readOnly_io_output_ar_halfPipe_regs_payload_qos;
  assign arbiter_readOnly_io_output_ar_halfPipe_payload_prot = arbiter_readOnly_io_output_ar_halfPipe_regs_payload_prot;
  assign arbiter_axi4_ar_valid = arbiter_readOnly_io_output_ar_halfPipe_valid;
  assign arbiter_readOnly_io_output_ar_halfPipe_ready = arbiter_axi4_ar_ready;
  assign arbiter_axi4_ar_payload_addr = arbiter_readOnly_io_output_ar_halfPipe_payload_addr;
  assign arbiter_axi4_ar_payload_id = arbiter_readOnly_io_output_ar_halfPipe_payload_id;
  assign arbiter_axi4_ar_payload_region = arbiter_readOnly_io_output_ar_halfPipe_payload_region;
  assign arbiter_axi4_ar_payload_len = arbiter_readOnly_io_output_ar_halfPipe_payload_len;
  assign arbiter_axi4_ar_payload_size = arbiter_readOnly_io_output_ar_halfPipe_payload_size;
  assign arbiter_axi4_ar_payload_burst = arbiter_readOnly_io_output_ar_halfPipe_payload_burst;
  assign arbiter_axi4_ar_payload_lock = arbiter_readOnly_io_output_ar_halfPipe_payload_lock;
  assign arbiter_axi4_ar_payload_cache = arbiter_readOnly_io_output_ar_halfPipe_payload_cache;
  assign arbiter_axi4_ar_payload_qos = arbiter_readOnly_io_output_ar_halfPipe_payload_qos;
  assign arbiter_axi4_ar_payload_prot = arbiter_readOnly_io_output_ar_halfPipe_payload_prot;
  assign arbiter_axi4_r_ready = ((1'b1 && (! arbiter_axi4_r_m2sPipe_valid)) || arbiter_axi4_r_m2sPipe_ready);
  assign arbiter_axi4_r_m2sPipe_valid = arbiter_axi4_r_m2sPipe_rValid;
  assign arbiter_axi4_r_m2sPipe_payload_data = arbiter_axi4_r_m2sPipe_rData_data;
  assign arbiter_axi4_r_m2sPipe_payload_id = arbiter_axi4_r_m2sPipe_rData_id;
  assign arbiter_axi4_r_m2sPipe_payload_resp = arbiter_axi4_r_m2sPipe_rData_resp;
  assign arbiter_axi4_r_m2sPipe_payload_last = arbiter_axi4_r_m2sPipe_rData_last;
  assign arbiter_axi4_r_m2sPipe_s2mPipe_valid = (arbiter_axi4_r_m2sPipe_valid || arbiter_axi4_r_m2sPipe_s2mPipe_rValid);
  assign arbiter_axi4_r_m2sPipe_ready = (! arbiter_axi4_r_m2sPipe_s2mPipe_rValid);
  assign arbiter_axi4_r_m2sPipe_s2mPipe_payload_data = (arbiter_axi4_r_m2sPipe_s2mPipe_rValid ? arbiter_axi4_r_m2sPipe_s2mPipe_rData_data : arbiter_axi4_r_m2sPipe_payload_data);
  assign arbiter_axi4_r_m2sPipe_s2mPipe_payload_id = (arbiter_axi4_r_m2sPipe_s2mPipe_rValid ? arbiter_axi4_r_m2sPipe_s2mPipe_rData_id : arbiter_axi4_r_m2sPipe_payload_id);
  assign arbiter_axi4_r_m2sPipe_s2mPipe_payload_resp = (arbiter_axi4_r_m2sPipe_s2mPipe_rValid ? arbiter_axi4_r_m2sPipe_s2mPipe_rData_resp : arbiter_axi4_r_m2sPipe_payload_resp);
  assign arbiter_axi4_r_m2sPipe_s2mPipe_payload_last = (arbiter_axi4_r_m2sPipe_s2mPipe_rValid ? arbiter_axi4_r_m2sPipe_s2mPipe_rData_last : arbiter_axi4_r_m2sPipe_payload_last);
  assign arbiter_axi4_r_m2sPipe_s2mPipe_ready = arbiter_readOnly_io_output_r_ready;
  assign arbiter_writeOnly_io_output_aw_halfPipe_valid = arbiter_writeOnly_io_output_aw_halfPipe_regs_valid;
  assign arbiter_writeOnly_io_output_aw_halfPipe_payload_addr = arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_addr;
  assign arbiter_writeOnly_io_output_aw_halfPipe_payload_id = arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_id;
  assign arbiter_writeOnly_io_output_aw_halfPipe_payload_region = arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_region;
  assign arbiter_writeOnly_io_output_aw_halfPipe_payload_len = arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_len;
  assign arbiter_writeOnly_io_output_aw_halfPipe_payload_size = arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_size;
  assign arbiter_writeOnly_io_output_aw_halfPipe_payload_burst = arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_burst;
  assign arbiter_writeOnly_io_output_aw_halfPipe_payload_lock = arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_lock;
  assign arbiter_writeOnly_io_output_aw_halfPipe_payload_cache = arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_cache;
  assign arbiter_writeOnly_io_output_aw_halfPipe_payload_qos = arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_qos;
  assign arbiter_writeOnly_io_output_aw_halfPipe_payload_prot = arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_prot;
  assign arbiter_axi4_aw_valid = arbiter_writeOnly_io_output_aw_halfPipe_valid;
  assign arbiter_writeOnly_io_output_aw_halfPipe_ready = arbiter_axi4_aw_ready;
  assign arbiter_axi4_aw_payload_addr = arbiter_writeOnly_io_output_aw_halfPipe_payload_addr;
  assign arbiter_axi4_aw_payload_id = arbiter_writeOnly_io_output_aw_halfPipe_payload_id;
  assign arbiter_axi4_aw_payload_region = arbiter_writeOnly_io_output_aw_halfPipe_payload_region;
  assign arbiter_axi4_aw_payload_len = arbiter_writeOnly_io_output_aw_halfPipe_payload_len;
  assign arbiter_axi4_aw_payload_size = arbiter_writeOnly_io_output_aw_halfPipe_payload_size;
  assign arbiter_axi4_aw_payload_burst = arbiter_writeOnly_io_output_aw_halfPipe_payload_burst;
  assign arbiter_axi4_aw_payload_lock = arbiter_writeOnly_io_output_aw_halfPipe_payload_lock;
  assign arbiter_axi4_aw_payload_cache = arbiter_writeOnly_io_output_aw_halfPipe_payload_cache;
  assign arbiter_axi4_aw_payload_qos = arbiter_writeOnly_io_output_aw_halfPipe_payload_qos;
  assign arbiter_axi4_aw_payload_prot = arbiter_writeOnly_io_output_aw_halfPipe_payload_prot;
  assign _zz_1 = ((1'b1 && (! arbiter_writeOnly_io_output_w_m2sPipe_valid)) || arbiter_writeOnly_io_output_w_m2sPipe_ready);
  assign arbiter_writeOnly_io_output_w_m2sPipe_valid = arbiter_writeOnly_io_output_w_m2sPipe_rValid;
  assign arbiter_writeOnly_io_output_w_m2sPipe_payload_data = arbiter_writeOnly_io_output_w_m2sPipe_rData_data;
  assign arbiter_writeOnly_io_output_w_m2sPipe_payload_strb = arbiter_writeOnly_io_output_w_m2sPipe_rData_strb;
  assign arbiter_writeOnly_io_output_w_m2sPipe_payload_last = arbiter_writeOnly_io_output_w_m2sPipe_rData_last;
  assign arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_valid = (arbiter_writeOnly_io_output_w_m2sPipe_valid || arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rValid);
  assign arbiter_writeOnly_io_output_w_m2sPipe_ready = (! arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rValid);
  assign arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_payload_data = (arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rValid ? arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rData_data : arbiter_writeOnly_io_output_w_m2sPipe_payload_data);
  assign arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_payload_strb = (arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rValid ? arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rData_strb : arbiter_writeOnly_io_output_w_m2sPipe_payload_strb);
  assign arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_payload_last = (arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rValid ? arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rData_last : arbiter_writeOnly_io_output_w_m2sPipe_payload_last);
  assign arbiter_axi4_w_valid = arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_valid;
  assign arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_ready = arbiter_axi4_w_ready;
  assign arbiter_axi4_w_payload_data = arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_payload_data;
  assign arbiter_axi4_w_payload_strb = arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_payload_strb;
  assign arbiter_axi4_w_payload_last = arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_payload_last;
  assign arbiter_axi4_b_halfPipe_valid = arbiter_axi4_b_halfPipe_regs_valid;
  assign arbiter_axi4_b_halfPipe_payload_id = arbiter_axi4_b_halfPipe_regs_payload_id;
  assign arbiter_axi4_b_halfPipe_payload_resp = arbiter_axi4_b_halfPipe_regs_payload_resp;
  assign arbiter_axi4_b_ready = arbiter_axi4_b_halfPipe_regs_ready;
  assign arbiter_axi4_b_halfPipe_ready = arbiter_writeOnly_io_output_b_ready;
  assign arbiter_axi4_ar_ready = streamArbiter_3_io_inputs_0_ready;
  assign arbiter_axi4_aw_ready = streamArbiter_3_io_inputs_1_ready;
  assign shared_arw_valid = streamArbiter_3_io_output_valid;
  assign shared_arw_payload_addr = streamArbiter_3_io_output_payload_addr;
  assign shared_arw_payload_id = streamArbiter_3_io_output_payload_id;
  assign shared_arw_payload_region = streamArbiter_3_io_output_payload_region;
  assign shared_arw_payload_len = streamArbiter_3_io_output_payload_len;
  assign shared_arw_payload_size = streamArbiter_3_io_output_payload_size;
  assign shared_arw_payload_burst = streamArbiter_3_io_output_payload_burst;
  assign shared_arw_payload_lock = streamArbiter_3_io_output_payload_lock;
  assign shared_arw_payload_cache = streamArbiter_3_io_output_payload_cache;
  assign shared_arw_payload_qos = streamArbiter_3_io_output_payload_qos;
  assign shared_arw_payload_prot = streamArbiter_3_io_output_payload_prot;
  assign shared_arw_payload_write = streamArbiter_3_io_chosenOH[1];
  assign shared_w_valid = arbiter_axi4_w_valid;
  assign arbiter_axi4_w_ready = shared_w_ready;
  assign shared_w_payload_data = arbiter_axi4_w_payload_data;
  assign shared_w_payload_strb = arbiter_axi4_w_payload_strb;
  assign shared_w_payload_last = arbiter_axi4_w_payload_last;
  assign arbiter_axi4_b_valid = shared_b_valid;
  assign shared_b_ready = arbiter_axi4_b_ready;
  assign arbiter_axi4_b_payload_id = shared_b_payload_id;
  assign arbiter_axi4_b_payload_resp = shared_b_payload_resp;
  assign arbiter_axi4_r_valid = shared_r_valid;
  assign shared_r_ready = arbiter_axi4_r_ready;
  assign arbiter_axi4_r_payload_data = shared_r_payload_data;
  assign arbiter_axi4_r_payload_id = shared_r_payload_id;
  assign arbiter_axi4_r_payload_resp = shared_r_payload_resp;
  assign arbiter_axi4_r_payload_last = shared_r_payload_last;
  assign shared_arw_ready = toAxi3_io_input_arw_ready;
  assign shared_w_ready = toAxi3_io_input_w_ready;
  assign shared_b_valid = toAxi3_io_input_b_valid;
  assign shared_b_payload_id = toAxi3_io_input_b_payload_id;
  assign shared_b_payload_resp = toAxi3_io_input_b_payload_resp;
  assign shared_r_valid = toAxi3_io_input_r_valid;
  assign shared_r_payload_data = toAxi3_io_input_r_payload_data;
  assign shared_r_payload_last = toAxi3_io_input_r_payload_last;
  assign shared_r_payload_id = toAxi3_io_input_r_payload_id;
  assign shared_r_payload_resp = toAxi3_io_input_r_payload_resp;
  assign io_output_arw_valid = toAxi3_io_output_arw_valid;
  assign io_output_arw_payload_addr = toAxi3_io_output_arw_payload_addr;
  assign io_output_arw_payload_id = toAxi3_io_output_arw_payload_id;
  assign io_output_arw_payload_region = toAxi3_io_output_arw_payload_region;
  assign io_output_arw_payload_len = toAxi3_io_output_arw_payload_len;
  assign io_output_arw_payload_size = toAxi3_io_output_arw_payload_size;
  assign io_output_arw_payload_burst = toAxi3_io_output_arw_payload_burst;
  assign io_output_arw_payload_lock = toAxi3_io_output_arw_payload_lock;
  assign io_output_arw_payload_cache = toAxi3_io_output_arw_payload_cache;
  assign io_output_arw_payload_qos = toAxi3_io_output_arw_payload_qos;
  assign io_output_arw_payload_prot = toAxi3_io_output_arw_payload_prot;
  assign io_output_arw_payload_write = toAxi3_io_output_arw_payload_write;
  assign io_output_w_valid = toAxi3_io_output_w_valid;
  assign io_output_w_payload_data = toAxi3_io_output_w_payload_data;
  assign io_output_w_payload_strb = toAxi3_io_output_w_payload_strb;
  assign io_output_w_payload_last = toAxi3_io_output_w_payload_last;
  assign io_output_b_ready = toAxi3_io_output_b_ready;
  assign io_output_r_ready = toAxi3_io_output_r_ready;
  assign io_output_arw_id = toAxi3_io_output_aw_id;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      arbiter_readOnly_io_output_ar_halfPipe_regs_valid <= 1'b0;
      arbiter_readOnly_io_output_ar_halfPipe_regs_ready <= 1'b1;
      arbiter_axi4_r_m2sPipe_rValid <= 1'b0;
      arbiter_axi4_r_m2sPipe_s2mPipe_rValid <= 1'b0;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_valid <= 1'b0;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_ready <= 1'b1;
      arbiter_writeOnly_io_output_w_m2sPipe_rValid <= 1'b0;
      arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rValid <= 1'b0;
      arbiter_axi4_b_halfPipe_regs_valid <= 1'b0;
      arbiter_axi4_b_halfPipe_regs_ready <= 1'b1;
    end else begin
      if(_zz_2)begin
        arbiter_readOnly_io_output_ar_halfPipe_regs_valid <= arbiter_readOnly_io_output_ar_valid;
        arbiter_readOnly_io_output_ar_halfPipe_regs_ready <= (! arbiter_readOnly_io_output_ar_valid);
      end else begin
        arbiter_readOnly_io_output_ar_halfPipe_regs_valid <= (! arbiter_readOnly_io_output_ar_halfPipe_ready);
        arbiter_readOnly_io_output_ar_halfPipe_regs_ready <= arbiter_readOnly_io_output_ar_halfPipe_ready;
      end
      if(arbiter_axi4_r_ready)begin
        arbiter_axi4_r_m2sPipe_rValid <= arbiter_axi4_r_valid;
      end
      if(arbiter_axi4_r_m2sPipe_s2mPipe_ready)begin
        arbiter_axi4_r_m2sPipe_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_3)begin
        arbiter_axi4_r_m2sPipe_s2mPipe_rValid <= arbiter_axi4_r_m2sPipe_valid;
      end
      if(_zz_4)begin
        arbiter_writeOnly_io_output_aw_halfPipe_regs_valid <= arbiter_writeOnly_io_output_aw_valid;
        arbiter_writeOnly_io_output_aw_halfPipe_regs_ready <= (! arbiter_writeOnly_io_output_aw_valid);
      end else begin
        arbiter_writeOnly_io_output_aw_halfPipe_regs_valid <= (! arbiter_writeOnly_io_output_aw_halfPipe_ready);
        arbiter_writeOnly_io_output_aw_halfPipe_regs_ready <= arbiter_writeOnly_io_output_aw_halfPipe_ready;
      end
      if(_zz_1)begin
        arbiter_writeOnly_io_output_w_m2sPipe_rValid <= arbiter_writeOnly_io_output_w_valid;
      end
      if(arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_ready)begin
        arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_5)begin
        arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rValid <= arbiter_writeOnly_io_output_w_m2sPipe_valid;
      end
      if(_zz_6)begin
        arbiter_axi4_b_halfPipe_regs_valid <= arbiter_axi4_b_valid;
        arbiter_axi4_b_halfPipe_regs_ready <= (! arbiter_axi4_b_valid);
      end else begin
        arbiter_axi4_b_halfPipe_regs_valid <= (! arbiter_axi4_b_halfPipe_ready);
        arbiter_axi4_b_halfPipe_regs_ready <= arbiter_axi4_b_halfPipe_ready;
      end
    end
  end

  always @ (posedge clk) begin
    if(_zz_2)begin
      arbiter_readOnly_io_output_ar_halfPipe_regs_payload_addr <= arbiter_readOnly_io_output_ar_payload_addr;
      arbiter_readOnly_io_output_ar_halfPipe_regs_payload_id <= arbiter_readOnly_io_output_ar_payload_id;
      arbiter_readOnly_io_output_ar_halfPipe_regs_payload_region <= arbiter_readOnly_io_output_ar_payload_region;
      arbiter_readOnly_io_output_ar_halfPipe_regs_payload_len <= arbiter_readOnly_io_output_ar_payload_len;
      arbiter_readOnly_io_output_ar_halfPipe_regs_payload_size <= arbiter_readOnly_io_output_ar_payload_size;
      arbiter_readOnly_io_output_ar_halfPipe_regs_payload_burst <= arbiter_readOnly_io_output_ar_payload_burst;
      arbiter_readOnly_io_output_ar_halfPipe_regs_payload_lock <= arbiter_readOnly_io_output_ar_payload_lock;
      arbiter_readOnly_io_output_ar_halfPipe_regs_payload_cache <= arbiter_readOnly_io_output_ar_payload_cache;
      arbiter_readOnly_io_output_ar_halfPipe_regs_payload_qos <= arbiter_readOnly_io_output_ar_payload_qos;
      arbiter_readOnly_io_output_ar_halfPipe_regs_payload_prot <= arbiter_readOnly_io_output_ar_payload_prot;
    end
    if(arbiter_axi4_r_ready)begin
      arbiter_axi4_r_m2sPipe_rData_data <= arbiter_axi4_r_payload_data;
      arbiter_axi4_r_m2sPipe_rData_id <= arbiter_axi4_r_payload_id;
      arbiter_axi4_r_m2sPipe_rData_resp <= arbiter_axi4_r_payload_resp;
      arbiter_axi4_r_m2sPipe_rData_last <= arbiter_axi4_r_payload_last;
    end
    if(_zz_3)begin
      arbiter_axi4_r_m2sPipe_s2mPipe_rData_data <= arbiter_axi4_r_m2sPipe_payload_data;
      arbiter_axi4_r_m2sPipe_s2mPipe_rData_id <= arbiter_axi4_r_m2sPipe_payload_id;
      arbiter_axi4_r_m2sPipe_s2mPipe_rData_resp <= arbiter_axi4_r_m2sPipe_payload_resp;
      arbiter_axi4_r_m2sPipe_s2mPipe_rData_last <= arbiter_axi4_r_m2sPipe_payload_last;
    end
    if(_zz_4)begin
      arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_addr <= arbiter_writeOnly_io_output_aw_payload_addr;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_id <= arbiter_writeOnly_io_output_aw_payload_id;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_region <= arbiter_writeOnly_io_output_aw_payload_region;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_len <= arbiter_writeOnly_io_output_aw_payload_len;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_size <= arbiter_writeOnly_io_output_aw_payload_size;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_burst <= arbiter_writeOnly_io_output_aw_payload_burst;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_lock <= arbiter_writeOnly_io_output_aw_payload_lock;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_cache <= arbiter_writeOnly_io_output_aw_payload_cache;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_qos <= arbiter_writeOnly_io_output_aw_payload_qos;
      arbiter_writeOnly_io_output_aw_halfPipe_regs_payload_prot <= arbiter_writeOnly_io_output_aw_payload_prot;
    end
    if(_zz_1)begin
      arbiter_writeOnly_io_output_w_m2sPipe_rData_data <= arbiter_writeOnly_io_output_w_payload_data;
      arbiter_writeOnly_io_output_w_m2sPipe_rData_strb <= arbiter_writeOnly_io_output_w_payload_strb;
      arbiter_writeOnly_io_output_w_m2sPipe_rData_last <= arbiter_writeOnly_io_output_w_payload_last;
    end
    if(_zz_5)begin
      arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rData_data <= arbiter_writeOnly_io_output_w_m2sPipe_payload_data;
      arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rData_strb <= arbiter_writeOnly_io_output_w_m2sPipe_payload_strb;
      arbiter_writeOnly_io_output_w_m2sPipe_s2mPipe_rData_last <= arbiter_writeOnly_io_output_w_m2sPipe_payload_last;
    end
    if(_zz_6)begin
      arbiter_axi4_b_halfPipe_regs_payload_id <= arbiter_axi4_b_payload_id;
      arbiter_axi4_b_halfPipe_regs_payload_resp <= arbiter_axi4_b_payload_resp;
    end
  end


endmodule

module Axi4SharedToAxi3Shared (
  input               io_input_arw_valid,
  output              io_input_arw_ready,
  input      [31:0]   io_input_arw_payload_addr,
  input      [4:0]    io_input_arw_payload_id,
  input      [3:0]    io_input_arw_payload_region,
  input      [7:0]    io_input_arw_payload_len,
  input      [2:0]    io_input_arw_payload_size,
  input      [1:0]    io_input_arw_payload_burst,
  input      [0:0]    io_input_arw_payload_lock,
  input      [3:0]    io_input_arw_payload_cache,
  input      [3:0]    io_input_arw_payload_qos,
  input      [2:0]    io_input_arw_payload_prot,
  input               io_input_arw_payload_write,
  input               io_input_w_valid,
  output              io_input_w_ready,
  input      [255:0]  io_input_w_payload_data,
  input      [31:0]   io_input_w_payload_strb,
  input               io_input_w_payload_last,
  output              io_input_b_valid,
  input               io_input_b_ready,
  output     [4:0]    io_input_b_payload_id,
  output     [1:0]    io_input_b_payload_resp,
  output              io_input_r_valid,
  input               io_input_r_ready,
  output     [255:0]  io_input_r_payload_data,
  output     [4:0]    io_input_r_payload_id,
  output     [1:0]    io_input_r_payload_resp,
  output              io_input_r_payload_last,
  output              io_output_arw_valid,
  input               io_output_arw_ready,
  output     [31:0]   io_output_arw_payload_addr,
  output     [4:0]    io_output_arw_payload_id,
  output     [3:0]    io_output_arw_payload_region,
  output     [7:0]    io_output_arw_payload_len,
  output     [2:0]    io_output_arw_payload_size,
  output     [1:0]    io_output_arw_payload_burst,
  output     [0:0]    io_output_arw_payload_lock,
  output     [3:0]    io_output_arw_payload_cache,
  output     [3:0]    io_output_arw_payload_qos,
  output     [2:0]    io_output_arw_payload_prot,
  output              io_output_arw_payload_write,
  output              io_output_w_valid,
  input               io_output_w_ready,
  output     [255:0]  io_output_w_payload_data,
  output     [31:0]   io_output_w_payload_strb,
  output              io_output_w_payload_last,
  input               io_output_b_valid,
  output              io_output_b_ready,
  input      [4:0]    io_output_b_payload_id,
  input      [1:0]    io_output_b_payload_resp,
  input               io_output_r_valid,
  output              io_output_r_ready,
  input      [255:0]  io_output_r_payload_data,
  input      [4:0]    io_output_r_payload_id,
  input      [1:0]    io_output_r_payload_resp,
  input               io_output_r_payload_last,
  output     [4:0]    io_output_aw_id,
  input               clk,
  input               reset
);
  wire                _zz_2;
  wire                _zz_3;
  wire                io_input_arw_fork_io_input_ready;
  wire                io_input_arw_fork_io_outputs_0_valid;
  wire       [31:0]   io_input_arw_fork_io_outputs_0_payload_addr;
  wire       [4:0]    io_input_arw_fork_io_outputs_0_payload_id;
  wire       [3:0]    io_input_arw_fork_io_outputs_0_payload_region;
  wire       [7:0]    io_input_arw_fork_io_outputs_0_payload_len;
  wire       [2:0]    io_input_arw_fork_io_outputs_0_payload_size;
  wire       [1:0]    io_input_arw_fork_io_outputs_0_payload_burst;
  wire       [0:0]    io_input_arw_fork_io_outputs_0_payload_lock;
  wire       [3:0]    io_input_arw_fork_io_outputs_0_payload_cache;
  wire       [3:0]    io_input_arw_fork_io_outputs_0_payload_qos;
  wire       [2:0]    io_input_arw_fork_io_outputs_0_payload_prot;
  wire                io_input_arw_fork_io_outputs_0_payload_write;
  wire                io_input_arw_fork_io_outputs_1_valid;
  wire       [31:0]   io_input_arw_fork_io_outputs_1_payload_addr;
  wire       [4:0]    io_input_arw_fork_io_outputs_1_payload_id;
  wire       [3:0]    io_input_arw_fork_io_outputs_1_payload_region;
  wire       [7:0]    io_input_arw_fork_io_outputs_1_payload_len;
  wire       [2:0]    io_input_arw_fork_io_outputs_1_payload_size;
  wire       [1:0]    io_input_arw_fork_io_outputs_1_payload_burst;
  wire       [0:0]    io_input_arw_fork_io_outputs_1_payload_lock;
  wire       [3:0]    io_input_arw_fork_io_outputs_1_payload_cache;
  wire       [3:0]    io_input_arw_fork_io_outputs_1_payload_qos;
  wire       [2:0]    io_input_arw_fork_io_outputs_1_payload_prot;
  wire                io_input_arw_fork_io_outputs_1_payload_write;
  wire                io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_push_ready;
  wire                io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_pop_valid;
  wire       [4:0]    io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_pop_payload;
  wire       [2:0]    io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_occupancy;
  wire                _zz_4;
  wire                io_input_arw_fork_io_outputs_1_translated_valid;
  reg                 io_input_arw_fork_io_outputs_1_translated_ready;
  wire       [4:0]    io_input_arw_fork_io_outputs_1_translated_payload;
  reg                 io_input_arw_fork_io_outputs_1_translated_thrown_valid;
  wire                io_input_arw_fork_io_outputs_1_translated_thrown_ready;
  wire       [4:0]    io_input_arw_fork_io_outputs_1_translated_thrown_payload;
  wire                _zz_1;

  assign _zz_4 = (! io_input_arw_fork_io_outputs_1_payload_write);
  StreamFork_5 io_input_arw_fork (
    .io_input_valid                 (io_input_arw_valid                                  ), //i
    .io_input_ready                 (io_input_arw_fork_io_input_ready                    ), //o
    .io_input_payload_addr          (io_input_arw_payload_addr[31:0]                     ), //i
    .io_input_payload_id            (io_input_arw_payload_id[4:0]                        ), //i
    .io_input_payload_region        (io_input_arw_payload_region[3:0]                    ), //i
    .io_input_payload_len           (io_input_arw_payload_len[7:0]                       ), //i
    .io_input_payload_size          (io_input_arw_payload_size[2:0]                      ), //i
    .io_input_payload_burst         (io_input_arw_payload_burst[1:0]                     ), //i
    .io_input_payload_lock          (io_input_arw_payload_lock                           ), //i
    .io_input_payload_cache         (io_input_arw_payload_cache[3:0]                     ), //i
    .io_input_payload_qos           (io_input_arw_payload_qos[3:0]                       ), //i
    .io_input_payload_prot          (io_input_arw_payload_prot[2:0]                      ), //i
    .io_input_payload_write         (io_input_arw_payload_write                          ), //i
    .io_outputs_0_valid             (io_input_arw_fork_io_outputs_0_valid                ), //o
    .io_outputs_0_ready             (io_output_arw_ready                                 ), //i
    .io_outputs_0_payload_addr      (io_input_arw_fork_io_outputs_0_payload_addr[31:0]   ), //o
    .io_outputs_0_payload_id        (io_input_arw_fork_io_outputs_0_payload_id[4:0]      ), //o
    .io_outputs_0_payload_region    (io_input_arw_fork_io_outputs_0_payload_region[3:0]  ), //o
    .io_outputs_0_payload_len       (io_input_arw_fork_io_outputs_0_payload_len[7:0]     ), //o
    .io_outputs_0_payload_size      (io_input_arw_fork_io_outputs_0_payload_size[2:0]    ), //o
    .io_outputs_0_payload_burst     (io_input_arw_fork_io_outputs_0_payload_burst[1:0]   ), //o
    .io_outputs_0_payload_lock      (io_input_arw_fork_io_outputs_0_payload_lock         ), //o
    .io_outputs_0_payload_cache     (io_input_arw_fork_io_outputs_0_payload_cache[3:0]   ), //o
    .io_outputs_0_payload_qos       (io_input_arw_fork_io_outputs_0_payload_qos[3:0]     ), //o
    .io_outputs_0_payload_prot      (io_input_arw_fork_io_outputs_0_payload_prot[2:0]    ), //o
    .io_outputs_0_payload_write     (io_input_arw_fork_io_outputs_0_payload_write        ), //o
    .io_outputs_1_valid             (io_input_arw_fork_io_outputs_1_valid                ), //o
    .io_outputs_1_ready             (io_input_arw_fork_io_outputs_1_translated_ready     ), //i
    .io_outputs_1_payload_addr      (io_input_arw_fork_io_outputs_1_payload_addr[31:0]   ), //o
    .io_outputs_1_payload_id        (io_input_arw_fork_io_outputs_1_payload_id[4:0]      ), //o
    .io_outputs_1_payload_region    (io_input_arw_fork_io_outputs_1_payload_region[3:0]  ), //o
    .io_outputs_1_payload_len       (io_input_arw_fork_io_outputs_1_payload_len[7:0]     ), //o
    .io_outputs_1_payload_size      (io_input_arw_fork_io_outputs_1_payload_size[2:0]    ), //o
    .io_outputs_1_payload_burst     (io_input_arw_fork_io_outputs_1_payload_burst[1:0]   ), //o
    .io_outputs_1_payload_lock      (io_input_arw_fork_io_outputs_1_payload_lock         ), //o
    .io_outputs_1_payload_cache     (io_input_arw_fork_io_outputs_1_payload_cache[3:0]   ), //o
    .io_outputs_1_payload_qos       (io_input_arw_fork_io_outputs_1_payload_qos[3:0]     ), //o
    .io_outputs_1_payload_prot      (io_input_arw_fork_io_outputs_1_payload_prot[2:0]    ), //o
    .io_outputs_1_payload_write     (io_input_arw_fork_io_outputs_1_payload_write        ), //o
    .clk                            (clk                                                 ), //i
    .reset                          (reset                                               )  //i
  );
  StreamFifoLowLatency_1 io_input_arw_fork_io_outputs_1_translated_thrown_fifo (
    .io_push_valid      (io_input_arw_fork_io_outputs_1_translated_thrown_valid                     ), //i
    .io_push_ready      (io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_push_ready        ), //o
    .io_push_payload    (io_input_arw_fork_io_outputs_1_translated_thrown_payload[4:0]              ), //i
    .io_pop_valid       (io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_pop_valid         ), //o
    .io_pop_ready       (_zz_2                                                                      ), //i
    .io_pop_payload     (io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_pop_payload[4:0]  ), //o
    .io_flush           (_zz_3                                                                      ), //i
    .io_occupancy       (io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_occupancy[2:0]    ), //o
    .clk                (clk                                                                        ), //i
    .reset              (reset                                                                      )  //i
  );
  assign io_input_arw_ready = io_input_arw_fork_io_input_ready;
  assign io_output_arw_valid = io_input_arw_fork_io_outputs_0_valid;
  assign io_output_arw_payload_addr = io_input_arw_fork_io_outputs_0_payload_addr;
  assign io_output_arw_payload_id = io_input_arw_fork_io_outputs_0_payload_id;
  assign io_output_arw_payload_region = io_input_arw_fork_io_outputs_0_payload_region;
  assign io_output_arw_payload_len = io_input_arw_fork_io_outputs_0_payload_len;
  assign io_output_arw_payload_size = io_input_arw_fork_io_outputs_0_payload_size;
  assign io_output_arw_payload_burst = io_input_arw_fork_io_outputs_0_payload_burst;
  assign io_output_arw_payload_lock = io_input_arw_fork_io_outputs_0_payload_lock;
  assign io_output_arw_payload_cache = io_input_arw_fork_io_outputs_0_payload_cache;
  assign io_output_arw_payload_qos = io_input_arw_fork_io_outputs_0_payload_qos;
  assign io_output_arw_payload_prot = io_input_arw_fork_io_outputs_0_payload_prot;
  assign io_output_arw_payload_write = io_input_arw_fork_io_outputs_0_payload_write;
  assign io_input_arw_fork_io_outputs_1_translated_valid = io_input_arw_fork_io_outputs_1_valid;
  assign io_input_arw_fork_io_outputs_1_translated_payload = io_input_arw_fork_io_outputs_1_payload_id;
  always @ (*) begin
    io_input_arw_fork_io_outputs_1_translated_thrown_valid = io_input_arw_fork_io_outputs_1_translated_valid;
    if(_zz_4)begin
      io_input_arw_fork_io_outputs_1_translated_thrown_valid = 1'b0;
    end
  end

  always @ (*) begin
    io_input_arw_fork_io_outputs_1_translated_ready = io_input_arw_fork_io_outputs_1_translated_thrown_ready;
    if(_zz_4)begin
      io_input_arw_fork_io_outputs_1_translated_ready = 1'b1;
    end
  end

  assign io_input_arw_fork_io_outputs_1_translated_thrown_payload = io_input_arw_fork_io_outputs_1_translated_payload;
  assign io_input_arw_fork_io_outputs_1_translated_thrown_ready = io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_push_ready;
  assign _zz_2 = ((io_output_w_valid && io_output_w_ready) && io_output_w_payload_last);
  assign _zz_1 = (! (! io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_pop_valid));
  assign io_input_w_ready = (io_output_w_ready && _zz_1);
  assign io_output_w_valid = (io_input_w_valid && _zz_1);
  assign io_output_w_payload_data = io_input_w_payload_data;
  assign io_output_w_payload_strb = io_input_w_payload_strb;
  assign io_output_w_payload_last = io_input_w_payload_last;
  assign io_output_aw_id = io_input_arw_fork_io_outputs_1_translated_thrown_fifo_io_pop_payload;
  assign io_input_r_valid = io_output_r_valid;
  assign io_output_r_ready = io_input_r_ready;
  assign io_input_r_payload_data = io_output_r_payload_data;
  assign io_input_r_payload_id = io_output_r_payload_id;
  assign io_input_r_payload_resp = io_output_r_payload_resp;
  assign io_input_r_payload_last = io_output_r_payload_last;
  assign io_input_b_valid = io_output_b_valid;
  assign io_output_b_ready = io_input_b_ready;
  assign io_input_b_payload_id = io_output_b_payload_id;
  assign io_input_b_payload_resp = io_output_b_payload_resp;
  assign _zz_3 = 1'b0;

endmodule

module StreamArbiter_2 (
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input      [31:0]   io_inputs_0_payload_addr,
  input      [4:0]    io_inputs_0_payload_id,
  input      [3:0]    io_inputs_0_payload_region,
  input      [7:0]    io_inputs_0_payload_len,
  input      [2:0]    io_inputs_0_payload_size,
  input      [1:0]    io_inputs_0_payload_burst,
  input      [0:0]    io_inputs_0_payload_lock,
  input      [3:0]    io_inputs_0_payload_cache,
  input      [3:0]    io_inputs_0_payload_qos,
  input      [2:0]    io_inputs_0_payload_prot,
  input               io_inputs_1_valid,
  output              io_inputs_1_ready,
  input      [31:0]   io_inputs_1_payload_addr,
  input      [4:0]    io_inputs_1_payload_id,
  input      [3:0]    io_inputs_1_payload_region,
  input      [7:0]    io_inputs_1_payload_len,
  input      [2:0]    io_inputs_1_payload_size,
  input      [1:0]    io_inputs_1_payload_burst,
  input      [0:0]    io_inputs_1_payload_lock,
  input      [3:0]    io_inputs_1_payload_cache,
  input      [3:0]    io_inputs_1_payload_qos,
  input      [2:0]    io_inputs_1_payload_prot,
  output              io_output_valid,
  input               io_output_ready,
  output     [31:0]   io_output_payload_addr,
  output     [4:0]    io_output_payload_id,
  output     [3:0]    io_output_payload_region,
  output     [7:0]    io_output_payload_len,
  output     [2:0]    io_output_payload_size,
  output     [1:0]    io_output_payload_burst,
  output     [0:0]    io_output_payload_lock,
  output     [3:0]    io_output_payload_cache,
  output     [3:0]    io_output_payload_qos,
  output     [2:0]    io_output_payload_prot,
  output     [0:0]    io_chosen,
  output     [1:0]    io_chosenOH,
  input               clk,
  input               reset
);
  wire       [3:0]    _zz_6;
  wire       [1:0]    _zz_7;
  wire       [3:0]    _zz_8;
  wire       [0:0]    _zz_9;
  wire       [0:0]    _zz_10;
  reg                 locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire       [1:0]    _zz_1;
  wire       [3:0]    _zz_2;
  wire       [3:0]    _zz_3;
  wire       [1:0]    _zz_4;
  wire                _zz_5;

  assign _zz_6 = (_zz_2 - _zz_8);
  assign _zz_7 = {maskLocked_0,maskLocked_1};
  assign _zz_8 = {2'd0, _zz_7};
  assign _zz_9 = _zz_4[0 : 0];
  assign _zz_10 = _zz_4[1 : 1];
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
  assign _zz_1 = {io_inputs_1_valid,io_inputs_0_valid};
  assign _zz_2 = {_zz_1,_zz_1};
  assign _zz_3 = (_zz_2 & (~ _zz_6));
  assign _zz_4 = (_zz_3[3 : 2] | _zz_3[1 : 0]);
  assign maskProposal_0 = _zz_9[0];
  assign maskProposal_1 = _zz_10[0];
  assign io_output_valid = ((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1));
  assign io_output_payload_addr = (maskRouted_0 ? io_inputs_0_payload_addr : io_inputs_1_payload_addr);
  assign io_output_payload_id = (maskRouted_0 ? io_inputs_0_payload_id : io_inputs_1_payload_id);
  assign io_output_payload_region = (maskRouted_0 ? io_inputs_0_payload_region : io_inputs_1_payload_region);
  assign io_output_payload_len = (maskRouted_0 ? io_inputs_0_payload_len : io_inputs_1_payload_len);
  assign io_output_payload_size = (maskRouted_0 ? io_inputs_0_payload_size : io_inputs_1_payload_size);
  assign io_output_payload_burst = (maskRouted_0 ? io_inputs_0_payload_burst : io_inputs_1_payload_burst);
  assign io_output_payload_lock = (maskRouted_0 ? io_inputs_0_payload_lock : io_inputs_1_payload_lock);
  assign io_output_payload_cache = (maskRouted_0 ? io_inputs_0_payload_cache : io_inputs_1_payload_cache);
  assign io_output_payload_qos = (maskRouted_0 ? io_inputs_0_payload_qos : io_inputs_1_payload_qos);
  assign io_output_payload_prot = (maskRouted_0 ? io_inputs_0_payload_prot : io_inputs_1_payload_prot);
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready);
  assign io_chosenOH = {maskRouted_1,maskRouted_0};
  assign _zz_5 = io_chosenOH[1];
  assign io_chosen = _zz_5;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      locked <= 1'b0;
      maskLocked_0 <= 1'b0;
      maskLocked_1 <= 1'b1;
    end else begin
      if(io_output_valid)begin
        maskLocked_0 <= maskRouted_0;
        maskLocked_1 <= maskRouted_1;
      end
      if(io_output_valid)begin
        locked <= 1'b1;
      end
      if((io_output_valid && io_output_ready))begin
        locked <= 1'b0;
      end
    end
  end


endmodule

module Axi4WriteOnlyArbiter (
  input               io_inputs_0_aw_valid,
  output              io_inputs_0_aw_ready,
  input      [31:0]   io_inputs_0_aw_payload_addr,
  input      [3:0]    io_inputs_0_aw_payload_id,
  input      [3:0]    io_inputs_0_aw_payload_region,
  input      [7:0]    io_inputs_0_aw_payload_len,
  input      [2:0]    io_inputs_0_aw_payload_size,
  input      [1:0]    io_inputs_0_aw_payload_burst,
  input      [0:0]    io_inputs_0_aw_payload_lock,
  input      [3:0]    io_inputs_0_aw_payload_cache,
  input      [3:0]    io_inputs_0_aw_payload_qos,
  input      [2:0]    io_inputs_0_aw_payload_prot,
  input               io_inputs_0_w_valid,
  output              io_inputs_0_w_ready,
  input      [255:0]  io_inputs_0_w_payload_data,
  input      [31:0]   io_inputs_0_w_payload_strb,
  input               io_inputs_0_w_payload_last,
  output              io_inputs_0_b_valid,
  input               io_inputs_0_b_ready,
  output     [3:0]    io_inputs_0_b_payload_id,
  output     [1:0]    io_inputs_0_b_payload_resp,
  input               io_inputs_1_aw_valid,
  output              io_inputs_1_aw_ready,
  input      [31:0]   io_inputs_1_aw_payload_addr,
  input      [3:0]    io_inputs_1_aw_payload_id,
  input      [3:0]    io_inputs_1_aw_payload_region,
  input      [7:0]    io_inputs_1_aw_payload_len,
  input      [2:0]    io_inputs_1_aw_payload_size,
  input      [1:0]    io_inputs_1_aw_payload_burst,
  input      [0:0]    io_inputs_1_aw_payload_lock,
  input      [3:0]    io_inputs_1_aw_payload_cache,
  input      [3:0]    io_inputs_1_aw_payload_qos,
  input      [2:0]    io_inputs_1_aw_payload_prot,
  input               io_inputs_1_w_valid,
  output              io_inputs_1_w_ready,
  input      [255:0]  io_inputs_1_w_payload_data,
  input      [31:0]   io_inputs_1_w_payload_strb,
  input               io_inputs_1_w_payload_last,
  output              io_inputs_1_b_valid,
  input               io_inputs_1_b_ready,
  output     [3:0]    io_inputs_1_b_payload_id,
  output     [1:0]    io_inputs_1_b_payload_resp,
  output              io_output_aw_valid,
  input               io_output_aw_ready,
  output     [31:0]   io_output_aw_payload_addr,
  output     [4:0]    io_output_aw_payload_id,
  output     [3:0]    io_output_aw_payload_region,
  output     [7:0]    io_output_aw_payload_len,
  output     [2:0]    io_output_aw_payload_size,
  output     [1:0]    io_output_aw_payload_burst,
  output     [0:0]    io_output_aw_payload_lock,
  output     [3:0]    io_output_aw_payload_cache,
  output     [3:0]    io_output_aw_payload_qos,
  output     [2:0]    io_output_aw_payload_prot,
  output              io_output_w_valid,
  input               io_output_w_ready,
  output     [255:0]  io_output_w_payload_data,
  output     [31:0]   io_output_w_payload_strb,
  output              io_output_w_payload_last,
  input               io_output_b_valid,
  output              io_output_b_ready,
  input      [4:0]    io_output_b_payload_id,
  input      [1:0]    io_output_b_payload_resp,
  input               clk,
  input               reset
);
  wire                _zz_1;
  wire                _zz_2;
  reg                 _zz_3;
  reg        [255:0]  _zz_4;
  reg        [31:0]   _zz_5;
  reg                 _zz_6;
  reg                 _zz_7;
  wire                cmdArbiter_io_inputs_0_ready;
  wire                cmdArbiter_io_inputs_1_ready;
  wire                cmdArbiter_io_output_valid;
  wire       [31:0]   cmdArbiter_io_output_payload_addr;
  wire       [3:0]    cmdArbiter_io_output_payload_id;
  wire       [3:0]    cmdArbiter_io_output_payload_region;
  wire       [7:0]    cmdArbiter_io_output_payload_len;
  wire       [2:0]    cmdArbiter_io_output_payload_size;
  wire       [1:0]    cmdArbiter_io_output_payload_burst;
  wire       [0:0]    cmdArbiter_io_output_payload_lock;
  wire       [3:0]    cmdArbiter_io_output_payload_cache;
  wire       [3:0]    cmdArbiter_io_output_payload_qos;
  wire       [2:0]    cmdArbiter_io_output_payload_prot;
  wire       [0:0]    cmdArbiter_io_chosen;
  wire       [1:0]    cmdArbiter_io_chosenOH;
  wire                cmdArbiter_io_output_fork_io_input_ready;
  wire                cmdArbiter_io_output_fork_io_outputs_0_valid;
  wire       [31:0]   cmdArbiter_io_output_fork_io_outputs_0_payload_addr;
  wire       [3:0]    cmdArbiter_io_output_fork_io_outputs_0_payload_id;
  wire       [3:0]    cmdArbiter_io_output_fork_io_outputs_0_payload_region;
  wire       [7:0]    cmdArbiter_io_output_fork_io_outputs_0_payload_len;
  wire       [2:0]    cmdArbiter_io_output_fork_io_outputs_0_payload_size;
  wire       [1:0]    cmdArbiter_io_output_fork_io_outputs_0_payload_burst;
  wire       [0:0]    cmdArbiter_io_output_fork_io_outputs_0_payload_lock;
  wire       [3:0]    cmdArbiter_io_output_fork_io_outputs_0_payload_cache;
  wire       [3:0]    cmdArbiter_io_output_fork_io_outputs_0_payload_qos;
  wire       [2:0]    cmdArbiter_io_output_fork_io_outputs_0_payload_prot;
  wire                cmdArbiter_io_output_fork_io_outputs_1_valid;
  wire       [31:0]   cmdArbiter_io_output_fork_io_outputs_1_payload_addr;
  wire       [3:0]    cmdArbiter_io_output_fork_io_outputs_1_payload_id;
  wire       [3:0]    cmdArbiter_io_output_fork_io_outputs_1_payload_region;
  wire       [7:0]    cmdArbiter_io_output_fork_io_outputs_1_payload_len;
  wire       [2:0]    cmdArbiter_io_output_fork_io_outputs_1_payload_size;
  wire       [1:0]    cmdArbiter_io_output_fork_io_outputs_1_payload_burst;
  wire       [0:0]    cmdArbiter_io_output_fork_io_outputs_1_payload_lock;
  wire       [3:0]    cmdArbiter_io_output_fork_io_outputs_1_payload_cache;
  wire       [3:0]    cmdArbiter_io_output_fork_io_outputs_1_payload_qos;
  wire       [2:0]    cmdArbiter_io_output_fork_io_outputs_1_payload_prot;
  wire                cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_push_ready;
  wire                cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_pop_valid;
  wire       [0:0]    cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_pop_payload;
  wire       [2:0]    cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_occupancy;
  wire                cmdArbiter_io_output_fork_io_outputs_1_translated_valid;
  wire                cmdArbiter_io_output_fork_io_outputs_1_translated_ready;
  wire       [0:0]    cmdArbiter_io_output_fork_io_outputs_1_translated_payload;
  wire       [0:0]    writeRspIndex;
  wire                writeRspSels_0;
  wire                writeRspSels_1;

  StreamArbiter cmdArbiter (
    .io_inputs_0_valid             (io_inputs_0_aw_valid                      ), //i
    .io_inputs_0_ready             (cmdArbiter_io_inputs_0_ready              ), //o
    .io_inputs_0_payload_addr      (io_inputs_0_aw_payload_addr[31:0]         ), //i
    .io_inputs_0_payload_id        (io_inputs_0_aw_payload_id[3:0]            ), //i
    .io_inputs_0_payload_region    (io_inputs_0_aw_payload_region[3:0]        ), //i
    .io_inputs_0_payload_len       (io_inputs_0_aw_payload_len[7:0]           ), //i
    .io_inputs_0_payload_size      (io_inputs_0_aw_payload_size[2:0]          ), //i
    .io_inputs_0_payload_burst     (io_inputs_0_aw_payload_burst[1:0]         ), //i
    .io_inputs_0_payload_lock      (io_inputs_0_aw_payload_lock               ), //i
    .io_inputs_0_payload_cache     (io_inputs_0_aw_payload_cache[3:0]         ), //i
    .io_inputs_0_payload_qos       (io_inputs_0_aw_payload_qos[3:0]           ), //i
    .io_inputs_0_payload_prot      (io_inputs_0_aw_payload_prot[2:0]          ), //i
    .io_inputs_1_valid             (io_inputs_1_aw_valid                      ), //i
    .io_inputs_1_ready             (cmdArbiter_io_inputs_1_ready              ), //o
    .io_inputs_1_payload_addr      (io_inputs_1_aw_payload_addr[31:0]         ), //i
    .io_inputs_1_payload_id        (io_inputs_1_aw_payload_id[3:0]            ), //i
    .io_inputs_1_payload_region    (io_inputs_1_aw_payload_region[3:0]        ), //i
    .io_inputs_1_payload_len       (io_inputs_1_aw_payload_len[7:0]           ), //i
    .io_inputs_1_payload_size      (io_inputs_1_aw_payload_size[2:0]          ), //i
    .io_inputs_1_payload_burst     (io_inputs_1_aw_payload_burst[1:0]         ), //i
    .io_inputs_1_payload_lock      (io_inputs_1_aw_payload_lock               ), //i
    .io_inputs_1_payload_cache     (io_inputs_1_aw_payload_cache[3:0]         ), //i
    .io_inputs_1_payload_qos       (io_inputs_1_aw_payload_qos[3:0]           ), //i
    .io_inputs_1_payload_prot      (io_inputs_1_aw_payload_prot[2:0]          ), //i
    .io_output_valid               (cmdArbiter_io_output_valid                ), //o
    .io_output_ready               (cmdArbiter_io_output_fork_io_input_ready  ), //i
    .io_output_payload_addr        (cmdArbiter_io_output_payload_addr[31:0]   ), //o
    .io_output_payload_id          (cmdArbiter_io_output_payload_id[3:0]      ), //o
    .io_output_payload_region      (cmdArbiter_io_output_payload_region[3:0]  ), //o
    .io_output_payload_len         (cmdArbiter_io_output_payload_len[7:0]     ), //o
    .io_output_payload_size        (cmdArbiter_io_output_payload_size[2:0]    ), //o
    .io_output_payload_burst       (cmdArbiter_io_output_payload_burst[1:0]   ), //o
    .io_output_payload_lock        (cmdArbiter_io_output_payload_lock         ), //o
    .io_output_payload_cache       (cmdArbiter_io_output_payload_cache[3:0]   ), //o
    .io_output_payload_qos         (cmdArbiter_io_output_payload_qos[3:0]     ), //o
    .io_output_payload_prot        (cmdArbiter_io_output_payload_prot[2:0]    ), //o
    .io_chosen                     (cmdArbiter_io_chosen                      ), //o
    .io_chosenOH                   (cmdArbiter_io_chosenOH[1:0]               ), //o
    .clk                           (clk                                       ), //i
    .reset                         (reset                                     )  //i
  );
  StreamFork cmdArbiter_io_output_fork (
    .io_input_valid                 (cmdArbiter_io_output_valid                                  ), //i
    .io_input_ready                 (cmdArbiter_io_output_fork_io_input_ready                    ), //o
    .io_input_payload_addr          (cmdArbiter_io_output_payload_addr[31:0]                     ), //i
    .io_input_payload_id            (cmdArbiter_io_output_payload_id[3:0]                        ), //i
    .io_input_payload_region        (cmdArbiter_io_output_payload_region[3:0]                    ), //i
    .io_input_payload_len           (cmdArbiter_io_output_payload_len[7:0]                       ), //i
    .io_input_payload_size          (cmdArbiter_io_output_payload_size[2:0]                      ), //i
    .io_input_payload_burst         (cmdArbiter_io_output_payload_burst[1:0]                     ), //i
    .io_input_payload_lock          (cmdArbiter_io_output_payload_lock                           ), //i
    .io_input_payload_cache         (cmdArbiter_io_output_payload_cache[3:0]                     ), //i
    .io_input_payload_qos           (cmdArbiter_io_output_payload_qos[3:0]                       ), //i
    .io_input_payload_prot          (cmdArbiter_io_output_payload_prot[2:0]                      ), //i
    .io_outputs_0_valid             (cmdArbiter_io_output_fork_io_outputs_0_valid                ), //o
    .io_outputs_0_ready             (io_output_aw_ready                                          ), //i
    .io_outputs_0_payload_addr      (cmdArbiter_io_output_fork_io_outputs_0_payload_addr[31:0]   ), //o
    .io_outputs_0_payload_id        (cmdArbiter_io_output_fork_io_outputs_0_payload_id[3:0]      ), //o
    .io_outputs_0_payload_region    (cmdArbiter_io_output_fork_io_outputs_0_payload_region[3:0]  ), //o
    .io_outputs_0_payload_len       (cmdArbiter_io_output_fork_io_outputs_0_payload_len[7:0]     ), //o
    .io_outputs_0_payload_size      (cmdArbiter_io_output_fork_io_outputs_0_payload_size[2:0]    ), //o
    .io_outputs_0_payload_burst     (cmdArbiter_io_output_fork_io_outputs_0_payload_burst[1:0]   ), //o
    .io_outputs_0_payload_lock      (cmdArbiter_io_output_fork_io_outputs_0_payload_lock         ), //o
    .io_outputs_0_payload_cache     (cmdArbiter_io_output_fork_io_outputs_0_payload_cache[3:0]   ), //o
    .io_outputs_0_payload_qos       (cmdArbiter_io_output_fork_io_outputs_0_payload_qos[3:0]     ), //o
    .io_outputs_0_payload_prot      (cmdArbiter_io_output_fork_io_outputs_0_payload_prot[2:0]    ), //o
    .io_outputs_1_valid             (cmdArbiter_io_output_fork_io_outputs_1_valid                ), //o
    .io_outputs_1_ready             (cmdArbiter_io_output_fork_io_outputs_1_translated_ready     ), //i
    .io_outputs_1_payload_addr      (cmdArbiter_io_output_fork_io_outputs_1_payload_addr[31:0]   ), //o
    .io_outputs_1_payload_id        (cmdArbiter_io_output_fork_io_outputs_1_payload_id[3:0]      ), //o
    .io_outputs_1_payload_region    (cmdArbiter_io_output_fork_io_outputs_1_payload_region[3:0]  ), //o
    .io_outputs_1_payload_len       (cmdArbiter_io_output_fork_io_outputs_1_payload_len[7:0]     ), //o
    .io_outputs_1_payload_size      (cmdArbiter_io_output_fork_io_outputs_1_payload_size[2:0]    ), //o
    .io_outputs_1_payload_burst     (cmdArbiter_io_output_fork_io_outputs_1_payload_burst[1:0]   ), //o
    .io_outputs_1_payload_lock      (cmdArbiter_io_output_fork_io_outputs_1_payload_lock         ), //o
    .io_outputs_1_payload_cache     (cmdArbiter_io_output_fork_io_outputs_1_payload_cache[3:0]   ), //o
    .io_outputs_1_payload_qos       (cmdArbiter_io_output_fork_io_outputs_1_payload_qos[3:0]     ), //o
    .io_outputs_1_payload_prot      (cmdArbiter_io_output_fork_io_outputs_1_payload_prot[2:0]    ), //o
    .clk                            (clk                                                         ), //i
    .reset                          (reset                                                       )  //i
  );
  StreamFifoLowLatency cmdArbiter_io_output_fork_io_outputs_1_translated_fifo (
    .io_push_valid      (cmdArbiter_io_output_fork_io_outputs_1_translated_valid                   ), //i
    .io_push_ready      (cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_push_ready      ), //o
    .io_push_payload    (cmdArbiter_io_output_fork_io_outputs_1_translated_payload                 ), //i
    .io_pop_valid       (cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_pop_valid       ), //o
    .io_pop_ready       (_zz_1                                                                     ), //i
    .io_pop_payload     (cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_pop_payload     ), //o
    .io_flush           (_zz_2                                                                     ), //i
    .io_occupancy       (cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_occupancy[2:0]  ), //o
    .clk                (clk                                                                       ), //i
    .reset              (reset                                                                     )  //i
  );
  always @(*) begin
    case(cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_pop_payload)
      1'b0 : begin
        _zz_3 = io_inputs_0_w_valid;
        _zz_4 = io_inputs_0_w_payload_data;
        _zz_5 = io_inputs_0_w_payload_strb;
        _zz_6 = io_inputs_0_w_payload_last;
      end
      default : begin
        _zz_3 = io_inputs_1_w_valid;
        _zz_4 = io_inputs_1_w_payload_data;
        _zz_5 = io_inputs_1_w_payload_strb;
        _zz_6 = io_inputs_1_w_payload_last;
      end
    endcase
  end

  always @(*) begin
    case(writeRspIndex)
      1'b0 : begin
        _zz_7 = io_inputs_0_b_ready;
      end
      default : begin
        _zz_7 = io_inputs_1_b_ready;
      end
    endcase
  end

  assign io_inputs_0_aw_ready = cmdArbiter_io_inputs_0_ready;
  assign io_inputs_1_aw_ready = cmdArbiter_io_inputs_1_ready;
  assign io_output_aw_valid = cmdArbiter_io_output_fork_io_outputs_0_valid;
  assign io_output_aw_payload_addr = cmdArbiter_io_output_fork_io_outputs_0_payload_addr;
  assign io_output_aw_payload_region = cmdArbiter_io_output_fork_io_outputs_0_payload_region;
  assign io_output_aw_payload_len = cmdArbiter_io_output_fork_io_outputs_0_payload_len;
  assign io_output_aw_payload_size = cmdArbiter_io_output_fork_io_outputs_0_payload_size;
  assign io_output_aw_payload_burst = cmdArbiter_io_output_fork_io_outputs_0_payload_burst;
  assign io_output_aw_payload_lock = cmdArbiter_io_output_fork_io_outputs_0_payload_lock;
  assign io_output_aw_payload_cache = cmdArbiter_io_output_fork_io_outputs_0_payload_cache;
  assign io_output_aw_payload_qos = cmdArbiter_io_output_fork_io_outputs_0_payload_qos;
  assign io_output_aw_payload_prot = cmdArbiter_io_output_fork_io_outputs_0_payload_prot;
  assign io_output_aw_payload_id = {cmdArbiter_io_chosen,cmdArbiter_io_output_payload_id};
  assign cmdArbiter_io_output_fork_io_outputs_1_translated_valid = cmdArbiter_io_output_fork_io_outputs_1_valid;
  assign cmdArbiter_io_output_fork_io_outputs_1_translated_payload = cmdArbiter_io_chosen;
  assign cmdArbiter_io_output_fork_io_outputs_1_translated_ready = cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_push_ready;
  assign io_output_w_valid = (cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_pop_valid && _zz_3);
  assign io_output_w_payload_data = _zz_4;
  assign io_output_w_payload_strb = _zz_5;
  assign io_output_w_payload_last = _zz_6;
  assign io_inputs_0_w_ready = ((cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_pop_valid && io_output_w_ready) && (cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_pop_payload == 1'b0));
  assign io_inputs_1_w_ready = ((cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_pop_valid && io_output_w_ready) && (cmdArbiter_io_output_fork_io_outputs_1_translated_fifo_io_pop_payload == 1'b1));
  assign _zz_1 = ((io_output_w_valid && io_output_w_ready) && io_output_w_payload_last);
  assign writeRspIndex = io_output_b_payload_id[4 : 4];
  assign writeRspSels_0 = (writeRspIndex == 1'b0);
  assign writeRspSels_1 = (writeRspIndex == 1'b1);
  assign io_inputs_0_b_valid = (io_output_b_valid && writeRspSels_0);
  assign io_inputs_0_b_payload_resp = io_output_b_payload_resp;
  assign io_inputs_0_b_payload_id = io_output_b_payload_id[3 : 0];
  assign io_inputs_1_b_valid = (io_output_b_valid && writeRspSels_1);
  assign io_inputs_1_b_payload_resp = io_output_b_payload_resp;
  assign io_inputs_1_b_payload_id = io_output_b_payload_id[3 : 0];
  assign io_output_b_ready = _zz_7;
  assign _zz_2 = 1'b0;

endmodule

module Axi4ReadOnlyArbiter (
  input               io_inputs_0_ar_valid,
  output              io_inputs_0_ar_ready,
  input      [31:0]   io_inputs_0_ar_payload_addr,
  input      [3:0]    io_inputs_0_ar_payload_id,
  input      [3:0]    io_inputs_0_ar_payload_region,
  input      [7:0]    io_inputs_0_ar_payload_len,
  input      [2:0]    io_inputs_0_ar_payload_size,
  input      [1:0]    io_inputs_0_ar_payload_burst,
  input      [0:0]    io_inputs_0_ar_payload_lock,
  input      [3:0]    io_inputs_0_ar_payload_cache,
  input      [3:0]    io_inputs_0_ar_payload_qos,
  input      [2:0]    io_inputs_0_ar_payload_prot,
  output              io_inputs_0_r_valid,
  input               io_inputs_0_r_ready,
  output     [255:0]  io_inputs_0_r_payload_data,
  output     [3:0]    io_inputs_0_r_payload_id,
  output     [1:0]    io_inputs_0_r_payload_resp,
  output              io_inputs_0_r_payload_last,
  input               io_inputs_1_ar_valid,
  output              io_inputs_1_ar_ready,
  input      [31:0]   io_inputs_1_ar_payload_addr,
  input      [3:0]    io_inputs_1_ar_payload_id,
  input      [3:0]    io_inputs_1_ar_payload_region,
  input      [7:0]    io_inputs_1_ar_payload_len,
  input      [2:0]    io_inputs_1_ar_payload_size,
  input      [1:0]    io_inputs_1_ar_payload_burst,
  input      [0:0]    io_inputs_1_ar_payload_lock,
  input      [3:0]    io_inputs_1_ar_payload_cache,
  input      [3:0]    io_inputs_1_ar_payload_qos,
  input      [2:0]    io_inputs_1_ar_payload_prot,
  output              io_inputs_1_r_valid,
  input               io_inputs_1_r_ready,
  output     [255:0]  io_inputs_1_r_payload_data,
  output     [3:0]    io_inputs_1_r_payload_id,
  output     [1:0]    io_inputs_1_r_payload_resp,
  output              io_inputs_1_r_payload_last,
  output              io_output_ar_valid,
  input               io_output_ar_ready,
  output     [31:0]   io_output_ar_payload_addr,
  output     [4:0]    io_output_ar_payload_id,
  output     [3:0]    io_output_ar_payload_region,
  output     [7:0]    io_output_ar_payload_len,
  output     [2:0]    io_output_ar_payload_size,
  output     [1:0]    io_output_ar_payload_burst,
  output     [0:0]    io_output_ar_payload_lock,
  output     [3:0]    io_output_ar_payload_cache,
  output     [3:0]    io_output_ar_payload_qos,
  output     [2:0]    io_output_ar_payload_prot,
  input               io_output_r_valid,
  output              io_output_r_ready,
  input      [255:0]  io_output_r_payload_data,
  input      [4:0]    io_output_r_payload_id,
  input      [1:0]    io_output_r_payload_resp,
  input               io_output_r_payload_last,
  input               clk,
  input               reset
);
  reg                 _zz_1;
  wire                cmdArbiter_io_inputs_0_ready;
  wire                cmdArbiter_io_inputs_1_ready;
  wire                cmdArbiter_io_output_valid;
  wire       [31:0]   cmdArbiter_io_output_payload_addr;
  wire       [3:0]    cmdArbiter_io_output_payload_id;
  wire       [3:0]    cmdArbiter_io_output_payload_region;
  wire       [7:0]    cmdArbiter_io_output_payload_len;
  wire       [2:0]    cmdArbiter_io_output_payload_size;
  wire       [1:0]    cmdArbiter_io_output_payload_burst;
  wire       [0:0]    cmdArbiter_io_output_payload_lock;
  wire       [3:0]    cmdArbiter_io_output_payload_cache;
  wire       [3:0]    cmdArbiter_io_output_payload_qos;
  wire       [2:0]    cmdArbiter_io_output_payload_prot;
  wire       [0:0]    cmdArbiter_io_chosen;
  wire       [1:0]    cmdArbiter_io_chosenOH;
  wire       [0:0]    readRspIndex;
  wire                readRspSels_0;
  wire                readRspSels_1;

  StreamArbiter cmdArbiter (
    .io_inputs_0_valid             (io_inputs_0_ar_valid                      ), //i
    .io_inputs_0_ready             (cmdArbiter_io_inputs_0_ready              ), //o
    .io_inputs_0_payload_addr      (io_inputs_0_ar_payload_addr[31:0]         ), //i
    .io_inputs_0_payload_id        (io_inputs_0_ar_payload_id[3:0]            ), //i
    .io_inputs_0_payload_region    (io_inputs_0_ar_payload_region[3:0]        ), //i
    .io_inputs_0_payload_len       (io_inputs_0_ar_payload_len[7:0]           ), //i
    .io_inputs_0_payload_size      (io_inputs_0_ar_payload_size[2:0]          ), //i
    .io_inputs_0_payload_burst     (io_inputs_0_ar_payload_burst[1:0]         ), //i
    .io_inputs_0_payload_lock      (io_inputs_0_ar_payload_lock               ), //i
    .io_inputs_0_payload_cache     (io_inputs_0_ar_payload_cache[3:0]         ), //i
    .io_inputs_0_payload_qos       (io_inputs_0_ar_payload_qos[3:0]           ), //i
    .io_inputs_0_payload_prot      (io_inputs_0_ar_payload_prot[2:0]          ), //i
    .io_inputs_1_valid             (io_inputs_1_ar_valid                      ), //i
    .io_inputs_1_ready             (cmdArbiter_io_inputs_1_ready              ), //o
    .io_inputs_1_payload_addr      (io_inputs_1_ar_payload_addr[31:0]         ), //i
    .io_inputs_1_payload_id        (io_inputs_1_ar_payload_id[3:0]            ), //i
    .io_inputs_1_payload_region    (io_inputs_1_ar_payload_region[3:0]        ), //i
    .io_inputs_1_payload_len       (io_inputs_1_ar_payload_len[7:0]           ), //i
    .io_inputs_1_payload_size      (io_inputs_1_ar_payload_size[2:0]          ), //i
    .io_inputs_1_payload_burst     (io_inputs_1_ar_payload_burst[1:0]         ), //i
    .io_inputs_1_payload_lock      (io_inputs_1_ar_payload_lock               ), //i
    .io_inputs_1_payload_cache     (io_inputs_1_ar_payload_cache[3:0]         ), //i
    .io_inputs_1_payload_qos       (io_inputs_1_ar_payload_qos[3:0]           ), //i
    .io_inputs_1_payload_prot      (io_inputs_1_ar_payload_prot[2:0]          ), //i
    .io_output_valid               (cmdArbiter_io_output_valid                ), //o
    .io_output_ready               (io_output_ar_ready                        ), //i
    .io_output_payload_addr        (cmdArbiter_io_output_payload_addr[31:0]   ), //o
    .io_output_payload_id          (cmdArbiter_io_output_payload_id[3:0]      ), //o
    .io_output_payload_region      (cmdArbiter_io_output_payload_region[3:0]  ), //o
    .io_output_payload_len         (cmdArbiter_io_output_payload_len[7:0]     ), //o
    .io_output_payload_size        (cmdArbiter_io_output_payload_size[2:0]    ), //o
    .io_output_payload_burst       (cmdArbiter_io_output_payload_burst[1:0]   ), //o
    .io_output_payload_lock        (cmdArbiter_io_output_payload_lock         ), //o
    .io_output_payload_cache       (cmdArbiter_io_output_payload_cache[3:0]   ), //o
    .io_output_payload_qos         (cmdArbiter_io_output_payload_qos[3:0]     ), //o
    .io_output_payload_prot        (cmdArbiter_io_output_payload_prot[2:0]    ), //o
    .io_chosen                     (cmdArbiter_io_chosen                      ), //o
    .io_chosenOH                   (cmdArbiter_io_chosenOH[1:0]               ), //o
    .clk                           (clk                                       ), //i
    .reset                         (reset                                     )  //i
  );
  always @(*) begin
    case(readRspIndex)
      1'b0 : begin
        _zz_1 = io_inputs_0_r_ready;
      end
      default : begin
        _zz_1 = io_inputs_1_r_ready;
      end
    endcase
  end

  assign io_inputs_0_ar_ready = cmdArbiter_io_inputs_0_ready;
  assign io_inputs_1_ar_ready = cmdArbiter_io_inputs_1_ready;
  assign io_output_ar_valid = cmdArbiter_io_output_valid;
  assign io_output_ar_payload_addr = cmdArbiter_io_output_payload_addr;
  assign io_output_ar_payload_region = cmdArbiter_io_output_payload_region;
  assign io_output_ar_payload_len = cmdArbiter_io_output_payload_len;
  assign io_output_ar_payload_size = cmdArbiter_io_output_payload_size;
  assign io_output_ar_payload_burst = cmdArbiter_io_output_payload_burst;
  assign io_output_ar_payload_lock = cmdArbiter_io_output_payload_lock;
  assign io_output_ar_payload_cache = cmdArbiter_io_output_payload_cache;
  assign io_output_ar_payload_qos = cmdArbiter_io_output_payload_qos;
  assign io_output_ar_payload_prot = cmdArbiter_io_output_payload_prot;
  assign io_output_ar_payload_id = {cmdArbiter_io_chosen,cmdArbiter_io_output_payload_id};
  assign readRspIndex = io_output_r_payload_id[4 : 4];
  assign readRspSels_0 = (readRspIndex == 1'b0);
  assign readRspSels_1 = (readRspIndex == 1'b1);
  assign io_inputs_0_r_valid = (io_output_r_valid && readRspSels_0);
  assign io_inputs_0_r_payload_data = io_output_r_payload_data;
  assign io_inputs_0_r_payload_resp = io_output_r_payload_resp;
  assign io_inputs_0_r_payload_last = io_output_r_payload_last;
  assign io_inputs_0_r_payload_id = io_output_r_payload_id[3 : 0];
  assign io_inputs_1_r_valid = (io_output_r_valid && readRspSels_1);
  assign io_inputs_1_r_payload_data = io_output_r_payload_data;
  assign io_inputs_1_r_payload_resp = io_output_r_payload_resp;
  assign io_inputs_1_r_payload_last = io_output_r_payload_last;
  assign io_inputs_1_r_payload_id = io_output_r_payload_id[3 : 0];
  assign io_output_r_ready = _zz_1;

endmodule

//Axi4Upsizer replaced by Axi4Upsizer

module Axi4Upsizer (
  input               io_input_aw_valid,
  output              io_input_aw_ready,
  input      [31:0]   io_input_aw_payload_addr,
  input      [3:0]    io_input_aw_payload_id,
  input      [3:0]    io_input_aw_payload_region,
  input      [7:0]    io_input_aw_payload_len,
  input      [2:0]    io_input_aw_payload_size,
  input      [1:0]    io_input_aw_payload_burst,
  input      [0:0]    io_input_aw_payload_lock,
  input      [3:0]    io_input_aw_payload_cache,
  input      [3:0]    io_input_aw_payload_qos,
  input      [2:0]    io_input_aw_payload_prot,
  input               io_input_w_valid,
  output              io_input_w_ready,
  input      [31:0]   io_input_w_payload_data,
  input      [3:0]    io_input_w_payload_strb,
  input               io_input_w_payload_last,
  output              io_input_b_valid,
  input               io_input_b_ready,
  output     [3:0]    io_input_b_payload_id,
  output     [1:0]    io_input_b_payload_resp,
  input               io_input_ar_valid,
  output              io_input_ar_ready,
  input      [31:0]   io_input_ar_payload_addr,
  input      [3:0]    io_input_ar_payload_id,
  input      [3:0]    io_input_ar_payload_region,
  input      [7:0]    io_input_ar_payload_len,
  input      [2:0]    io_input_ar_payload_size,
  input      [1:0]    io_input_ar_payload_burst,
  input      [0:0]    io_input_ar_payload_lock,
  input      [3:0]    io_input_ar_payload_cache,
  input      [3:0]    io_input_ar_payload_qos,
  input      [2:0]    io_input_ar_payload_prot,
  output              io_input_r_valid,
  input               io_input_r_ready,
  output     [31:0]   io_input_r_payload_data,
  output     [3:0]    io_input_r_payload_id,
  output     [1:0]    io_input_r_payload_resp,
  output              io_input_r_payload_last,
  output              io_output_aw_valid,
  input               io_output_aw_ready,
  output     [31:0]   io_output_aw_payload_addr,
  output     [3:0]    io_output_aw_payload_id,
  output     [3:0]    io_output_aw_payload_region,
  output     [7:0]    io_output_aw_payload_len,
  output     [2:0]    io_output_aw_payload_size,
  output     [1:0]    io_output_aw_payload_burst,
  output     [0:0]    io_output_aw_payload_lock,
  output     [3:0]    io_output_aw_payload_cache,
  output     [3:0]    io_output_aw_payload_qos,
  output     [2:0]    io_output_aw_payload_prot,
  output              io_output_w_valid,
  input               io_output_w_ready,
  output     [255:0]  io_output_w_payload_data,
  output     [31:0]   io_output_w_payload_strb,
  output              io_output_w_payload_last,
  input               io_output_b_valid,
  output              io_output_b_ready,
  input      [3:0]    io_output_b_payload_id,
  input      [1:0]    io_output_b_payload_resp,
  output              io_output_ar_valid,
  input               io_output_ar_ready,
  output     [31:0]   io_output_ar_payload_addr,
  output     [3:0]    io_output_ar_payload_id,
  output     [3:0]    io_output_ar_payload_region,
  output     [7:0]    io_output_ar_payload_len,
  output     [2:0]    io_output_ar_payload_size,
  output     [1:0]    io_output_ar_payload_burst,
  output     [0:0]    io_output_ar_payload_lock,
  output     [3:0]    io_output_ar_payload_cache,
  output     [3:0]    io_output_ar_payload_qos,
  output     [2:0]    io_output_ar_payload_prot,
  input               io_output_r_valid,
  output              io_output_r_ready,
  input      [255:0]  io_output_r_payload_data,
  input      [3:0]    io_output_r_payload_id,
  input      [1:0]    io_output_r_payload_resp,
  input               io_output_r_payload_last,
  input               clk,
  input               reset
);
  wire                readOnly_io_input_ar_ready;
  wire                readOnly_io_input_r_valid;
  wire       [31:0]   readOnly_io_input_r_payload_data;
  wire       [3:0]    readOnly_io_input_r_payload_id;
  wire       [1:0]    readOnly_io_input_r_payload_resp;
  wire                readOnly_io_input_r_payload_last;
  wire                readOnly_io_output_ar_valid;
  wire       [31:0]   readOnly_io_output_ar_payload_addr;
  wire       [3:0]    readOnly_io_output_ar_payload_id;
  wire       [3:0]    readOnly_io_output_ar_payload_region;
  wire       [7:0]    readOnly_io_output_ar_payload_len;
  wire       [2:0]    readOnly_io_output_ar_payload_size;
  wire       [1:0]    readOnly_io_output_ar_payload_burst;
  wire       [0:0]    readOnly_io_output_ar_payload_lock;
  wire       [3:0]    readOnly_io_output_ar_payload_cache;
  wire       [3:0]    readOnly_io_output_ar_payload_qos;
  wire       [2:0]    readOnly_io_output_ar_payload_prot;
  wire                readOnly_io_output_r_ready;
  wire                writeOnly_io_input_aw_ready;
  wire                writeOnly_io_input_w_ready;
  wire                writeOnly_io_input_b_valid;
  wire       [3:0]    writeOnly_io_input_b_payload_id;
  wire       [1:0]    writeOnly_io_input_b_payload_resp;
  wire                writeOnly_io_output_aw_valid;
  wire       [31:0]   writeOnly_io_output_aw_payload_addr;
  wire       [3:0]    writeOnly_io_output_aw_payload_id;
  wire       [3:0]    writeOnly_io_output_aw_payload_region;
  wire       [7:0]    writeOnly_io_output_aw_payload_len;
  wire       [2:0]    writeOnly_io_output_aw_payload_size;
  wire       [1:0]    writeOnly_io_output_aw_payload_burst;
  wire       [0:0]    writeOnly_io_output_aw_payload_lock;
  wire       [3:0]    writeOnly_io_output_aw_payload_cache;
  wire       [3:0]    writeOnly_io_output_aw_payload_qos;
  wire       [2:0]    writeOnly_io_output_aw_payload_prot;
  wire                writeOnly_io_output_w_valid;
  wire       [255:0]  writeOnly_io_output_w_payload_data;
  wire       [31:0]   writeOnly_io_output_w_payload_strb;
  wire                writeOnly_io_output_w_payload_last;
  wire                writeOnly_io_output_b_ready;

  Axi4ReadOnlyUpsizer readOnly (
    .io_input_ar_valid              (io_input_ar_valid                          ), //i
    .io_input_ar_ready              (readOnly_io_input_ar_ready                 ), //o
    .io_input_ar_payload_addr       (io_input_ar_payload_addr[31:0]             ), //i
    .io_input_ar_payload_id         (io_input_ar_payload_id[3:0]                ), //i
    .io_input_ar_payload_region     (io_input_ar_payload_region[3:0]            ), //i
    .io_input_ar_payload_len        (io_input_ar_payload_len[7:0]               ), //i
    .io_input_ar_payload_size       (io_input_ar_payload_size[2:0]              ), //i
    .io_input_ar_payload_burst      (io_input_ar_payload_burst[1:0]             ), //i
    .io_input_ar_payload_lock       (io_input_ar_payload_lock                   ), //i
    .io_input_ar_payload_cache      (io_input_ar_payload_cache[3:0]             ), //i
    .io_input_ar_payload_qos        (io_input_ar_payload_qos[3:0]               ), //i
    .io_input_ar_payload_prot       (io_input_ar_payload_prot[2:0]              ), //i
    .io_input_r_valid               (readOnly_io_input_r_valid                  ), //o
    .io_input_r_ready               (io_input_r_ready                           ), //i
    .io_input_r_payload_data        (readOnly_io_input_r_payload_data[31:0]     ), //o
    .io_input_r_payload_id          (readOnly_io_input_r_payload_id[3:0]        ), //o
    .io_input_r_payload_resp        (readOnly_io_input_r_payload_resp[1:0]      ), //o
    .io_input_r_payload_last        (readOnly_io_input_r_payload_last           ), //o
    .io_output_ar_valid             (readOnly_io_output_ar_valid                ), //o
    .io_output_ar_ready             (io_output_ar_ready                         ), //i
    .io_output_ar_payload_addr      (readOnly_io_output_ar_payload_addr[31:0]   ), //o
    .io_output_ar_payload_id        (readOnly_io_output_ar_payload_id[3:0]      ), //o
    .io_output_ar_payload_region    (readOnly_io_output_ar_payload_region[3:0]  ), //o
    .io_output_ar_payload_len       (readOnly_io_output_ar_payload_len[7:0]     ), //o
    .io_output_ar_payload_size      (readOnly_io_output_ar_payload_size[2:0]    ), //o
    .io_output_ar_payload_burst     (readOnly_io_output_ar_payload_burst[1:0]   ), //o
    .io_output_ar_payload_lock      (readOnly_io_output_ar_payload_lock         ), //o
    .io_output_ar_payload_cache     (readOnly_io_output_ar_payload_cache[3:0]   ), //o
    .io_output_ar_payload_qos       (readOnly_io_output_ar_payload_qos[3:0]     ), //o
    .io_output_ar_payload_prot      (readOnly_io_output_ar_payload_prot[2:0]    ), //o
    .io_output_r_valid              (io_output_r_valid                          ), //i
    .io_output_r_ready              (readOnly_io_output_r_ready                 ), //o
    .io_output_r_payload_data       (io_output_r_payload_data[255:0]            ), //i
    .io_output_r_payload_id         (io_output_r_payload_id[3:0]                ), //i
    .io_output_r_payload_resp       (io_output_r_payload_resp[1:0]              ), //i
    .io_output_r_payload_last       (io_output_r_payload_last                   ), //i
    .clk                            (clk                                        ), //i
    .reset                          (reset                                      )  //i
  );
  Axi4WriteOnlyUpsizer writeOnly (
    .io_input_aw_valid              (io_input_aw_valid                           ), //i
    .io_input_aw_ready              (writeOnly_io_input_aw_ready                 ), //o
    .io_input_aw_payload_addr       (io_input_aw_payload_addr[31:0]              ), //i
    .io_input_aw_payload_id         (io_input_aw_payload_id[3:0]                 ), //i
    .io_input_aw_payload_region     (io_input_aw_payload_region[3:0]             ), //i
    .io_input_aw_payload_len        (io_input_aw_payload_len[7:0]                ), //i
    .io_input_aw_payload_size       (io_input_aw_payload_size[2:0]               ), //i
    .io_input_aw_payload_burst      (io_input_aw_payload_burst[1:0]              ), //i
    .io_input_aw_payload_lock       (io_input_aw_payload_lock                    ), //i
    .io_input_aw_payload_cache      (io_input_aw_payload_cache[3:0]              ), //i
    .io_input_aw_payload_qos        (io_input_aw_payload_qos[3:0]                ), //i
    .io_input_aw_payload_prot       (io_input_aw_payload_prot[2:0]               ), //i
    .io_input_w_valid               (io_input_w_valid                            ), //i
    .io_input_w_ready               (writeOnly_io_input_w_ready                  ), //o
    .io_input_w_payload_data        (io_input_w_payload_data[31:0]               ), //i
    .io_input_w_payload_strb        (io_input_w_payload_strb[3:0]                ), //i
    .io_input_w_payload_last        (io_input_w_payload_last                     ), //i
    .io_input_b_valid               (writeOnly_io_input_b_valid                  ), //o
    .io_input_b_ready               (io_input_b_ready                            ), //i
    .io_input_b_payload_id          (writeOnly_io_input_b_payload_id[3:0]        ), //o
    .io_input_b_payload_resp        (writeOnly_io_input_b_payload_resp[1:0]      ), //o
    .io_output_aw_valid             (writeOnly_io_output_aw_valid                ), //o
    .io_output_aw_ready             (io_output_aw_ready                          ), //i
    .io_output_aw_payload_addr      (writeOnly_io_output_aw_payload_addr[31:0]   ), //o
    .io_output_aw_payload_id        (writeOnly_io_output_aw_payload_id[3:0]      ), //o
    .io_output_aw_payload_region    (writeOnly_io_output_aw_payload_region[3:0]  ), //o
    .io_output_aw_payload_len       (writeOnly_io_output_aw_payload_len[7:0]     ), //o
    .io_output_aw_payload_size      (writeOnly_io_output_aw_payload_size[2:0]    ), //o
    .io_output_aw_payload_burst     (writeOnly_io_output_aw_payload_burst[1:0]   ), //o
    .io_output_aw_payload_lock      (writeOnly_io_output_aw_payload_lock         ), //o
    .io_output_aw_payload_cache     (writeOnly_io_output_aw_payload_cache[3:0]   ), //o
    .io_output_aw_payload_qos       (writeOnly_io_output_aw_payload_qos[3:0]     ), //o
    .io_output_aw_payload_prot      (writeOnly_io_output_aw_payload_prot[2:0]    ), //o
    .io_output_w_valid              (writeOnly_io_output_w_valid                 ), //o
    .io_output_w_ready              (io_output_w_ready                           ), //i
    .io_output_w_payload_data       (writeOnly_io_output_w_payload_data[255:0]   ), //o
    .io_output_w_payload_strb       (writeOnly_io_output_w_payload_strb[31:0]    ), //o
    .io_output_w_payload_last       (writeOnly_io_output_w_payload_last          ), //o
    .io_output_b_valid              (io_output_b_valid                           ), //i
    .io_output_b_ready              (writeOnly_io_output_b_ready                 ), //o
    .io_output_b_payload_id         (io_output_b_payload_id[3:0]                 ), //i
    .io_output_b_payload_resp       (io_output_b_payload_resp[1:0]               ), //i
    .clk                            (clk                                         ), //i
    .reset                          (reset                                       )  //i
  );
  assign io_input_ar_ready = readOnly_io_input_ar_ready;
  assign io_input_r_valid = readOnly_io_input_r_valid;
  assign io_input_r_payload_data = readOnly_io_input_r_payload_data;
  assign io_input_r_payload_id = readOnly_io_input_r_payload_id;
  assign io_input_r_payload_resp = readOnly_io_input_r_payload_resp;
  assign io_input_r_payload_last = readOnly_io_input_r_payload_last;
  assign io_input_aw_ready = writeOnly_io_input_aw_ready;
  assign io_input_w_ready = writeOnly_io_input_w_ready;
  assign io_input_b_valid = writeOnly_io_input_b_valid;
  assign io_input_b_payload_id = writeOnly_io_input_b_payload_id;
  assign io_input_b_payload_resp = writeOnly_io_input_b_payload_resp;
  assign io_output_ar_valid = readOnly_io_output_ar_valid;
  assign io_output_ar_payload_addr = readOnly_io_output_ar_payload_addr;
  assign io_output_ar_payload_id = readOnly_io_output_ar_payload_id;
  assign io_output_ar_payload_region = readOnly_io_output_ar_payload_region;
  assign io_output_ar_payload_len = readOnly_io_output_ar_payload_len;
  assign io_output_ar_payload_size = readOnly_io_output_ar_payload_size;
  assign io_output_ar_payload_burst = readOnly_io_output_ar_payload_burst;
  assign io_output_ar_payload_lock = readOnly_io_output_ar_payload_lock;
  assign io_output_ar_payload_cache = readOnly_io_output_ar_payload_cache;
  assign io_output_ar_payload_qos = readOnly_io_output_ar_payload_qos;
  assign io_output_ar_payload_prot = readOnly_io_output_ar_payload_prot;
  assign io_output_r_ready = readOnly_io_output_r_ready;
  assign io_output_aw_valid = writeOnly_io_output_aw_valid;
  assign io_output_aw_payload_addr = writeOnly_io_output_aw_payload_addr;
  assign io_output_aw_payload_id = writeOnly_io_output_aw_payload_id;
  assign io_output_aw_payload_region = writeOnly_io_output_aw_payload_region;
  assign io_output_aw_payload_len = writeOnly_io_output_aw_payload_len;
  assign io_output_aw_payload_size = writeOnly_io_output_aw_payload_size;
  assign io_output_aw_payload_burst = writeOnly_io_output_aw_payload_burst;
  assign io_output_aw_payload_lock = writeOnly_io_output_aw_payload_lock;
  assign io_output_aw_payload_cache = writeOnly_io_output_aw_payload_cache;
  assign io_output_aw_payload_qos = writeOnly_io_output_aw_payload_qos;
  assign io_output_aw_payload_prot = writeOnly_io_output_aw_payload_prot;
  assign io_output_w_valid = writeOnly_io_output_w_valid;
  assign io_output_w_payload_data = writeOnly_io_output_w_payload_data;
  assign io_output_w_payload_strb = writeOnly_io_output_w_payload_strb;
  assign io_output_w_payload_last = writeOnly_io_output_w_payload_last;
  assign io_output_b_ready = writeOnly_io_output_b_ready;

endmodule

module StreamFifoLowLatency_1 (
  input               io_push_valid,
  output              io_push_ready,
  input      [4:0]    io_push_payload,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [4:0]    io_pop_payload,
  input               io_flush,
  output     [2:0]    io_occupancy,
  input               clk,
  input               reset
);
  wire       [4:0]    _zz_2;
  wire       [0:0]    _zz_3;
  wire       [1:0]    _zz_4;
  wire       [0:0]    _zz_5;
  wire       [1:0]    _zz_6;
  wire       [4:0]    _zz_7;
  reg                 _zz_1;
  reg                 pushPtr_willIncrement;
  reg                 pushPtr_willClear;
  reg        [1:0]    pushPtr_valueNext;
  reg        [1:0]    pushPtr_value;
  wire                pushPtr_willOverflowIfInc;
  wire                pushPtr_willOverflow;
  reg                 popPtr_willIncrement;
  reg                 popPtr_willClear;
  reg        [1:0]    popPtr_valueNext;
  reg        [1:0]    popPtr_value;
  wire                popPtr_willOverflowIfInc;
  wire                popPtr_willOverflow;
  wire                ptrMatch;
  reg                 risingOccupancy;
  wire                empty;
  wire                full;
  wire                pushing;
  wire                popping;
  wire       [1:0]    ptrDif;
  (* ram_style = "distributed" *) reg [4:0] ram [0:3];

  assign _zz_3 = pushPtr_willIncrement;
  assign _zz_4 = {1'd0, _zz_3};
  assign _zz_5 = popPtr_willIncrement;
  assign _zz_6 = {1'd0, _zz_5};
  assign _zz_7 = io_push_payload;
  assign _zz_2 = ram[popPtr_value];
  always @ (posedge clk) begin
    if(_zz_1) begin
      ram[pushPtr_value] <= _zz_7;
    end
  end

  always @ (*) begin
    _zz_1 = 1'b0;
    if(pushing)begin
      _zz_1 = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willIncrement = 1'b0;
    if(pushing)begin
      pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willClear = 1'b0;
    if(io_flush)begin
      pushPtr_willClear = 1'b1;
    end
  end

  assign pushPtr_willOverflowIfInc = (pushPtr_value == 2'b11);
  assign pushPtr_willOverflow = (pushPtr_willOverflowIfInc && pushPtr_willIncrement);
  always @ (*) begin
    pushPtr_valueNext = (pushPtr_value + _zz_4);
    if(pushPtr_willClear)begin
      pushPtr_valueNext = 2'b00;
    end
  end

  always @ (*) begin
    popPtr_willIncrement = 1'b0;
    if(popping)begin
      popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    popPtr_willClear = 1'b0;
    if(io_flush)begin
      popPtr_willClear = 1'b1;
    end
  end

  assign popPtr_willOverflowIfInc = (popPtr_value == 2'b11);
  assign popPtr_willOverflow = (popPtr_willOverflowIfInc && popPtr_willIncrement);
  always @ (*) begin
    popPtr_valueNext = (popPtr_value + _zz_6);
    if(popPtr_willClear)begin
      popPtr_valueNext = 2'b00;
    end
  end

  assign ptrMatch = (pushPtr_value == popPtr_value);
  assign empty = (ptrMatch && (! risingOccupancy));
  assign full = (ptrMatch && risingOccupancy);
  assign pushing = (io_push_valid && io_push_ready);
  assign popping = (io_pop_valid && io_pop_ready);
  assign io_push_ready = (! full);
  assign io_pop_valid = (! empty);
  assign io_pop_payload = _zz_2;
  assign ptrDif = (pushPtr_value - popPtr_value);
  assign io_occupancy = {(risingOccupancy && ptrMatch),ptrDif};
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      pushPtr_value <= 2'b00;
      popPtr_value <= 2'b00;
      risingOccupancy <= 1'b0;
    end else begin
      pushPtr_value <= pushPtr_valueNext;
      popPtr_value <= popPtr_valueNext;
      if((pushing != popping))begin
        risingOccupancy <= pushing;
      end
      if(io_flush)begin
        risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

module StreamFork_5 (
  input               io_input_valid,
  output reg          io_input_ready,
  input      [31:0]   io_input_payload_addr,
  input      [4:0]    io_input_payload_id,
  input      [3:0]    io_input_payload_region,
  input      [7:0]    io_input_payload_len,
  input      [2:0]    io_input_payload_size,
  input      [1:0]    io_input_payload_burst,
  input      [0:0]    io_input_payload_lock,
  input      [3:0]    io_input_payload_cache,
  input      [3:0]    io_input_payload_qos,
  input      [2:0]    io_input_payload_prot,
  input               io_input_payload_write,
  output              io_outputs_0_valid,
  input               io_outputs_0_ready,
  output     [31:0]   io_outputs_0_payload_addr,
  output     [4:0]    io_outputs_0_payload_id,
  output     [3:0]    io_outputs_0_payload_region,
  output     [7:0]    io_outputs_0_payload_len,
  output     [2:0]    io_outputs_0_payload_size,
  output     [1:0]    io_outputs_0_payload_burst,
  output     [0:0]    io_outputs_0_payload_lock,
  output     [3:0]    io_outputs_0_payload_cache,
  output     [3:0]    io_outputs_0_payload_qos,
  output     [2:0]    io_outputs_0_payload_prot,
  output              io_outputs_0_payload_write,
  output              io_outputs_1_valid,
  input               io_outputs_1_ready,
  output     [31:0]   io_outputs_1_payload_addr,
  output     [4:0]    io_outputs_1_payload_id,
  output     [3:0]    io_outputs_1_payload_region,
  output     [7:0]    io_outputs_1_payload_len,
  output     [2:0]    io_outputs_1_payload_size,
  output     [1:0]    io_outputs_1_payload_burst,
  output     [0:0]    io_outputs_1_payload_lock,
  output     [3:0]    io_outputs_1_payload_cache,
  output     [3:0]    io_outputs_1_payload_qos,
  output     [2:0]    io_outputs_1_payload_prot,
  output              io_outputs_1_payload_write,
  input               clk,
  input               reset
);
  reg                 _zz_1;
  reg                 _zz_2;

  always @ (*) begin
    io_input_ready = 1'b1;
    if(((! io_outputs_0_ready) && _zz_1))begin
      io_input_ready = 1'b0;
    end
    if(((! io_outputs_1_ready) && _zz_2))begin
      io_input_ready = 1'b0;
    end
  end

  assign io_outputs_0_valid = (io_input_valid && _zz_1);
  assign io_outputs_0_payload_addr = io_input_payload_addr;
  assign io_outputs_0_payload_id = io_input_payload_id;
  assign io_outputs_0_payload_region = io_input_payload_region;
  assign io_outputs_0_payload_len = io_input_payload_len;
  assign io_outputs_0_payload_size = io_input_payload_size;
  assign io_outputs_0_payload_burst = io_input_payload_burst;
  assign io_outputs_0_payload_lock = io_input_payload_lock;
  assign io_outputs_0_payload_cache = io_input_payload_cache;
  assign io_outputs_0_payload_qos = io_input_payload_qos;
  assign io_outputs_0_payload_prot = io_input_payload_prot;
  assign io_outputs_0_payload_write = io_input_payload_write;
  assign io_outputs_1_valid = (io_input_valid && _zz_2);
  assign io_outputs_1_payload_addr = io_input_payload_addr;
  assign io_outputs_1_payload_id = io_input_payload_id;
  assign io_outputs_1_payload_region = io_input_payload_region;
  assign io_outputs_1_payload_len = io_input_payload_len;
  assign io_outputs_1_payload_size = io_input_payload_size;
  assign io_outputs_1_payload_burst = io_input_payload_burst;
  assign io_outputs_1_payload_lock = io_input_payload_lock;
  assign io_outputs_1_payload_cache = io_input_payload_cache;
  assign io_outputs_1_payload_qos = io_input_payload_qos;
  assign io_outputs_1_payload_prot = io_input_payload_prot;
  assign io_outputs_1_payload_write = io_input_payload_write;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      _zz_1 <= 1'b1;
      _zz_2 <= 1'b1;
    end else begin
      if((io_outputs_0_valid && io_outputs_0_ready))begin
        _zz_1 <= 1'b0;
      end
      if((io_outputs_1_valid && io_outputs_1_ready))begin
        _zz_2 <= 1'b0;
      end
      if(io_input_ready)begin
        _zz_1 <= 1'b1;
        _zz_2 <= 1'b1;
      end
    end
  end


endmodule

module StreamFifoLowLatency (
  input               io_push_valid,
  output              io_push_ready,
  input      [0:0]    io_push_payload,
  output reg          io_pop_valid,
  input               io_pop_ready,
  output reg [0:0]    io_pop_payload,
  input               io_flush,
  output     [2:0]    io_occupancy,
  input               clk,
  input               reset
);
  wire       [0:0]    _zz_2;
  wire                _zz_3;
  wire       [0:0]    _zz_4;
  wire       [1:0]    _zz_5;
  wire       [0:0]    _zz_6;
  wire       [1:0]    _zz_7;
  wire       [0:0]    _zz_8;
  reg                 _zz_1;
  reg                 pushPtr_willIncrement;
  reg                 pushPtr_willClear;
  reg        [1:0]    pushPtr_valueNext;
  reg        [1:0]    pushPtr_value;
  wire                pushPtr_willOverflowIfInc;
  wire                pushPtr_willOverflow;
  reg                 popPtr_willIncrement;
  reg                 popPtr_willClear;
  reg        [1:0]    popPtr_valueNext;
  reg        [1:0]    popPtr_value;
  wire                popPtr_willOverflowIfInc;
  wire                popPtr_willOverflow;
  wire                ptrMatch;
  reg                 risingOccupancy;
  wire                empty;
  wire                full;
  wire                pushing;
  wire                popping;
  wire       [1:0]    ptrDif;
  (* ram_style = "distributed" *) reg [0:0] ram [0:3];

  assign _zz_3 = (! empty);
  assign _zz_4 = pushPtr_willIncrement;
  assign _zz_5 = {1'd0, _zz_4};
  assign _zz_6 = popPtr_willIncrement;
  assign _zz_7 = {1'd0, _zz_6};
  assign _zz_8 = io_push_payload;
  assign _zz_2 = ram[popPtr_value];
  always @ (posedge clk) begin
    if(_zz_1) begin
      ram[pushPtr_value] <= _zz_8;
    end
  end

  always @ (*) begin
    _zz_1 = 1'b0;
    if(pushing)begin
      _zz_1 = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willIncrement = 1'b0;
    if(pushing)begin
      pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willClear = 1'b0;
    if(io_flush)begin
      pushPtr_willClear = 1'b1;
    end
  end

  assign pushPtr_willOverflowIfInc = (pushPtr_value == 2'b11);
  assign pushPtr_willOverflow = (pushPtr_willOverflowIfInc && pushPtr_willIncrement);
  always @ (*) begin
    pushPtr_valueNext = (pushPtr_value + _zz_5);
    if(pushPtr_willClear)begin
      pushPtr_valueNext = 2'b00;
    end
  end

  always @ (*) begin
    popPtr_willIncrement = 1'b0;
    if(popping)begin
      popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    popPtr_willClear = 1'b0;
    if(io_flush)begin
      popPtr_willClear = 1'b1;
    end
  end

  assign popPtr_willOverflowIfInc = (popPtr_value == 2'b11);
  assign popPtr_willOverflow = (popPtr_willOverflowIfInc && popPtr_willIncrement);
  always @ (*) begin
    popPtr_valueNext = (popPtr_value + _zz_7);
    if(popPtr_willClear)begin
      popPtr_valueNext = 2'b00;
    end
  end

  assign ptrMatch = (pushPtr_value == popPtr_value);
  assign empty = (ptrMatch && (! risingOccupancy));
  assign full = (ptrMatch && risingOccupancy);
  assign pushing = (io_push_valid && io_push_ready);
  assign popping = (io_pop_valid && io_pop_ready);
  assign io_push_ready = (! full);
  always @ (*) begin
    if(_zz_3)begin
      io_pop_valid = 1'b1;
    end else begin
      io_pop_valid = io_push_valid;
    end
  end

  always @ (*) begin
    if(_zz_3)begin
      io_pop_payload = _zz_2;
    end else begin
      io_pop_payload = io_push_payload;
    end
  end

  assign ptrDif = (pushPtr_value - popPtr_value);
  assign io_occupancy = {(risingOccupancy && ptrMatch),ptrDif};
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      pushPtr_value <= 2'b00;
      popPtr_value <= 2'b00;
      risingOccupancy <= 1'b0;
    end else begin
      pushPtr_value <= pushPtr_valueNext;
      popPtr_value <= popPtr_valueNext;
      if((pushing != popping))begin
        risingOccupancy <= pushing;
      end
      if(io_flush)begin
        risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

//StreamFork replaced by StreamFork

//StreamArbiter replaced by StreamArbiter

module StreamArbiter (
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input      [31:0]   io_inputs_0_payload_addr,
  input      [3:0]    io_inputs_0_payload_id,
  input      [3:0]    io_inputs_0_payload_region,
  input      [7:0]    io_inputs_0_payload_len,
  input      [2:0]    io_inputs_0_payload_size,
  input      [1:0]    io_inputs_0_payload_burst,
  input      [0:0]    io_inputs_0_payload_lock,
  input      [3:0]    io_inputs_0_payload_cache,
  input      [3:0]    io_inputs_0_payload_qos,
  input      [2:0]    io_inputs_0_payload_prot,
  input               io_inputs_1_valid,
  output              io_inputs_1_ready,
  input      [31:0]   io_inputs_1_payload_addr,
  input      [3:0]    io_inputs_1_payload_id,
  input      [3:0]    io_inputs_1_payload_region,
  input      [7:0]    io_inputs_1_payload_len,
  input      [2:0]    io_inputs_1_payload_size,
  input      [1:0]    io_inputs_1_payload_burst,
  input      [0:0]    io_inputs_1_payload_lock,
  input      [3:0]    io_inputs_1_payload_cache,
  input      [3:0]    io_inputs_1_payload_qos,
  input      [2:0]    io_inputs_1_payload_prot,
  output              io_output_valid,
  input               io_output_ready,
  output     [31:0]   io_output_payload_addr,
  output     [3:0]    io_output_payload_id,
  output     [3:0]    io_output_payload_region,
  output     [7:0]    io_output_payload_len,
  output     [2:0]    io_output_payload_size,
  output     [1:0]    io_output_payload_burst,
  output     [0:0]    io_output_payload_lock,
  output     [3:0]    io_output_payload_cache,
  output     [3:0]    io_output_payload_qos,
  output     [2:0]    io_output_payload_prot,
  output     [0:0]    io_chosen,
  output     [1:0]    io_chosenOH,
  input               clk,
  input               reset
);
  wire       [3:0]    _zz_6;
  wire       [1:0]    _zz_7;
  wire       [3:0]    _zz_8;
  wire       [0:0]    _zz_9;
  wire       [0:0]    _zz_10;
  reg                 locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire       [1:0]    _zz_1;
  wire       [3:0]    _zz_2;
  wire       [3:0]    _zz_3;
  wire       [1:0]    _zz_4;
  wire                _zz_5;

  assign _zz_6 = (_zz_2 - _zz_8);
  assign _zz_7 = {maskLocked_0,maskLocked_1};
  assign _zz_8 = {2'd0, _zz_7};
  assign _zz_9 = _zz_4[0 : 0];
  assign _zz_10 = _zz_4[1 : 1];
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
  assign _zz_1 = {io_inputs_1_valid,io_inputs_0_valid};
  assign _zz_2 = {_zz_1,_zz_1};
  assign _zz_3 = (_zz_2 & (~ _zz_6));
  assign _zz_4 = (_zz_3[3 : 2] | _zz_3[1 : 0]);
  assign maskProposal_0 = _zz_9[0];
  assign maskProposal_1 = _zz_10[0];
  assign io_output_valid = ((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1));
  assign io_output_payload_addr = (maskRouted_0 ? io_inputs_0_payload_addr : io_inputs_1_payload_addr);
  assign io_output_payload_id = (maskRouted_0 ? io_inputs_0_payload_id : io_inputs_1_payload_id);
  assign io_output_payload_region = (maskRouted_0 ? io_inputs_0_payload_region : io_inputs_1_payload_region);
  assign io_output_payload_len = (maskRouted_0 ? io_inputs_0_payload_len : io_inputs_1_payload_len);
  assign io_output_payload_size = (maskRouted_0 ? io_inputs_0_payload_size : io_inputs_1_payload_size);
  assign io_output_payload_burst = (maskRouted_0 ? io_inputs_0_payload_burst : io_inputs_1_payload_burst);
  assign io_output_payload_lock = (maskRouted_0 ? io_inputs_0_payload_lock : io_inputs_1_payload_lock);
  assign io_output_payload_cache = (maskRouted_0 ? io_inputs_0_payload_cache : io_inputs_1_payload_cache);
  assign io_output_payload_qos = (maskRouted_0 ? io_inputs_0_payload_qos : io_inputs_1_payload_qos);
  assign io_output_payload_prot = (maskRouted_0 ? io_inputs_0_payload_prot : io_inputs_1_payload_prot);
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready);
  assign io_chosenOH = {maskRouted_1,maskRouted_0};
  assign _zz_5 = io_chosenOH[1];
  assign io_chosen = _zz_5;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      locked <= 1'b0;
      maskLocked_0 <= 1'b0;
      maskLocked_1 <= 1'b1;
    end else begin
      if(io_output_valid)begin
        maskLocked_0 <= maskRouted_0;
        maskLocked_1 <= maskRouted_1;
      end
      if(io_output_valid)begin
        locked <= 1'b1;
      end
      if((io_output_valid && io_output_ready))begin
        locked <= 1'b0;
      end
    end
  end


endmodule

//Axi4WriteOnlyUpsizer replaced by Axi4WriteOnlyUpsizer

//Axi4ReadOnlyUpsizer replaced by Axi4ReadOnlyUpsizer

module Axi4WriteOnlyUpsizer (
  input               io_input_aw_valid,
  output              io_input_aw_ready,
  input      [31:0]   io_input_aw_payload_addr,
  input      [3:0]    io_input_aw_payload_id,
  input      [3:0]    io_input_aw_payload_region,
  input      [7:0]    io_input_aw_payload_len,
  input      [2:0]    io_input_aw_payload_size,
  input      [1:0]    io_input_aw_payload_burst,
  input      [0:0]    io_input_aw_payload_lock,
  input      [3:0]    io_input_aw_payload_cache,
  input      [3:0]    io_input_aw_payload_qos,
  input      [2:0]    io_input_aw_payload_prot,
  input               io_input_w_valid,
  output              io_input_w_ready,
  input      [31:0]   io_input_w_payload_data,
  input      [3:0]    io_input_w_payload_strb,
  input               io_input_w_payload_last,
  output              io_input_b_valid,
  input               io_input_b_ready,
  output     [3:0]    io_input_b_payload_id,
  output     [1:0]    io_input_b_payload_resp,
  output              io_output_aw_valid,
  input               io_output_aw_ready,
  output     [31:0]   io_output_aw_payload_addr,
  output     [3:0]    io_output_aw_payload_id,
  output     [3:0]    io_output_aw_payload_region,
  output reg [7:0]    io_output_aw_payload_len,
  output reg [2:0]    io_output_aw_payload_size,
  output     [1:0]    io_output_aw_payload_burst,
  output     [0:0]    io_output_aw_payload_lock,
  output     [3:0]    io_output_aw_payload_cache,
  output     [3:0]    io_output_aw_payload_qos,
  output     [2:0]    io_output_aw_payload_prot,
  output              io_output_w_valid,
  input               io_output_w_ready,
  output     [255:0]  io_output_w_payload_data,
  output     [31:0]   io_output_w_payload_strb,
  output              io_output_w_payload_last,
  input               io_output_b_valid,
  output              io_output_b_ready,
  input      [3:0]    io_output_b_payload_id,
  input      [1:0]    io_output_b_payload_resp,
  input               clk,
  input               reset
);
  wire                _zz_1;
  reg        [31:0]   _zz_2;
  wire                io_input_aw_fork_io_input_ready;
  wire                io_input_aw_fork_io_outputs_0_valid;
  wire       [31:0]   io_input_aw_fork_io_outputs_0_payload_addr;
  wire       [3:0]    io_input_aw_fork_io_outputs_0_payload_id;
  wire       [3:0]    io_input_aw_fork_io_outputs_0_payload_region;
  wire       [7:0]    io_input_aw_fork_io_outputs_0_payload_len;
  wire       [2:0]    io_input_aw_fork_io_outputs_0_payload_size;
  wire       [1:0]    io_input_aw_fork_io_outputs_0_payload_burst;
  wire       [0:0]    io_input_aw_fork_io_outputs_0_payload_lock;
  wire       [3:0]    io_input_aw_fork_io_outputs_0_payload_cache;
  wire       [3:0]    io_input_aw_fork_io_outputs_0_payload_qos;
  wire       [2:0]    io_input_aw_fork_io_outputs_0_payload_prot;
  wire                io_input_aw_fork_io_outputs_1_valid;
  wire       [31:0]   io_input_aw_fork_io_outputs_1_payload_addr;
  wire       [3:0]    io_input_aw_fork_io_outputs_1_payload_id;
  wire       [3:0]    io_input_aw_fork_io_outputs_1_payload_region;
  wire       [7:0]    io_input_aw_fork_io_outputs_1_payload_len;
  wire       [2:0]    io_input_aw_fork_io_outputs_1_payload_size;
  wire       [1:0]    io_input_aw_fork_io_outputs_1_payload_burst;
  wire       [0:0]    io_input_aw_fork_io_outputs_1_payload_lock;
  wire       [3:0]    io_input_aw_fork_io_outputs_1_payload_cache;
  wire       [3:0]    io_input_aw_fork_io_outputs_1_payload_qos;
  wire       [2:0]    io_input_aw_fork_io_outputs_1_payload_prot;
  wire                _zz_3;
  wire                _zz_4;
  wire                _zz_5;
  wire                _zz_6;
  wire                _zz_7;
  wire                _zz_8;
  wire                _zz_9;
  wire                _zz_10;
  wire                _zz_11;
  wire                _zz_12;
  wire                _zz_13;
  wire                _zz_14;
  wire                _zz_15;
  wire                _zz_16;
  wire                _zz_17;
  wire                _zz_18;
  wire                _zz_19;
  wire                _zz_20;
  wire                _zz_21;
  wire                _zz_22;
  wire                _zz_23;
  wire                _zz_24;
  wire                _zz_25;
  wire                _zz_26;
  wire                _zz_27;
  wire                _zz_28;
  wire                _zz_29;
  wire                _zz_30;
  wire                _zz_31;
  wire                _zz_32;
  wire                _zz_33;
  wire                _zz_34;
  wire                _zz_35;
  wire                _zz_36;
  wire                _zz_37;
  wire       [14:0]   _zz_38;
  wire       [12:0]   _zz_39;
  wire       [4:0]    _zz_40;
  wire       [12:0]   _zz_41;
  wire       [7:0]    _zz_42;
  wire       [5:0]    _zz_43;
  wire       [11:0]   cmdLogic_byteCount;
  wire       [7:0]    cmdLogic_incrLen;
  reg        [4:0]    dataLogic_byteCounter;
  reg        [2:0]    dataLogic_size;
  reg                 dataLogic_outputValid;
  reg                 dataLogic_outputLast;
  reg                 dataLogic_busy;
  reg                 dataLogic_incrementByteCounter;
  reg                 dataLogic_alwaysFire;
  wire       [5:0]    dataLogic_byteCounterNext;
  reg        [255:0]  dataLogic_dataBuffer;
  reg        [31:0]   dataLogic_maskBuffer;
  wire       [31:0]   dataLogic_byteActivity;

  assign _zz_3 = (io_output_aw_payload_burst == 2'b01);
  assign _zz_4 = (io_input_w_valid && io_input_w_ready);
  assign _zz_5 = dataLogic_byteActivity[0];
  assign _zz_6 = dataLogic_byteActivity[1];
  assign _zz_7 = dataLogic_byteActivity[2];
  assign _zz_8 = dataLogic_byteActivity[3];
  assign _zz_9 = dataLogic_byteActivity[4];
  assign _zz_10 = dataLogic_byteActivity[5];
  assign _zz_11 = dataLogic_byteActivity[6];
  assign _zz_12 = dataLogic_byteActivity[7];
  assign _zz_13 = dataLogic_byteActivity[8];
  assign _zz_14 = dataLogic_byteActivity[9];
  assign _zz_15 = dataLogic_byteActivity[10];
  assign _zz_16 = dataLogic_byteActivity[11];
  assign _zz_17 = dataLogic_byteActivity[12];
  assign _zz_18 = dataLogic_byteActivity[13];
  assign _zz_19 = dataLogic_byteActivity[14];
  assign _zz_20 = dataLogic_byteActivity[15];
  assign _zz_21 = dataLogic_byteActivity[16];
  assign _zz_22 = dataLogic_byteActivity[17];
  assign _zz_23 = dataLogic_byteActivity[18];
  assign _zz_24 = dataLogic_byteActivity[19];
  assign _zz_25 = dataLogic_byteActivity[20];
  assign _zz_26 = dataLogic_byteActivity[21];
  assign _zz_27 = dataLogic_byteActivity[22];
  assign _zz_28 = dataLogic_byteActivity[23];
  assign _zz_29 = dataLogic_byteActivity[24];
  assign _zz_30 = dataLogic_byteActivity[25];
  assign _zz_31 = dataLogic_byteActivity[26];
  assign _zz_32 = dataLogic_byteActivity[27];
  assign _zz_33 = dataLogic_byteActivity[28];
  assign _zz_34 = dataLogic_byteActivity[29];
  assign _zz_35 = dataLogic_byteActivity[30];
  assign _zz_36 = dataLogic_byteActivity[31];
  assign _zz_37 = (io_input_aw_fork_io_outputs_1_valid && _zz_1);
  assign _zz_38 = ({7'd0,io_input_aw_payload_len} <<< io_input_aw_payload_size);
  assign _zz_39 = ({1'b0,cmdLogic_byteCount} + _zz_41);
  assign _zz_40 = io_input_aw_payload_addr[4 : 0];
  assign _zz_41 = {8'd0, _zz_40};
  assign _zz_42 = ({7'd0,1'b1} <<< dataLogic_size);
  assign _zz_43 = _zz_42[5:0];
  StreamFork io_input_aw_fork (
    .io_input_valid                 (io_input_aw_valid                                  ), //i
    .io_input_ready                 (io_input_aw_fork_io_input_ready                    ), //o
    .io_input_payload_addr          (io_input_aw_payload_addr[31:0]                     ), //i
    .io_input_payload_id            (io_input_aw_payload_id[3:0]                        ), //i
    .io_input_payload_region        (io_input_aw_payload_region[3:0]                    ), //i
    .io_input_payload_len           (io_input_aw_payload_len[7:0]                       ), //i
    .io_input_payload_size          (io_input_aw_payload_size[2:0]                      ), //i
    .io_input_payload_burst         (io_input_aw_payload_burst[1:0]                     ), //i
    .io_input_payload_lock          (io_input_aw_payload_lock                           ), //i
    .io_input_payload_cache         (io_input_aw_payload_cache[3:0]                     ), //i
    .io_input_payload_qos           (io_input_aw_payload_qos[3:0]                       ), //i
    .io_input_payload_prot          (io_input_aw_payload_prot[2:0]                      ), //i
    .io_outputs_0_valid             (io_input_aw_fork_io_outputs_0_valid                ), //o
    .io_outputs_0_ready             (io_output_aw_ready                                 ), //i
    .io_outputs_0_payload_addr      (io_input_aw_fork_io_outputs_0_payload_addr[31:0]   ), //o
    .io_outputs_0_payload_id        (io_input_aw_fork_io_outputs_0_payload_id[3:0]      ), //o
    .io_outputs_0_payload_region    (io_input_aw_fork_io_outputs_0_payload_region[3:0]  ), //o
    .io_outputs_0_payload_len       (io_input_aw_fork_io_outputs_0_payload_len[7:0]     ), //o
    .io_outputs_0_payload_size      (io_input_aw_fork_io_outputs_0_payload_size[2:0]    ), //o
    .io_outputs_0_payload_burst     (io_input_aw_fork_io_outputs_0_payload_burst[1:0]   ), //o
    .io_outputs_0_payload_lock      (io_input_aw_fork_io_outputs_0_payload_lock         ), //o
    .io_outputs_0_payload_cache     (io_input_aw_fork_io_outputs_0_payload_cache[3:0]   ), //o
    .io_outputs_0_payload_qos       (io_input_aw_fork_io_outputs_0_payload_qos[3:0]     ), //o
    .io_outputs_0_payload_prot      (io_input_aw_fork_io_outputs_0_payload_prot[2:0]    ), //o
    .io_outputs_1_valid             (io_input_aw_fork_io_outputs_1_valid                ), //o
    .io_outputs_1_ready             (_zz_1                                              ), //i
    .io_outputs_1_payload_addr      (io_input_aw_fork_io_outputs_1_payload_addr[31:0]   ), //o
    .io_outputs_1_payload_id        (io_input_aw_fork_io_outputs_1_payload_id[3:0]      ), //o
    .io_outputs_1_payload_region    (io_input_aw_fork_io_outputs_1_payload_region[3:0]  ), //o
    .io_outputs_1_payload_len       (io_input_aw_fork_io_outputs_1_payload_len[7:0]     ), //o
    .io_outputs_1_payload_size      (io_input_aw_fork_io_outputs_1_payload_size[2:0]    ), //o
    .io_outputs_1_payload_burst     (io_input_aw_fork_io_outputs_1_payload_burst[1:0]   ), //o
    .io_outputs_1_payload_lock      (io_input_aw_fork_io_outputs_1_payload_lock         ), //o
    .io_outputs_1_payload_cache     (io_input_aw_fork_io_outputs_1_payload_cache[3:0]   ), //o
    .io_outputs_1_payload_qos       (io_input_aw_fork_io_outputs_1_payload_qos[3:0]     ), //o
    .io_outputs_1_payload_prot      (io_input_aw_fork_io_outputs_1_payload_prot[2:0]    ), //o
    .clk                            (clk                                                ), //i
    .reset                          (reset                                              )  //i
  );
  always @(*) begin
    case(dataLogic_size)
      3'b000 : begin
        _zz_2 = 32'h00000001;
      end
      3'b001 : begin
        _zz_2 = 32'h00000003;
      end
      3'b010 : begin
        _zz_2 = 32'h0000000f;
      end
      3'b011 : begin
        _zz_2 = 32'h000000ff;
      end
      default : begin
        _zz_2 = 32'h0000ffff;
      end
    endcase
  end

  assign io_input_aw_ready = io_input_aw_fork_io_input_ready;
  assign io_output_aw_valid = io_input_aw_fork_io_outputs_0_valid;
  assign io_output_aw_payload_addr = io_input_aw_fork_io_outputs_0_payload_addr;
  assign io_output_aw_payload_id = io_input_aw_fork_io_outputs_0_payload_id;
  assign io_output_aw_payload_region = io_input_aw_fork_io_outputs_0_payload_region;
  always @ (*) begin
    io_output_aw_payload_len = io_input_aw_fork_io_outputs_0_payload_len;
    if(_zz_3)begin
      io_output_aw_payload_len = cmdLogic_incrLen;
    end
  end

  always @ (*) begin
    io_output_aw_payload_size = io_input_aw_fork_io_outputs_0_payload_size;
    if(_zz_3)begin
      io_output_aw_payload_size = 3'b101;
    end
  end

  assign io_output_aw_payload_burst = io_input_aw_fork_io_outputs_0_payload_burst;
  assign io_output_aw_payload_lock = io_input_aw_fork_io_outputs_0_payload_lock;
  assign io_output_aw_payload_cache = io_input_aw_fork_io_outputs_0_payload_cache;
  assign io_output_aw_payload_qos = io_input_aw_fork_io_outputs_0_payload_qos;
  assign io_output_aw_payload_prot = io_input_aw_fork_io_outputs_0_payload_prot;
  assign cmdLogic_byteCount = _zz_38[11:0];
  assign cmdLogic_incrLen = _zz_39[12 : 5];
  assign dataLogic_byteCounterNext = ({1'b0,dataLogic_byteCounter} + _zz_43);
  assign dataLogic_byteActivity = (_zz_2 <<< dataLogic_byteCounter);
  assign io_output_w_valid = dataLogic_outputValid;
  assign io_input_w_ready = (dataLogic_busy && (! (io_output_w_valid && (! io_output_w_ready))));
  assign io_output_w_payload_data = dataLogic_dataBuffer;
  assign io_output_w_payload_strb = dataLogic_maskBuffer;
  assign io_output_w_payload_last = dataLogic_outputLast;
  assign _zz_1 = (! dataLogic_busy);
  assign io_input_b_valid = io_output_b_valid;
  assign io_output_b_ready = io_input_b_ready;
  assign io_input_b_payload_id = io_output_b_payload_id;
  assign io_input_b_payload_resp = io_output_b_payload_resp;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      dataLogic_outputValid <= 1'b0;
      dataLogic_busy <= 1'b0;
      dataLogic_maskBuffer <= 32'h0;
    end else begin
      if(io_output_w_ready)begin
        dataLogic_outputValid <= 1'b0;
      end
      if((io_output_w_valid && io_output_w_ready))begin
        dataLogic_maskBuffer <= 32'h0;
      end
      if(_zz_4)begin
        dataLogic_outputValid <= ((dataLogic_byteCounterNext[5] || io_input_w_payload_last) || dataLogic_alwaysFire);
        if(io_input_w_payload_last)begin
          dataLogic_busy <= 1'b0;
        end
        if(_zz_5)begin
          dataLogic_maskBuffer[0] <= io_input_w_payload_strb[0];
        end
        if(_zz_6)begin
          dataLogic_maskBuffer[1] <= io_input_w_payload_strb[1];
        end
        if(_zz_7)begin
          dataLogic_maskBuffer[2] <= io_input_w_payload_strb[2];
        end
        if(_zz_8)begin
          dataLogic_maskBuffer[3] <= io_input_w_payload_strb[3];
        end
        if(_zz_9)begin
          dataLogic_maskBuffer[4] <= io_input_w_payload_strb[0];
        end
        if(_zz_10)begin
          dataLogic_maskBuffer[5] <= io_input_w_payload_strb[1];
        end
        if(_zz_11)begin
          dataLogic_maskBuffer[6] <= io_input_w_payload_strb[2];
        end
        if(_zz_12)begin
          dataLogic_maskBuffer[7] <= io_input_w_payload_strb[3];
        end
        if(_zz_13)begin
          dataLogic_maskBuffer[8] <= io_input_w_payload_strb[0];
        end
        if(_zz_14)begin
          dataLogic_maskBuffer[9] <= io_input_w_payload_strb[1];
        end
        if(_zz_15)begin
          dataLogic_maskBuffer[10] <= io_input_w_payload_strb[2];
        end
        if(_zz_16)begin
          dataLogic_maskBuffer[11] <= io_input_w_payload_strb[3];
        end
        if(_zz_17)begin
          dataLogic_maskBuffer[12] <= io_input_w_payload_strb[0];
        end
        if(_zz_18)begin
          dataLogic_maskBuffer[13] <= io_input_w_payload_strb[1];
        end
        if(_zz_19)begin
          dataLogic_maskBuffer[14] <= io_input_w_payload_strb[2];
        end
        if(_zz_20)begin
          dataLogic_maskBuffer[15] <= io_input_w_payload_strb[3];
        end
        if(_zz_21)begin
          dataLogic_maskBuffer[16] <= io_input_w_payload_strb[0];
        end
        if(_zz_22)begin
          dataLogic_maskBuffer[17] <= io_input_w_payload_strb[1];
        end
        if(_zz_23)begin
          dataLogic_maskBuffer[18] <= io_input_w_payload_strb[2];
        end
        if(_zz_24)begin
          dataLogic_maskBuffer[19] <= io_input_w_payload_strb[3];
        end
        if(_zz_25)begin
          dataLogic_maskBuffer[20] <= io_input_w_payload_strb[0];
        end
        if(_zz_26)begin
          dataLogic_maskBuffer[21] <= io_input_w_payload_strb[1];
        end
        if(_zz_27)begin
          dataLogic_maskBuffer[22] <= io_input_w_payload_strb[2];
        end
        if(_zz_28)begin
          dataLogic_maskBuffer[23] <= io_input_w_payload_strb[3];
        end
        if(_zz_29)begin
          dataLogic_maskBuffer[24] <= io_input_w_payload_strb[0];
        end
        if(_zz_30)begin
          dataLogic_maskBuffer[25] <= io_input_w_payload_strb[1];
        end
        if(_zz_31)begin
          dataLogic_maskBuffer[26] <= io_input_w_payload_strb[2];
        end
        if(_zz_32)begin
          dataLogic_maskBuffer[27] <= io_input_w_payload_strb[3];
        end
        if(_zz_33)begin
          dataLogic_maskBuffer[28] <= io_input_w_payload_strb[0];
        end
        if(_zz_34)begin
          dataLogic_maskBuffer[29] <= io_input_w_payload_strb[1];
        end
        if(_zz_35)begin
          dataLogic_maskBuffer[30] <= io_input_w_payload_strb[2];
        end
        if(_zz_36)begin
          dataLogic_maskBuffer[31] <= io_input_w_payload_strb[3];
        end
      end
      if(_zz_37)begin
        dataLogic_busy <= 1'b1;
      end
    end
  end

  always @ (posedge clk) begin
    if(_zz_4)begin
      if(dataLogic_incrementByteCounter)begin
        dataLogic_byteCounter <= dataLogic_byteCounterNext[4:0];
      end
      dataLogic_outputLast <= io_input_w_payload_last;
      if(_zz_5)begin
        dataLogic_dataBuffer[7 : 0] <= io_input_w_payload_data[7 : 0];
      end
      if(_zz_6)begin
        dataLogic_dataBuffer[15 : 8] <= io_input_w_payload_data[15 : 8];
      end
      if(_zz_7)begin
        dataLogic_dataBuffer[23 : 16] <= io_input_w_payload_data[23 : 16];
      end
      if(_zz_8)begin
        dataLogic_dataBuffer[31 : 24] <= io_input_w_payload_data[31 : 24];
      end
      if(_zz_9)begin
        dataLogic_dataBuffer[39 : 32] <= io_input_w_payload_data[7 : 0];
      end
      if(_zz_10)begin
        dataLogic_dataBuffer[47 : 40] <= io_input_w_payload_data[15 : 8];
      end
      if(_zz_11)begin
        dataLogic_dataBuffer[55 : 48] <= io_input_w_payload_data[23 : 16];
      end
      if(_zz_12)begin
        dataLogic_dataBuffer[63 : 56] <= io_input_w_payload_data[31 : 24];
      end
      if(_zz_13)begin
        dataLogic_dataBuffer[71 : 64] <= io_input_w_payload_data[7 : 0];
      end
      if(_zz_14)begin
        dataLogic_dataBuffer[79 : 72] <= io_input_w_payload_data[15 : 8];
      end
      if(_zz_15)begin
        dataLogic_dataBuffer[87 : 80] <= io_input_w_payload_data[23 : 16];
      end
      if(_zz_16)begin
        dataLogic_dataBuffer[95 : 88] <= io_input_w_payload_data[31 : 24];
      end
      if(_zz_17)begin
        dataLogic_dataBuffer[103 : 96] <= io_input_w_payload_data[7 : 0];
      end
      if(_zz_18)begin
        dataLogic_dataBuffer[111 : 104] <= io_input_w_payload_data[15 : 8];
      end
      if(_zz_19)begin
        dataLogic_dataBuffer[119 : 112] <= io_input_w_payload_data[23 : 16];
      end
      if(_zz_20)begin
        dataLogic_dataBuffer[127 : 120] <= io_input_w_payload_data[31 : 24];
      end
      if(_zz_21)begin
        dataLogic_dataBuffer[135 : 128] <= io_input_w_payload_data[7 : 0];
      end
      if(_zz_22)begin
        dataLogic_dataBuffer[143 : 136] <= io_input_w_payload_data[15 : 8];
      end
      if(_zz_23)begin
        dataLogic_dataBuffer[151 : 144] <= io_input_w_payload_data[23 : 16];
      end
      if(_zz_24)begin
        dataLogic_dataBuffer[159 : 152] <= io_input_w_payload_data[31 : 24];
      end
      if(_zz_25)begin
        dataLogic_dataBuffer[167 : 160] <= io_input_w_payload_data[7 : 0];
      end
      if(_zz_26)begin
        dataLogic_dataBuffer[175 : 168] <= io_input_w_payload_data[15 : 8];
      end
      if(_zz_27)begin
        dataLogic_dataBuffer[183 : 176] <= io_input_w_payload_data[23 : 16];
      end
      if(_zz_28)begin
        dataLogic_dataBuffer[191 : 184] <= io_input_w_payload_data[31 : 24];
      end
      if(_zz_29)begin
        dataLogic_dataBuffer[199 : 192] <= io_input_w_payload_data[7 : 0];
      end
      if(_zz_30)begin
        dataLogic_dataBuffer[207 : 200] <= io_input_w_payload_data[15 : 8];
      end
      if(_zz_31)begin
        dataLogic_dataBuffer[215 : 208] <= io_input_w_payload_data[23 : 16];
      end
      if(_zz_32)begin
        dataLogic_dataBuffer[223 : 216] <= io_input_w_payload_data[31 : 24];
      end
      if(_zz_33)begin
        dataLogic_dataBuffer[231 : 224] <= io_input_w_payload_data[7 : 0];
      end
      if(_zz_34)begin
        dataLogic_dataBuffer[239 : 232] <= io_input_w_payload_data[15 : 8];
      end
      if(_zz_35)begin
        dataLogic_dataBuffer[247 : 240] <= io_input_w_payload_data[23 : 16];
      end
      if(_zz_36)begin
        dataLogic_dataBuffer[255 : 248] <= io_input_w_payload_data[31 : 24];
      end
    end
    if(_zz_37)begin
      dataLogic_byteCounter <= io_input_aw_fork_io_outputs_1_payload_addr[4:0];
      dataLogic_size <= io_input_aw_fork_io_outputs_1_payload_size;
      dataLogic_alwaysFire <= (! (io_input_aw_fork_io_outputs_1_payload_burst == 2'b01));
      dataLogic_incrementByteCounter <= (! (io_input_aw_fork_io_outputs_1_payload_burst == 2'b00));
    end
  end


endmodule

module Axi4ReadOnlyUpsizer (
  input               io_input_ar_valid,
  output              io_input_ar_ready,
  input      [31:0]   io_input_ar_payload_addr,
  input      [3:0]    io_input_ar_payload_id,
  input      [3:0]    io_input_ar_payload_region,
  input      [7:0]    io_input_ar_payload_len,
  input      [2:0]    io_input_ar_payload_size,
  input      [1:0]    io_input_ar_payload_burst,
  input      [0:0]    io_input_ar_payload_lock,
  input      [3:0]    io_input_ar_payload_cache,
  input      [3:0]    io_input_ar_payload_qos,
  input      [2:0]    io_input_ar_payload_prot,
  output              io_input_r_valid,
  input               io_input_r_ready,
  output     [31:0]   io_input_r_payload_data,
  output     [3:0]    io_input_r_payload_id,
  output     [1:0]    io_input_r_payload_resp,
  output              io_input_r_payload_last,
  output              io_output_ar_valid,
  input               io_output_ar_ready,
  output     [31:0]   io_output_ar_payload_addr,
  output     [3:0]    io_output_ar_payload_id,
  output     [3:0]    io_output_ar_payload_region,
  output     [7:0]    io_output_ar_payload_len,
  output     [2:0]    io_output_ar_payload_size,
  output     [1:0]    io_output_ar_payload_burst,
  output     [0:0]    io_output_ar_payload_lock,
  output     [3:0]    io_output_ar_payload_cache,
  output     [3:0]    io_output_ar_payload_qos,
  output     [2:0]    io_output_ar_payload_prot,
  input               io_output_r_valid,
  output              io_output_r_ready,
  input      [255:0]  io_output_r_payload_data,
  input      [3:0]    io_output_r_payload_id,
  input      [1:0]    io_output_r_payload_resp,
  input               io_output_r_payload_last,
  input               clk,
  input               reset
);
  wire                _zz_1;
  wire                _zz_2;
  reg        [31:0]   _zz_3;
  wire                io_input_ar_fork_io_input_ready;
  wire                io_input_ar_fork_io_outputs_0_valid;
  wire       [31:0]   io_input_ar_fork_io_outputs_0_payload_addr;
  wire       [3:0]    io_input_ar_fork_io_outputs_0_payload_id;
  wire       [3:0]    io_input_ar_fork_io_outputs_0_payload_region;
  wire       [7:0]    io_input_ar_fork_io_outputs_0_payload_len;
  wire       [2:0]    io_input_ar_fork_io_outputs_0_payload_size;
  wire       [1:0]    io_input_ar_fork_io_outputs_0_payload_burst;
  wire       [0:0]    io_input_ar_fork_io_outputs_0_payload_lock;
  wire       [3:0]    io_input_ar_fork_io_outputs_0_payload_cache;
  wire       [3:0]    io_input_ar_fork_io_outputs_0_payload_qos;
  wire       [2:0]    io_input_ar_fork_io_outputs_0_payload_prot;
  wire                io_input_ar_fork_io_outputs_1_valid;
  wire       [31:0]   io_input_ar_fork_io_outputs_1_payload_addr;
  wire       [3:0]    io_input_ar_fork_io_outputs_1_payload_id;
  wire       [3:0]    io_input_ar_fork_io_outputs_1_payload_region;
  wire       [7:0]    io_input_ar_fork_io_outputs_1_payload_len;
  wire       [2:0]    io_input_ar_fork_io_outputs_1_payload_size;
  wire       [1:0]    io_input_ar_fork_io_outputs_1_payload_burst;
  wire       [0:0]    io_input_ar_fork_io_outputs_1_payload_lock;
  wire       [3:0]    io_input_ar_fork_io_outputs_1_payload_cache;
  wire       [3:0]    io_input_ar_fork_io_outputs_1_payload_qos;
  wire       [2:0]    io_input_ar_fork_io_outputs_1_payload_prot;
  wire                dataLogic_cmdPush_fifo_io_push_ready;
  wire                dataLogic_cmdPush_fifo_io_pop_valid;
  wire       [4:0]    dataLogic_cmdPush_fifo_io_pop_payload_startAt;
  wire       [4:0]    dataLogic_cmdPush_fifo_io_pop_payload_endAt;
  wire       [2:0]    dataLogic_cmdPush_fifo_io_pop_payload_size;
  wire       [3:0]    dataLogic_cmdPush_fifo_io_pop_payload_id;
  wire       [6:0]    dataLogic_cmdPush_fifo_io_occupancy;
  wire       [6:0]    dataLogic_cmdPush_fifo_io_availability;
  wire                _zz_4;
  wire                _zz_5;
  wire       [14:0]   _zz_6;
  wire       [12:0]   _zz_7;
  wire       [4:0]    _zz_8;
  wire       [12:0]   _zz_9;
  wire       [31:0]   _zz_10;
  wire       [14:0]   _zz_11;
  wire       [31:0]   _zz_12;
  wire       [7:0]    _zz_13;
  wire       [5:0]    _zz_14;
  wire       [2:0]    _zz_15;
  wire       [11:0]   cmdLogic_byteCount;
  wire       [7:0]    cmdLogic_incrLen;
  wire                dataLogic_cmdPush_valid;
  wire                dataLogic_cmdPush_ready;
  wire       [4:0]    dataLogic_cmdPush_payload_startAt;
  wire       [4:0]    dataLogic_cmdPush_payload_endAt;
  wire       [2:0]    dataLogic_cmdPush_payload_size;
  wire       [3:0]    dataLogic_cmdPush_payload_id;
  reg        [2:0]    dataLogic_size;
  reg                 dataLogic_busy;
  reg        [3:0]    dataLogic_id;
  reg        [4:0]    dataLogic_byteCounter;
  reg        [4:0]    dataLogic_byteCounterLast;
  wire       [5:0]    dataLogic_byteCounterNext;

  assign _zz_4 = (dataLogic_cmdPush_fifo_io_pop_valid && _zz_1);
  assign _zz_5 = (io_input_r_valid && io_input_r_ready);
  assign _zz_6 = ({7'd0,io_input_ar_payload_len} <<< io_input_ar_payload_size);
  assign _zz_7 = ({1'b0,cmdLogic_byteCount} + _zz_9);
  assign _zz_8 = io_input_ar_payload_addr[4 : 0];
  assign _zz_9 = {8'd0, _zz_8};
  assign _zz_10 = (io_input_ar_fork_io_outputs_1_payload_addr + _zz_12);
  assign _zz_11 = ({7'd0,io_input_ar_fork_io_outputs_1_payload_len} <<< io_input_ar_fork_io_outputs_1_payload_size);
  assign _zz_12 = {17'd0, _zz_11};
  assign _zz_13 = ({7'd0,1'b1} <<< dataLogic_size);
  assign _zz_14 = _zz_13[5:0];
  assign _zz_15 = (dataLogic_byteCounter >>> 2);
  StreamFork io_input_ar_fork (
    .io_input_valid                 (io_input_ar_valid                                  ), //i
    .io_input_ready                 (io_input_ar_fork_io_input_ready                    ), //o
    .io_input_payload_addr          (io_input_ar_payload_addr[31:0]                     ), //i
    .io_input_payload_id            (io_input_ar_payload_id[3:0]                        ), //i
    .io_input_payload_region        (io_input_ar_payload_region[3:0]                    ), //i
    .io_input_payload_len           (io_input_ar_payload_len[7:0]                       ), //i
    .io_input_payload_size          (io_input_ar_payload_size[2:0]                      ), //i
    .io_input_payload_burst         (io_input_ar_payload_burst[1:0]                     ), //i
    .io_input_payload_lock          (io_input_ar_payload_lock                           ), //i
    .io_input_payload_cache         (io_input_ar_payload_cache[3:0]                     ), //i
    .io_input_payload_qos           (io_input_ar_payload_qos[3:0]                       ), //i
    .io_input_payload_prot          (io_input_ar_payload_prot[2:0]                      ), //i
    .io_outputs_0_valid             (io_input_ar_fork_io_outputs_0_valid                ), //o
    .io_outputs_0_ready             (io_output_ar_ready                                 ), //i
    .io_outputs_0_payload_addr      (io_input_ar_fork_io_outputs_0_payload_addr[31:0]   ), //o
    .io_outputs_0_payload_id        (io_input_ar_fork_io_outputs_0_payload_id[3:0]      ), //o
    .io_outputs_0_payload_region    (io_input_ar_fork_io_outputs_0_payload_region[3:0]  ), //o
    .io_outputs_0_payload_len       (io_input_ar_fork_io_outputs_0_payload_len[7:0]     ), //o
    .io_outputs_0_payload_size      (io_input_ar_fork_io_outputs_0_payload_size[2:0]    ), //o
    .io_outputs_0_payload_burst     (io_input_ar_fork_io_outputs_0_payload_burst[1:0]   ), //o
    .io_outputs_0_payload_lock      (io_input_ar_fork_io_outputs_0_payload_lock         ), //o
    .io_outputs_0_payload_cache     (io_input_ar_fork_io_outputs_0_payload_cache[3:0]   ), //o
    .io_outputs_0_payload_qos       (io_input_ar_fork_io_outputs_0_payload_qos[3:0]     ), //o
    .io_outputs_0_payload_prot      (io_input_ar_fork_io_outputs_0_payload_prot[2:0]    ), //o
    .io_outputs_1_valid             (io_input_ar_fork_io_outputs_1_valid                ), //o
    .io_outputs_1_ready             (dataLogic_cmdPush_ready                            ), //i
    .io_outputs_1_payload_addr      (io_input_ar_fork_io_outputs_1_payload_addr[31:0]   ), //o
    .io_outputs_1_payload_id        (io_input_ar_fork_io_outputs_1_payload_id[3:0]      ), //o
    .io_outputs_1_payload_region    (io_input_ar_fork_io_outputs_1_payload_region[3:0]  ), //o
    .io_outputs_1_payload_len       (io_input_ar_fork_io_outputs_1_payload_len[7:0]     ), //o
    .io_outputs_1_payload_size      (io_input_ar_fork_io_outputs_1_payload_size[2:0]    ), //o
    .io_outputs_1_payload_burst     (io_input_ar_fork_io_outputs_1_payload_burst[1:0]   ), //o
    .io_outputs_1_payload_lock      (io_input_ar_fork_io_outputs_1_payload_lock         ), //o
    .io_outputs_1_payload_cache     (io_input_ar_fork_io_outputs_1_payload_cache[3:0]   ), //o
    .io_outputs_1_payload_qos       (io_input_ar_fork_io_outputs_1_payload_qos[3:0]     ), //o
    .io_outputs_1_payload_prot      (io_input_ar_fork_io_outputs_1_payload_prot[2:0]    ), //o
    .clk                            (clk                                                ), //i
    .reset                          (reset                                              )  //i
  );
  StreamFifo dataLogic_cmdPush_fifo (
    .io_push_valid              (dataLogic_cmdPush_valid                             ), //i
    .io_push_ready              (dataLogic_cmdPush_fifo_io_push_ready                ), //o
    .io_push_payload_startAt    (dataLogic_cmdPush_payload_startAt[4:0]              ), //i
    .io_push_payload_endAt      (dataLogic_cmdPush_payload_endAt[4:0]                ), //i
    .io_push_payload_size       (dataLogic_cmdPush_payload_size[2:0]                 ), //i
    .io_push_payload_id         (dataLogic_cmdPush_payload_id[3:0]                   ), //i
    .io_pop_valid               (dataLogic_cmdPush_fifo_io_pop_valid                 ), //o
    .io_pop_ready               (_zz_1                                               ), //i
    .io_pop_payload_startAt     (dataLogic_cmdPush_fifo_io_pop_payload_startAt[4:0]  ), //o
    .io_pop_payload_endAt       (dataLogic_cmdPush_fifo_io_pop_payload_endAt[4:0]    ), //o
    .io_pop_payload_size        (dataLogic_cmdPush_fifo_io_pop_payload_size[2:0]     ), //o
    .io_pop_payload_id          (dataLogic_cmdPush_fifo_io_pop_payload_id[3:0]       ), //o
    .io_flush                   (_zz_2                                               ), //i
    .io_occupancy               (dataLogic_cmdPush_fifo_io_occupancy[6:0]            ), //o
    .io_availability            (dataLogic_cmdPush_fifo_io_availability[6:0]         ), //o
    .clk                        (clk                                                 ), //i
    .reset                      (reset                                               )  //i
  );
  always @(*) begin
    case(_zz_15)
      3'b000 : begin
        _zz_3 = io_output_r_payload_data[31 : 0];
      end
      3'b001 : begin
        _zz_3 = io_output_r_payload_data[63 : 32];
      end
      3'b010 : begin
        _zz_3 = io_output_r_payload_data[95 : 64];
      end
      3'b011 : begin
        _zz_3 = io_output_r_payload_data[127 : 96];
      end
      3'b100 : begin
        _zz_3 = io_output_r_payload_data[159 : 128];
      end
      3'b101 : begin
        _zz_3 = io_output_r_payload_data[191 : 160];
      end
      3'b110 : begin
        _zz_3 = io_output_r_payload_data[223 : 192];
      end
      default : begin
        _zz_3 = io_output_r_payload_data[255 : 224];
      end
    endcase
  end

  assign io_input_ar_ready = io_input_ar_fork_io_input_ready;
  assign io_output_ar_valid = io_input_ar_fork_io_outputs_0_valid;
  assign io_output_ar_payload_addr = io_input_ar_fork_io_outputs_0_payload_addr;
  assign io_output_ar_payload_region = io_input_ar_fork_io_outputs_0_payload_region;
  assign io_output_ar_payload_burst = io_input_ar_fork_io_outputs_0_payload_burst;
  assign io_output_ar_payload_lock = io_input_ar_fork_io_outputs_0_payload_lock;
  assign io_output_ar_payload_cache = io_input_ar_fork_io_outputs_0_payload_cache;
  assign io_output_ar_payload_qos = io_input_ar_fork_io_outputs_0_payload_qos;
  assign io_output_ar_payload_prot = io_input_ar_fork_io_outputs_0_payload_prot;
  assign cmdLogic_byteCount = _zz_6[11:0];
  assign cmdLogic_incrLen = _zz_7[12 : 5];
  assign io_output_ar_payload_size = 3'b101;
  assign io_output_ar_payload_len = cmdLogic_incrLen;
  assign io_output_ar_payload_id = 4'b0000;
  assign dataLogic_cmdPush_valid = io_input_ar_fork_io_outputs_1_valid;
  assign dataLogic_cmdPush_payload_startAt = io_input_ar_fork_io_outputs_1_payload_addr[4:0];
  assign dataLogic_cmdPush_payload_endAt = _zz_10[4:0];
  assign dataLogic_cmdPush_payload_size = io_input_ar_fork_io_outputs_1_payload_size;
  assign dataLogic_cmdPush_payload_id = io_input_ar_fork_io_outputs_1_payload_id;
  assign dataLogic_cmdPush_ready = dataLogic_cmdPush_fifo_io_push_ready;
  assign dataLogic_byteCounterNext = ({1'b0,dataLogic_byteCounter} + _zz_14);
  assign _zz_1 = (! dataLogic_busy);
  assign io_input_r_valid = (io_output_r_valid && dataLogic_busy);
  assign io_input_r_payload_last = (io_output_r_payload_last && (dataLogic_byteCounter == dataLogic_byteCounterLast));
  assign io_input_r_payload_resp = io_output_r_payload_resp;
  assign io_input_r_payload_data = _zz_3;
  assign io_input_r_payload_id = dataLogic_id;
  assign io_output_r_ready = ((dataLogic_busy && io_input_r_ready) && (io_input_r_payload_last || dataLogic_byteCounterNext[5]));
  assign _zz_2 = 1'b0;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      dataLogic_busy <= 1'b0;
    end else begin
      if(_zz_4)begin
        dataLogic_busy <= 1'b1;
      end
      if(_zz_5)begin
        if(io_input_r_payload_last)begin
          dataLogic_busy <= 1'b0;
        end
      end
    end
  end

  always @ (posedge clk) begin
    if(_zz_4)begin
      dataLogic_byteCounter <= dataLogic_cmdPush_fifo_io_pop_payload_startAt;
      dataLogic_byteCounterLast <= dataLogic_cmdPush_fifo_io_pop_payload_endAt;
      dataLogic_size <= dataLogic_cmdPush_fifo_io_pop_payload_size;
      dataLogic_id <= dataLogic_cmdPush_fifo_io_pop_payload_id;
    end
    if(_zz_5)begin
      dataLogic_byteCounter <= dataLogic_byteCounterNext[4:0];
    end
  end


endmodule

//StreamFork replaced by StreamFork

//StreamFifo replaced by StreamFifo

//StreamFork replaced by StreamFork

//StreamFork replaced by StreamFork

module StreamFifo (
  input               io_push_valid,
  output              io_push_ready,
  input      [4:0]    io_push_payload_startAt,
  input      [4:0]    io_push_payload_endAt,
  input      [2:0]    io_push_payload_size,
  input      [3:0]    io_push_payload_id,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [4:0]    io_pop_payload_startAt,
  output     [4:0]    io_pop_payload_endAt,
  output     [2:0]    io_pop_payload_size,
  output     [3:0]    io_pop_payload_id,
  input               io_flush,
  output     [6:0]    io_occupancy,
  output     [6:0]    io_availability,
  input               clk,
  input               reset
);
  reg        [16:0]   _zz_4;
  wire       [0:0]    _zz_5;
  wire       [5:0]    _zz_6;
  wire       [0:0]    _zz_7;
  wire       [5:0]    _zz_8;
  wire       [5:0]    _zz_9;
  wire                _zz_10;
  wire       [16:0]   _zz_11;
  reg                 _zz_1;
  reg                 logic_pushPtr_willIncrement;
  reg                 logic_pushPtr_willClear;
  reg        [5:0]    logic_pushPtr_valueNext;
  reg        [5:0]    logic_pushPtr_value;
  wire                logic_pushPtr_willOverflowIfInc;
  wire                logic_pushPtr_willOverflow;
  reg                 logic_popPtr_willIncrement;
  reg                 logic_popPtr_willClear;
  reg        [5:0]    logic_popPtr_valueNext;
  reg        [5:0]    logic_popPtr_value;
  wire                logic_popPtr_willOverflowIfInc;
  wire                logic_popPtr_willOverflow;
  wire                logic_ptrMatch;
  reg                 logic_risingOccupancy;
  wire                logic_pushing;
  wire                logic_popping;
  wire                logic_empty;
  wire                logic_full;
  reg                 _zz_2;
  wire       [16:0]   _zz_3;
  wire       [5:0]    logic_ptrDif;
  reg [16:0] logic_ram [0:63];

  assign _zz_5 = logic_pushPtr_willIncrement;
  assign _zz_6 = {5'd0, _zz_5};
  assign _zz_7 = logic_popPtr_willIncrement;
  assign _zz_8 = {5'd0, _zz_7};
  assign _zz_9 = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_10 = 1'b1;
  assign _zz_11 = {io_push_payload_id,{io_push_payload_size,{io_push_payload_endAt,io_push_payload_startAt}}};
  always @ (posedge clk) begin
    if(_zz_10) begin
      _zz_4 <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_pushPtr_value] <= _zz_11;
    end
  end

  always @ (*) begin
    _zz_1 = 1'b0;
    if(logic_pushing)begin
      _zz_1 = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing)begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 6'h3f);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @ (*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_6);
    if(logic_pushPtr_willClear)begin
      logic_pushPtr_valueNext = 6'h0;
    end
  end

  always @ (*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping)begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 6'h3f);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @ (*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_8);
    if(logic_popPtr_willClear)begin
      logic_popPtr_valueNext = 6'h0;
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_2 && (! logic_full))));
  assign _zz_3 = _zz_4;
  assign io_pop_payload_startAt = _zz_3[4 : 0];
  assign io_pop_payload_endAt = _zz_3[9 : 5];
  assign io_pop_payload_size = _zz_3[12 : 10];
  assign io_pop_payload_id = _zz_3[16 : 13];
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_9};
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      logic_pushPtr_value <= 6'h0;
      logic_popPtr_value <= 6'h0;
      logic_risingOccupancy <= 1'b0;
      _zz_2 <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_2 <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if((logic_pushing != logic_popping))begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush)begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

module StreamFork (
  input               io_input_valid,
  output reg          io_input_ready,
  input      [31:0]   io_input_payload_addr,
  input      [3:0]    io_input_payload_id,
  input      [3:0]    io_input_payload_region,
  input      [7:0]    io_input_payload_len,
  input      [2:0]    io_input_payload_size,
  input      [1:0]    io_input_payload_burst,
  input      [0:0]    io_input_payload_lock,
  input      [3:0]    io_input_payload_cache,
  input      [3:0]    io_input_payload_qos,
  input      [2:0]    io_input_payload_prot,
  output              io_outputs_0_valid,
  input               io_outputs_0_ready,
  output     [31:0]   io_outputs_0_payload_addr,
  output     [3:0]    io_outputs_0_payload_id,
  output     [3:0]    io_outputs_0_payload_region,
  output     [7:0]    io_outputs_0_payload_len,
  output     [2:0]    io_outputs_0_payload_size,
  output     [1:0]    io_outputs_0_payload_burst,
  output     [0:0]    io_outputs_0_payload_lock,
  output     [3:0]    io_outputs_0_payload_cache,
  output     [3:0]    io_outputs_0_payload_qos,
  output     [2:0]    io_outputs_0_payload_prot,
  output              io_outputs_1_valid,
  input               io_outputs_1_ready,
  output     [31:0]   io_outputs_1_payload_addr,
  output     [3:0]    io_outputs_1_payload_id,
  output     [3:0]    io_outputs_1_payload_region,
  output     [7:0]    io_outputs_1_payload_len,
  output     [2:0]    io_outputs_1_payload_size,
  output     [1:0]    io_outputs_1_payload_burst,
  output     [0:0]    io_outputs_1_payload_lock,
  output     [3:0]    io_outputs_1_payload_cache,
  output     [3:0]    io_outputs_1_payload_qos,
  output     [2:0]    io_outputs_1_payload_prot,
  input               clk,
  input               reset
);
  reg                 _zz_1;
  reg                 _zz_2;

  always @ (*) begin
    io_input_ready = 1'b1;
    if(((! io_outputs_0_ready) && _zz_1))begin
      io_input_ready = 1'b0;
    end
    if(((! io_outputs_1_ready) && _zz_2))begin
      io_input_ready = 1'b0;
    end
  end

  assign io_outputs_0_valid = (io_input_valid && _zz_1);
  assign io_outputs_0_payload_addr = io_input_payload_addr;
  assign io_outputs_0_payload_id = io_input_payload_id;
  assign io_outputs_0_payload_region = io_input_payload_region;
  assign io_outputs_0_payload_len = io_input_payload_len;
  assign io_outputs_0_payload_size = io_input_payload_size;
  assign io_outputs_0_payload_burst = io_input_payload_burst;
  assign io_outputs_0_payload_lock = io_input_payload_lock;
  assign io_outputs_0_payload_cache = io_input_payload_cache;
  assign io_outputs_0_payload_qos = io_input_payload_qos;
  assign io_outputs_0_payload_prot = io_input_payload_prot;
  assign io_outputs_1_valid = (io_input_valid && _zz_2);
  assign io_outputs_1_payload_addr = io_input_payload_addr;
  assign io_outputs_1_payload_id = io_input_payload_id;
  assign io_outputs_1_payload_region = io_input_payload_region;
  assign io_outputs_1_payload_len = io_input_payload_len;
  assign io_outputs_1_payload_size = io_input_payload_size;
  assign io_outputs_1_payload_burst = io_input_payload_burst;
  assign io_outputs_1_payload_lock = io_input_payload_lock;
  assign io_outputs_1_payload_cache = io_input_payload_cache;
  assign io_outputs_1_payload_qos = io_input_payload_qos;
  assign io_outputs_1_payload_prot = io_input_payload_prot;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      _zz_1 <= 1'b1;
      _zz_2 <= 1'b1;
    end else begin
      if((io_outputs_0_valid && io_outputs_0_ready))begin
        _zz_1 <= 1'b0;
      end
      if((io_outputs_1_valid && io_outputs_1_ready))begin
        _zz_2 <= 1'b0;
      end
      if(io_input_ready)begin
        _zz_1 <= 1'b1;
        _zz_2 <= 1'b1;
      end
    end
  end


endmodule
