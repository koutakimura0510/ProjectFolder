#include <systemc>
#include <iostream>
#include <cstdlib>
#include <cstddef>
#include <stdint.h>
#include "SysCFileHandler.h"
#include "ap_int.h"
#include "ap_fixed.h"
#include <complex>
#include <stdbool.h>
#include "autopilot_cbe.h"
#include "hls_stream.h"
#include "hls_half.h"
#include "hls_signal_handler.h"

using namespace std;
using namespace sc_core;
using namespace sc_dt;

// wrapc file define:
#define AUTOTB_TVIN_copy "../tv/cdatafile/c.background_loop.autotvin_copy.dat"
#define AUTOTB_TVOUT_copy "../tv/cdatafile/c.background_loop.autotvout_copy.dat"
// wrapc file define:
#define AUTOTB_TVIN_update "../tv/cdatafile/c.background_loop.autotvin_update.dat"
#define AUTOTB_TVOUT_update "../tv/cdatafile/c.background_loop.autotvout_update.dat"
// wrapc file define:
#define AUTOTB_TVIN_ddr_copy "../tv/cdatafile/c.background_loop.autotvin_ddr_copy.dat"
#define AUTOTB_TVOUT_ddr_copy "../tv/cdatafile/c.background_loop.autotvout_ddr_copy.dat"
// wrapc file define:
#define AUTOTB_TVIN_ddr_update "../tv/cdatafile/c.background_loop.autotvin_ddr_update.dat"
#define AUTOTB_TVOUT_ddr_update "../tv/cdatafile/c.background_loop.autotvout_ddr_update.dat"
// wrapc file define:
#define AUTOTB_TVIN_width "../tv/cdatafile/c.background_loop.autotvin_width.dat"
#define AUTOTB_TVOUT_width "../tv/cdatafile/c.background_loop.autotvout_width.dat"
// wrapc file define:
#define AUTOTB_TVIN_height "../tv/cdatafile/c.background_loop.autotvin_height.dat"
#define AUTOTB_TVOUT_height "../tv/cdatafile/c.background_loop.autotvout_height.dat"
// wrapc file define:
#define AUTOTB_TVIN_frame_size "../tv/cdatafile/c.background_loop.autotvin_frame_size.dat"
#define AUTOTB_TVOUT_frame_size "../tv/cdatafile/c.background_loop.autotvout_frame_size.dat"
// wrapc file define:
#define AUTOTB_TVIN_direction "../tv/cdatafile/c.background_loop.autotvin_direction.dat"
#define AUTOTB_TVOUT_direction "../tv/cdatafile/c.background_loop.autotvout_direction.dat"

#define INTER_TCL "../tv/cdatafile/ref.tcl"

// tvout file define:
#define AUTOTB_TVOUT_PC_copy "../tv/rtldatafile/rtl.background_loop.autotvout_copy.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_update "../tv/rtldatafile/rtl.background_loop.autotvout_update.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_ddr_copy "../tv/rtldatafile/rtl.background_loop.autotvout_ddr_copy.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_ddr_update "../tv/rtldatafile/rtl.background_loop.autotvout_ddr_update.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_width "../tv/rtldatafile/rtl.background_loop.autotvout_width.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_height "../tv/rtldatafile/rtl.background_loop.autotvout_height.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_frame_size "../tv/rtldatafile/rtl.background_loop.autotvout_frame_size.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_direction "../tv/rtldatafile/rtl.background_loop.autotvout_direction.dat"

class INTER_TCL_FILE {
  public:
INTER_TCL_FILE(const char* name) {
  mName = name; 
  copy_depth = 0;
  update_depth = 0;
  ddr_copy_depth = 0;
  ddr_update_depth = 0;
  width_depth = 0;
  height_depth = 0;
  frame_size_depth = 0;
  direction_depth = 0;
  trans_num =0;
}
~INTER_TCL_FILE() {
  mFile.open(mName);
  if (!mFile.good()) {
    cout << "Failed to open file ref.tcl" << endl;
    exit (1); 
  }
  string total_list = get_depth_list();
  mFile << "set depth_list {\n";
  mFile << total_list;
  mFile << "}\n";
  mFile << "set trans_num "<<trans_num<<endl;
  mFile.close();
}
string get_depth_list () {
  stringstream total_list;
  total_list << "{copy " << copy_depth << "}\n";
  total_list << "{update " << update_depth << "}\n";
  total_list << "{ddr_copy " << ddr_copy_depth << "}\n";
  total_list << "{ddr_update " << ddr_update_depth << "}\n";
  total_list << "{width " << width_depth << "}\n";
  total_list << "{height " << height_depth << "}\n";
  total_list << "{frame_size " << frame_size_depth << "}\n";
  total_list << "{direction " << direction_depth << "}\n";
  return total_list.str();
}
void set_num (int num , int* class_num) {
  (*class_num) = (*class_num) > num ? (*class_num) : num;
}
void set_string(std::string list, std::string* class_list) {
  (*class_list) = list;
}
  public:
    int copy_depth;
    int update_depth;
    int ddr_copy_depth;
    int ddr_update_depth;
    int width_depth;
    int height_depth;
    int frame_size_depth;
    int direction_depth;
    int trans_num;
  private:
    ofstream mFile;
    const char* mName;
};

static void RTLOutputCheckAndReplacement(std::string &AESL_token, std::string PortName) {
  bool no_x = false;
  bool err = false;

  no_x = false;
  // search and replace 'X' with '0' from the 3rd char of token
  while (!no_x) {
    size_t x_found = AESL_token.find('X', 0);
    if (x_found != string::npos) {
      if (!err) { 
        cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'X' on port" 
             << PortName << ", possible cause: There are uninitialized variables in the C design."
             << endl; 
        err = true;
      }
      AESL_token.replace(x_found, 1, "0");
    } else
      no_x = true;
  }
  no_x = false;
  // search and replace 'x' with '0' from the 3rd char of token
  while (!no_x) {
    size_t x_found = AESL_token.find('x', 2);
    if (x_found != string::npos) {
      if (!err) { 
        cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'x' on port" 
             << PortName << ", possible cause: There are uninitialized variables in the C design."
             << endl; 
        err = true;
      }
      AESL_token.replace(x_found, 1, "0");
    } else
      no_x = true;
  }
}
struct __cosim_s4__ { char data[4]; };
extern "C" void background_loop_hw_stub_wrapper(volatile void *, volatile void *, __cosim_s4__*, __cosim_s4__*, __cosim_s4__*, __cosim_s4__*);

extern "C" void apatb_background_loop_hw(volatile void * __xlx_apatb_param_ddr_copy, volatile void * __xlx_apatb_param_ddr_update, __cosim_s4__* __xlx_apatb_param_width, __cosim_s4__* __xlx_apatb_param_height, __cosim_s4__* __xlx_apatb_param_frame_size, __cosim_s4__* __xlx_apatb_param_direction) {
  refine_signal_handler();
  fstream wrapc_switch_file_token;
  wrapc_switch_file_token.open(".hls_cosim_wrapc_switch.log");
  int AESL_i;
  if (wrapc_switch_file_token.good())
  {

    CodeState = ENTER_WRAPC_PC;
    static unsigned AESL_transaction_pc = 0;
    string AESL_token;
    string AESL_num;{
      static ifstream rtl_tv_out_file;
      if (!rtl_tv_out_file.is_open()) {
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_update);
        if (rtl_tv_out_file.good()) {
          rtl_tv_out_file >> AESL_token;
          if (AESL_token != "[[[runtime]]]")
            exit(1);
        }
      }
  
      if (rtl_tv_out_file.good()) {
        rtl_tv_out_file >> AESL_token; 
        rtl_tv_out_file >> AESL_num;  // transaction number
        if (AESL_token != "[[transaction]]") {
          cerr << "Unexpected token: " << AESL_token << endl;
          exit(1);
        }
        if (atoi(AESL_num.c_str()) == AESL_transaction_pc) {
          std::vector<sc_bv<32> > update_pc_buffer(307200);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "update");
  
            // push token into output port buffer
            if (AESL_token != "") {
              update_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {{
            int i = 0;
            for (int j = 0, e = 307200; j < e; j += 1, ++i) {
            ((int*)__xlx_apatb_param_ddr_update)[j] = update_pc_buffer[i].to_int64();
          }}}
        } // end transaction
      } // end file is good
    } // end post check logic bolck
  
    AESL_transaction_pc++;
    return ;
  }
static unsigned AESL_transaction;
static AESL_FILE_HANDLER aesl_fh;
static INTER_TCL_FILE tcl_file(INTER_TCL);
std::vector<char> __xlx_sprintf_buffer(1024);
CodeState = ENTER_WRAPC;
//copy
aesl_fh.touch(AUTOTB_TVIN_copy);
aesl_fh.touch(AUTOTB_TVOUT_copy);
//update
aesl_fh.touch(AUTOTB_TVIN_update);
aesl_fh.touch(AUTOTB_TVOUT_update);
//ddr_copy
aesl_fh.touch(AUTOTB_TVIN_ddr_copy);
aesl_fh.touch(AUTOTB_TVOUT_ddr_copy);
//ddr_update
aesl_fh.touch(AUTOTB_TVIN_ddr_update);
aesl_fh.touch(AUTOTB_TVOUT_ddr_update);
//width
aesl_fh.touch(AUTOTB_TVIN_width);
aesl_fh.touch(AUTOTB_TVOUT_width);
//height
aesl_fh.touch(AUTOTB_TVIN_height);
aesl_fh.touch(AUTOTB_TVOUT_height);
//frame_size
aesl_fh.touch(AUTOTB_TVIN_frame_size);
aesl_fh.touch(AUTOTB_TVOUT_frame_size);
//direction
aesl_fh.touch(AUTOTB_TVIN_direction);
aesl_fh.touch(AUTOTB_TVOUT_direction);
CodeState = DUMP_INPUTS;
unsigned __xlx_offset_byte_param_ddr_copy = 0;
// print copy Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_copy, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_ddr_copy = 0*4;
  if (__xlx_apatb_param_ddr_copy) {
    for (int j = 0  - 0, e = 307200 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_ddr_copy)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_copy, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(307200, &tcl_file.copy_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_copy, __xlx_sprintf_buffer.data());
}
unsigned __xlx_offset_byte_param_ddr_update = 0;
// print update Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_update, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_ddr_update = 0*4;
  if (__xlx_apatb_param_ddr_update) {
    for (int j = 0  - 0, e = 307200 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_ddr_update)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_update, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(307200, &tcl_file.update_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_update, __xlx_sprintf_buffer.data());
}
// print ddr_copy Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_ddr_copy, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_ddr_copy;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_ddr_copy, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.ddr_copy_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_ddr_copy, __xlx_sprintf_buffer.data());
}
// print ddr_update Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_ddr_update, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_ddr_update;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_ddr_update, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.ddr_update_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_ddr_update, __xlx_sprintf_buffer.data());
}
// print width Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_width, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_width);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_width, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.width_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_width, __xlx_sprintf_buffer.data());
}
// print height Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_height, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_height);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_height, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.height_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_height, __xlx_sprintf_buffer.data());
}
// print frame_size Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_frame_size, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_frame_size);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_frame_size, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.frame_size_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_frame_size, __xlx_sprintf_buffer.data());
}
// print direction Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_direction, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_direction);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_direction, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.direction_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_direction, __xlx_sprintf_buffer.data());
}
CodeState = CALL_C_DUT;
background_loop_hw_stub_wrapper(__xlx_apatb_param_ddr_copy, __xlx_apatb_param_ddr_update, __xlx_apatb_param_width, __xlx_apatb_param_height, __xlx_apatb_param_frame_size, __xlx_apatb_param_direction);
CodeState = DUMP_OUTPUTS;
// print update Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_update, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_ddr_update = 0*4;
  if (__xlx_apatb_param_ddr_update) {
    for (int j = 0  - 0, e = 307200 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_ddr_update)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_update, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(307200, &tcl_file.update_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_update, __xlx_sprintf_buffer.data());
}
CodeState = DELETE_CHAR_BUFFERS;
AESL_transaction++;
tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
}
