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
#define AUTOTB_TVIN_cp "../tv/cdatafile/c.framebuffer_copy.autotvin_cp.dat"
#define AUTOTB_TVOUT_cp "../tv/cdatafile/c.framebuffer_copy.autotvout_cp.dat"
// wrapc file define:
#define AUTOTB_TVIN_up "../tv/cdatafile/c.framebuffer_copy.autotvin_up.dat"
#define AUTOTB_TVOUT_up "../tv/cdatafile/c.framebuffer_copy.autotvout_up.dat"
// wrapc file define:
#define AUTOTB_TVIN_copy "../tv/cdatafile/c.framebuffer_copy.autotvin_copy.dat"
#define AUTOTB_TVOUT_copy "../tv/cdatafile/c.framebuffer_copy.autotvout_copy.dat"
// wrapc file define:
#define AUTOTB_TVIN_update "../tv/cdatafile/c.framebuffer_copy.autotvin_update.dat"
#define AUTOTB_TVOUT_update "../tv/cdatafile/c.framebuffer_copy.autotvout_update.dat"
// wrapc file define:
#define AUTOTB_TVIN_width "../tv/cdatafile/c.framebuffer_copy.autotvin_width.dat"
#define AUTOTB_TVOUT_width "../tv/cdatafile/c.framebuffer_copy.autotvout_width.dat"
// wrapc file define:
#define AUTOTB_TVIN_height "../tv/cdatafile/c.framebuffer_copy.autotvin_height.dat"
#define AUTOTB_TVOUT_height "../tv/cdatafile/c.framebuffer_copy.autotvout_height.dat"
// wrapc file define:
#define AUTOTB_TVIN_display_xsize "../tv/cdatafile/c.framebuffer_copy.autotvin_display_xsize.dat"
#define AUTOTB_TVOUT_display_xsize "../tv/cdatafile/c.framebuffer_copy.autotvout_display_xsize.dat"

#define INTER_TCL "../tv/cdatafile/ref.tcl"

// tvout file define:
#define AUTOTB_TVOUT_PC_cp "../tv/rtldatafile/rtl.framebuffer_copy.autotvout_cp.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_up "../tv/rtldatafile/rtl.framebuffer_copy.autotvout_up.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_copy "../tv/rtldatafile/rtl.framebuffer_copy.autotvout_copy.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_update "../tv/rtldatafile/rtl.framebuffer_copy.autotvout_update.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_width "../tv/rtldatafile/rtl.framebuffer_copy.autotvout_width.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_height "../tv/rtldatafile/rtl.framebuffer_copy.autotvout_height.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_display_xsize "../tv/rtldatafile/rtl.framebuffer_copy.autotvout_display_xsize.dat"

class INTER_TCL_FILE {
  public:
INTER_TCL_FILE(const char* name) {
  mName = name; 
  cp_depth = 0;
  up_depth = 0;
  copy_depth = 0;
  update_depth = 0;
  width_depth = 0;
  height_depth = 0;
  display_xsize_depth = 0;
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
  total_list << "{cp " << cp_depth << "}\n";
  total_list << "{up " << up_depth << "}\n";
  total_list << "{copy " << copy_depth << "}\n";
  total_list << "{update " << update_depth << "}\n";
  total_list << "{width " << width_depth << "}\n";
  total_list << "{height " << height_depth << "}\n";
  total_list << "{display_xsize " << display_xsize_depth << "}\n";
  return total_list.str();
}
void set_num (int num , int* class_num) {
  (*class_num) = (*class_num) > num ? (*class_num) : num;
}
void set_string(std::string list, std::string* class_list) {
  (*class_list) = list;
}
  public:
    int cp_depth;
    int up_depth;
    int copy_depth;
    int update_depth;
    int width_depth;
    int height_depth;
    int display_xsize_depth;
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
extern "C" void framebuffer_copy_hw_stub_wrapper(volatile void *, volatile void *, __cosim_s4__*, __cosim_s4__*, __cosim_s4__*);

extern "C" void apatb_framebuffer_copy_hw(volatile void * __xlx_apatb_param_copy, volatile void * __xlx_apatb_param_update, __cosim_s4__* __xlx_apatb_param_width, __cosim_s4__* __xlx_apatb_param_height, __cosim_s4__* __xlx_apatb_param_display_xsize) {
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
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_up);
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
          std::vector<sc_bv<32> > up_pc_buffer(399360);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "up");
  
            // push token into output port buffer
            if (AESL_token != "") {
              up_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {{
            int i = 0;
            for (int j = 0, e = 399360; j < e; j += 1, ++i) {
            ((int*)__xlx_apatb_param_update)[j] = up_pc_buffer[i].to_int64();
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
//cp
aesl_fh.touch(AUTOTB_TVIN_cp);
aesl_fh.touch(AUTOTB_TVOUT_cp);
//up
aesl_fh.touch(AUTOTB_TVIN_up);
aesl_fh.touch(AUTOTB_TVOUT_up);
//copy
aesl_fh.touch(AUTOTB_TVIN_copy);
aesl_fh.touch(AUTOTB_TVOUT_copy);
//update
aesl_fh.touch(AUTOTB_TVIN_update);
aesl_fh.touch(AUTOTB_TVOUT_update);
//width
aesl_fh.touch(AUTOTB_TVIN_width);
aesl_fh.touch(AUTOTB_TVOUT_width);
//height
aesl_fh.touch(AUTOTB_TVIN_height);
aesl_fh.touch(AUTOTB_TVOUT_height);
//display_xsize
aesl_fh.touch(AUTOTB_TVIN_display_xsize);
aesl_fh.touch(AUTOTB_TVOUT_display_xsize);
CodeState = DUMP_INPUTS;
unsigned __xlx_offset_byte_param_copy = 0;
// print cp Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_cp, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_copy = 0*4;
  if (__xlx_apatb_param_copy) {
    for (int j = 0  - 0, e = 399360 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_copy)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_cp, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(399360, &tcl_file.cp_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_cp, __xlx_sprintf_buffer.data());
}
unsigned __xlx_offset_byte_param_update = 0;
// print up Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_up, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_update = 0*4;
  if (__xlx_apatb_param_update) {
    for (int j = 0  - 0, e = 399360 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_update)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_up, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(399360, &tcl_file.up_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_up, __xlx_sprintf_buffer.data());
}
// print copy Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_copy, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_copy;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_copy, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.copy_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_copy, __xlx_sprintf_buffer.data());
}
// print update Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_update, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_update;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_update, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.update_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_update, __xlx_sprintf_buffer.data());
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
// print display_xsize Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_display_xsize, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_display_xsize);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_display_xsize, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.display_xsize_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_display_xsize, __xlx_sprintf_buffer.data());
}
CodeState = CALL_C_DUT;
framebuffer_copy_hw_stub_wrapper(__xlx_apatb_param_copy, __xlx_apatb_param_update, __xlx_apatb_param_width, __xlx_apatb_param_height, __xlx_apatb_param_display_xsize);
CodeState = DUMP_OUTPUTS;
// print up Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_up, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_update = 0*4;
  if (__xlx_apatb_param_update) {
    for (int j = 0  - 0, e = 399360 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_update)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_up, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(399360, &tcl_file.up_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_up, __xlx_sprintf_buffer.data());
}
CodeState = DELETE_CHAR_BUFFERS;
AESL_transaction++;
tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
}
