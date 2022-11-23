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
#define AUTOTB_TVIN_src "../tv/cdatafile/c.mapchip.autotvin_src.dat"
#define AUTOTB_TVOUT_src "../tv/cdatafile/c.mapchip.autotvout_src.dat"
// wrapc file define:
#define AUTOTB_TVIN_dst "../tv/cdatafile/c.mapchip.autotvin_dst.dat"
#define AUTOTB_TVOUT_dst "../tv/cdatafile/c.mapchip.autotvout_dst.dat"
// wrapc file define:
#define AUTOTB_TVIN_srcin "../tv/cdatafile/c.mapchip.autotvin_srcin.dat"
#define AUTOTB_TVOUT_srcin "../tv/cdatafile/c.mapchip.autotvout_srcin.dat"
// wrapc file define:
#define AUTOTB_TVIN_dstin "../tv/cdatafile/c.mapchip.autotvin_dstin.dat"
#define AUTOTB_TVOUT_dstin "../tv/cdatafile/c.mapchip.autotvout_dstin.dat"
// wrapc file define:
#define AUTOTB_TVIN_dstout "../tv/cdatafile/c.mapchip.autotvin_dstout.dat"
#define AUTOTB_TVOUT_dstout "../tv/cdatafile/c.mapchip.autotvout_dstout.dat"
// wrapc file define:
#define AUTOTB_TVIN_alpha "../tv/cdatafile/c.mapchip.autotvin_alpha.dat"
#define AUTOTB_TVOUT_alpha "../tv/cdatafile/c.mapchip.autotvout_alpha.dat"

#define INTER_TCL "../tv/cdatafile/ref.tcl"

// tvout file define:
#define AUTOTB_TVOUT_PC_src "../tv/rtldatafile/rtl.mapchip.autotvout_src.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_dst "../tv/rtldatafile/rtl.mapchip.autotvout_dst.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_srcin "../tv/rtldatafile/rtl.mapchip.autotvout_srcin.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_dstin "../tv/rtldatafile/rtl.mapchip.autotvout_dstin.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_dstout "../tv/rtldatafile/rtl.mapchip.autotvout_dstout.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_alpha "../tv/rtldatafile/rtl.mapchip.autotvout_alpha.dat"

class INTER_TCL_FILE {
  public:
INTER_TCL_FILE(const char* name) {
  mName = name; 
  src_depth = 0;
  dst_depth = 0;
  srcin_depth = 0;
  dstin_depth = 0;
  dstout_depth = 0;
  alpha_depth = 0;
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
  total_list << "{src " << src_depth << "}\n";
  total_list << "{dst " << dst_depth << "}\n";
  total_list << "{srcin " << srcin_depth << "}\n";
  total_list << "{dstin " << dstin_depth << "}\n";
  total_list << "{dstout " << dstout_depth << "}\n";
  total_list << "{alpha " << alpha_depth << "}\n";
  return total_list.str();
}
void set_num (int num , int* class_num) {
  (*class_num) = (*class_num) > num ? (*class_num) : num;
}
void set_string(std::string list, std::string* class_list) {
  (*class_list) = list;
}
  public:
    int src_depth;
    int dst_depth;
    int srcin_depth;
    int dstin_depth;
    int dstout_depth;
    int alpha_depth;
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
struct __cosim_s1__ { char data[1]; };
extern "C" void mapchip_hw_stub_wrapper(volatile void *, volatile void *, volatile void *, __cosim_s1__*);

extern "C" void apatb_mapchip_hw(volatile void * __xlx_apatb_param_srcin, volatile void * __xlx_apatb_param_dstin, volatile void * __xlx_apatb_param_dstout, __cosim_s1__* __xlx_apatb_param_alpha) {
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
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_dst);
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
          std::vector<sc_bv<32> > dst_pc_buffer(614400);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "dst");
  
            // push token into output port buffer
            if (AESL_token != "") {
              dst_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {{
            int i = 0;
            for (int j = 0, e = 307200; j < e; j += 1, ++i) {
            ((int*)__xlx_apatb_param_dstin)[j] = dst_pc_buffer[i].to_int64();
          }
            for (int j = 0, e = 307200; j < e; j += 1, ++i) {
            ((int*)__xlx_apatb_param_dstout)[j] = dst_pc_buffer[i].to_int64();
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
//src
aesl_fh.touch(AUTOTB_TVIN_src);
aesl_fh.touch(AUTOTB_TVOUT_src);
//dst
aesl_fh.touch(AUTOTB_TVIN_dst);
aesl_fh.touch(AUTOTB_TVOUT_dst);
//srcin
aesl_fh.touch(AUTOTB_TVIN_srcin);
aesl_fh.touch(AUTOTB_TVOUT_srcin);
//dstin
aesl_fh.touch(AUTOTB_TVIN_dstin);
aesl_fh.touch(AUTOTB_TVOUT_dstin);
//dstout
aesl_fh.touch(AUTOTB_TVIN_dstout);
aesl_fh.touch(AUTOTB_TVOUT_dstout);
//alpha
aesl_fh.touch(AUTOTB_TVIN_alpha);
aesl_fh.touch(AUTOTB_TVOUT_alpha);
CodeState = DUMP_INPUTS;
unsigned __xlx_offset_byte_param_srcin = 0;
// print src Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_src, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_srcin = 0*4;
  if (__xlx_apatb_param_srcin) {
    for (int j = 0  - 0, e = 307200 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_srcin)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_src, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(307200, &tcl_file.src_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_src, __xlx_sprintf_buffer.data());
}
unsigned __xlx_offset_byte_param_dstin = 0;
unsigned __xlx_offset_byte_param_dstout = 0;
// print dst Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_dst, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_dstin = 0*4;
  if (__xlx_apatb_param_dstin) {
    for (int j = 0  - 0, e = 307200 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_dstin)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_dst, __xlx_sprintf_buffer.data()); 
      }
  }
  __xlx_offset_byte_param_dstout = 307200*4;
  if (__xlx_apatb_param_dstout) {
    for (int j = 0  - 0, e = 307200 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_dstout)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_dst, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(614400, &tcl_file.dst_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_dst, __xlx_sprintf_buffer.data());
}
// print srcin Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_srcin, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_srcin;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_srcin, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.srcin_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_srcin, __xlx_sprintf_buffer.data());
}
// print dstin Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_dstin, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_dstin;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_dstin, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.dstin_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_dstin, __xlx_sprintf_buffer.data());
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
// print alpha Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_alpha, __xlx_sprintf_buffer.data());
  {
    sc_bv<8> __xlx_tmp_lv = *((char*)__xlx_apatb_param_alpha);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_alpha, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.alpha_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_alpha, __xlx_sprintf_buffer.data());
}
CodeState = CALL_C_DUT;
mapchip_hw_stub_wrapper(__xlx_apatb_param_srcin, __xlx_apatb_param_dstin, __xlx_apatb_param_dstout, __xlx_apatb_param_alpha);
CodeState = DUMP_OUTPUTS;
// print dst Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_dst, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_dstin = 0*4;
  if (__xlx_apatb_param_dstin) {
    for (int j = 0  - 0, e = 307200 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_dstin)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_dst, __xlx_sprintf_buffer.data()); 
      }
  }
  __xlx_offset_byte_param_dstout = 307200*4;
  if (__xlx_apatb_param_dstout) {
    for (int j = 0  - 0, e = 307200 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_dstout)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_dst, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(614400, &tcl_file.dst_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_dst, __xlx_sprintf_buffer.data());
}
CodeState = DELETE_CHAR_BUFFERS;
AESL_transaction++;
tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
}
