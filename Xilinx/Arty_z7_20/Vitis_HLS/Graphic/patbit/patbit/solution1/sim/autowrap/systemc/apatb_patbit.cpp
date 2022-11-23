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
#define AUTOTB_TVIN_gmem "../tv/cdatafile/c.patbit.autotvin_gmem.dat"
#define AUTOTB_TVOUT_gmem "../tv/cdatafile/c.patbit.autotvout_gmem.dat"
// wrapc file define:
#define AUTOTB_TVIN_dstout "../tv/cdatafile/c.patbit.autotvin_dstout.dat"
#define AUTOTB_TVOUT_dstout "../tv/cdatafile/c.patbit.autotvout_dstout.dat"
// wrapc file define:
#define AUTOTB_TVIN_xpos "../tv/cdatafile/c.patbit.autotvin_xpos.dat"
#define AUTOTB_TVOUT_xpos "../tv/cdatafile/c.patbit.autotvout_xpos.dat"
// wrapc file define:
#define AUTOTB_TVIN_ypos "../tv/cdatafile/c.patbit.autotvin_ypos.dat"
#define AUTOTB_TVOUT_ypos "../tv/cdatafile/c.patbit.autotvout_ypos.dat"
// wrapc file define:
#define AUTOTB_TVIN_width "../tv/cdatafile/c.patbit.autotvin_width.dat"
#define AUTOTB_TVOUT_width "../tv/cdatafile/c.patbit.autotvout_width.dat"
// wrapc file define:
#define AUTOTB_TVIN_height "../tv/cdatafile/c.patbit.autotvin_height.dat"
#define AUTOTB_TVOUT_height "../tv/cdatafile/c.patbit.autotvout_height.dat"
// wrapc file define:
#define AUTOTB_TVIN_color "../tv/cdatafile/c.patbit.autotvin_color.dat"
#define AUTOTB_TVOUT_color "../tv/cdatafile/c.patbit.autotvout_color.dat"

#define INTER_TCL "../tv/cdatafile/ref.tcl"

// tvout file define:
#define AUTOTB_TVOUT_PC_gmem "../tv/rtldatafile/rtl.patbit.autotvout_gmem.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_dstout "../tv/rtldatafile/rtl.patbit.autotvout_dstout.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_xpos "../tv/rtldatafile/rtl.patbit.autotvout_xpos.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_ypos "../tv/rtldatafile/rtl.patbit.autotvout_ypos.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_width "../tv/rtldatafile/rtl.patbit.autotvout_width.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_height "../tv/rtldatafile/rtl.patbit.autotvout_height.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_color "../tv/rtldatafile/rtl.patbit.autotvout_color.dat"

class INTER_TCL_FILE {
  public:
INTER_TCL_FILE(const char* name) {
  mName = name; 
  gmem_depth = 0;
  dstout_depth = 0;
  xpos_depth = 0;
  ypos_depth = 0;
  width_depth = 0;
  height_depth = 0;
  color_depth = 0;
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
  total_list << "{gmem " << gmem_depth << "}\n";
  total_list << "{dstout " << dstout_depth << "}\n";
  total_list << "{xpos " << xpos_depth << "}\n";
  total_list << "{ypos " << ypos_depth << "}\n";
  total_list << "{width " << width_depth << "}\n";
  total_list << "{height " << height_depth << "}\n";
  total_list << "{color " << color_depth << "}\n";
  return total_list.str();
}
void set_num (int num , int* class_num) {
  (*class_num) = (*class_num) > num ? (*class_num) : num;
}
void set_string(std::string list, std::string* class_list) {
  (*class_list) = list;
}
  public:
    int gmem_depth;
    int dstout_depth;
    int xpos_depth;
    int ypos_depth;
    int width_depth;
    int height_depth;
    int color_depth;
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
struct __cosim_s2__ { char data[2]; };
struct __cosim_s4__ { char data[4]; };
extern "C" void patbit_hw_stub_wrapper(volatile void *, __cosim_s2__*, __cosim_s2__*, __cosim_s2__*, __cosim_s2__*, __cosim_s4__*);

extern "C" void apatb_patbit_hw(volatile void * __xlx_apatb_param_dstout, __cosim_s2__* __xlx_apatb_param_xpos, __cosim_s2__* __xlx_apatb_param_ypos, __cosim_s2__* __xlx_apatb_param_width, __cosim_s2__* __xlx_apatb_param_height, __cosim_s4__* __xlx_apatb_param_color) {
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
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_gmem);
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
          std::vector<sc_bv<32> > gmem_pc_buffer(307200);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "gmem");
  
            // push token into output port buffer
            if (AESL_token != "") {
              gmem_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {{
            int i = 0;
            for (int j = 0, e = 307200; j < e; j += 1, ++i) {
            ((int*)__xlx_apatb_param_dstout)[j] = gmem_pc_buffer[i].to_int64();
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
//gmem
aesl_fh.touch(AUTOTB_TVIN_gmem);
aesl_fh.touch(AUTOTB_TVOUT_gmem);
//dstout
aesl_fh.touch(AUTOTB_TVIN_dstout);
aesl_fh.touch(AUTOTB_TVOUT_dstout);
//xpos
aesl_fh.touch(AUTOTB_TVIN_xpos);
aesl_fh.touch(AUTOTB_TVOUT_xpos);
//ypos
aesl_fh.touch(AUTOTB_TVIN_ypos);
aesl_fh.touch(AUTOTB_TVOUT_ypos);
//width
aesl_fh.touch(AUTOTB_TVIN_width);
aesl_fh.touch(AUTOTB_TVOUT_width);
//height
aesl_fh.touch(AUTOTB_TVIN_height);
aesl_fh.touch(AUTOTB_TVOUT_height);
//color
aesl_fh.touch(AUTOTB_TVIN_color);
aesl_fh.touch(AUTOTB_TVOUT_color);
CodeState = DUMP_INPUTS;
unsigned __xlx_offset_byte_param_dstout = 0;
// print gmem Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_gmem, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_dstout = 0*4;
  if (__xlx_apatb_param_dstout) {
    for (int j = 0  - 0, e = 307200 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_dstout)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_gmem, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(307200, &tcl_file.gmem_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_gmem, __xlx_sprintf_buffer.data());
}
// print dstout Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_dstout, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_dstout;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_dstout, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.dstout_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_dstout, __xlx_sprintf_buffer.data());
}
// print xpos Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_xpos, __xlx_sprintf_buffer.data());
  {
    sc_bv<11> __xlx_tmp_lv = *((short*)__xlx_apatb_param_xpos);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_xpos, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.xpos_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_xpos, __xlx_sprintf_buffer.data());
}
// print ypos Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_ypos, __xlx_sprintf_buffer.data());
  {
    sc_bv<11> __xlx_tmp_lv = *((short*)__xlx_apatb_param_ypos);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_ypos, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.ypos_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_ypos, __xlx_sprintf_buffer.data());
}
// print width Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_width, __xlx_sprintf_buffer.data());
  {
    sc_bv<11> __xlx_tmp_lv = *((short*)__xlx_apatb_param_width);

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
    sc_bv<11> __xlx_tmp_lv = *((short*)__xlx_apatb_param_height);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_height, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.height_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_height, __xlx_sprintf_buffer.data());
}
// print color Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_color, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_color);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_color, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.color_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_color, __xlx_sprintf_buffer.data());
}
CodeState = CALL_C_DUT;
patbit_hw_stub_wrapper(__xlx_apatb_param_dstout, __xlx_apatb_param_xpos, __xlx_apatb_param_ypos, __xlx_apatb_param_width, __xlx_apatb_param_height, __xlx_apatb_param_color);
CodeState = DUMP_OUTPUTS;
// print gmem Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_gmem, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_dstout = 0*4;
  if (__xlx_apatb_param_dstout) {
    for (int j = 0  - 0, e = 307200 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_dstout)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_gmem, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(307200, &tcl_file.gmem_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_gmem, __xlx_sprintf_buffer.data());
}
CodeState = DELETE_CHAR_BUFFERS;
AESL_transaction++;
tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
}
