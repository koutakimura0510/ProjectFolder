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
#define AUTOTB_TVIN_ram "../tv/cdatafile/c.sound_operation.autotvin_ram.dat"
#define AUTOTB_TVOUT_ram "../tv/cdatafile/c.sound_operation.autotvout_ram.dat"
// wrapc file define:
#define AUTOTB_TVIN_ramadr "../tv/cdatafile/c.sound_operation.autotvin_ramadr.dat"
#define AUTOTB_TVOUT_ramadr "../tv/cdatafile/c.sound_operation.autotvout_ramadr.dat"
// wrapc file define:
#define AUTOTB_TVIN_sdata "../tv/cdatafile/c.sound_operation.autotvin_sdata.dat"
#define AUTOTB_TVOUT_sdata "../tv/cdatafile/c.sound_operation.autotvout_sdata.dat"
// wrapc file define:
#define AUTOTB_TVIN_opeout "../tv/cdatafile/c.sound_operation.autotvin_opeout.dat"
#define AUTOTB_TVOUT_opeout "../tv/cdatafile/c.sound_operation.autotvout_opeout.dat"

#define INTER_TCL "../tv/cdatafile/ref.tcl"

// tvout file define:
#define AUTOTB_TVOUT_PC_ram "../tv/rtldatafile/rtl.sound_operation.autotvout_ram.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_ramadr "../tv/rtldatafile/rtl.sound_operation.autotvout_ramadr.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_sdata "../tv/rtldatafile/rtl.sound_operation.autotvout_sdata.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_opeout "../tv/rtldatafile/rtl.sound_operation.autotvout_opeout.dat"

class INTER_TCL_FILE {
  public:
INTER_TCL_FILE(const char* name) {
  mName = name; 
  ram_depth = 0;
  ramadr_depth = 0;
  sdata_depth = 0;
  opeout_depth = 0;
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
  total_list << "{ram " << ram_depth << "}\n";
  total_list << "{ramadr " << ramadr_depth << "}\n";
  total_list << "{sdata " << sdata_depth << "}\n";
  total_list << "{opeout " << opeout_depth << "}\n";
  return total_list.str();
}
void set_num (int num , int* class_num) {
  (*class_num) = (*class_num) > num ? (*class_num) : num;
}
void set_string(std::string list, std::string* class_list) {
  (*class_list) = list;
}
  public:
    int ram_depth;
    int ramadr_depth;
    int sdata_depth;
    int opeout_depth;
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
extern "C" void sound_operation_hw_stub_wrapper(volatile void *, volatile void *, volatile void *);

extern "C" void apatb_sound_operation_hw(volatile void * __xlx_apatb_param_ramadr, volatile void * __xlx_apatb_param_sdata, volatile void * __xlx_apatb_param_opeout) {
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
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_sdata);
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
          std::vector<sc_bv<32> > sdata_pc_buffer(1);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "sdata");
  
            // push token into output port buffer
            if (AESL_token != "") {
              sdata_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {
            ((int*)__xlx_apatb_param_sdata)[0] = sdata_pc_buffer[0].to_int64();
          }
        } // end transaction
      } // end file is good
    } // end post check logic bolck
  {
      static ifstream rtl_tv_out_file;
      if (!rtl_tv_out_file.is_open()) {
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_opeout);
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
          std::vector<sc_bv<32> > opeout_pc_buffer(1);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "opeout");
  
            // push token into output port buffer
            if (AESL_token != "") {
              opeout_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {
            ((int*)__xlx_apatb_param_opeout)[0] = opeout_pc_buffer[0].to_int64();
          }
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
//ram
aesl_fh.touch(AUTOTB_TVIN_ram);
aesl_fh.touch(AUTOTB_TVOUT_ram);
//ramadr
aesl_fh.touch(AUTOTB_TVIN_ramadr);
aesl_fh.touch(AUTOTB_TVOUT_ramadr);
//sdata
aesl_fh.touch(AUTOTB_TVIN_sdata);
aesl_fh.touch(AUTOTB_TVOUT_sdata);
//opeout
aesl_fh.touch(AUTOTB_TVIN_opeout);
aesl_fh.touch(AUTOTB_TVOUT_opeout);
CodeState = DUMP_INPUTS;
unsigned __xlx_offset_byte_param_ramadr = 0;
// print ram Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_ram, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_ramadr = 0*4;
  if (__xlx_apatb_param_ramadr) {
    for (int j = 0  - 0, e = 1 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_ramadr)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_ram, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(1, &tcl_file.ram_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_ram, __xlx_sprintf_buffer.data());
}
// print ramadr Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_ramadr, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_ramadr;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_ramadr, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.ramadr_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_ramadr, __xlx_sprintf_buffer.data());
}
// print sdata Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_sdata, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_sdata);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_sdata, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.sdata_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_sdata, __xlx_sprintf_buffer.data());
}
// print opeout Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_opeout, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_opeout);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_opeout, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.opeout_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_opeout, __xlx_sprintf_buffer.data());
}
CodeState = CALL_C_DUT;
sound_operation_hw_stub_wrapper(__xlx_apatb_param_ramadr, __xlx_apatb_param_sdata, __xlx_apatb_param_opeout);
CodeState = DUMP_OUTPUTS;
// print sdata Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_sdata, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_sdata);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_sdata, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.sdata_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_sdata, __xlx_sprintf_buffer.data());
}
// print opeout Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_opeout, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_opeout);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_opeout, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.opeout_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_opeout, __xlx_sprintf_buffer.data());
}
CodeState = DELETE_CHAR_BUFFERS;
AESL_transaction++;
tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
}
