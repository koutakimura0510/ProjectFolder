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
#define AUTOTB_TVIN_onoff "../tv/cdatafile/c.led_blink.autotvin_onoff.dat"
#define AUTOTB_TVOUT_onoff "../tv/cdatafile/c.led_blink.autotvout_onoff.dat"
// wrapc file define:
#define AUTOTB_TVIN_onoff_offset "../tv/cdatafile/c.led_blink.autotvin_onoff_offset.dat"
#define AUTOTB_TVOUT_onoff_offset "../tv/cdatafile/c.led_blink.autotvout_onoff_offset.dat"
// wrapc file define:
#define AUTOTB_TVIN_led "../tv/cdatafile/c.led_blink.autotvin_led.dat"
#define AUTOTB_TVOUT_led "../tv/cdatafile/c.led_blink.autotvout_led.dat"

#define INTER_TCL "../tv/cdatafile/ref.tcl"

// tvout file define:
#define AUTOTB_TVOUT_PC_onoff "../tv/rtldatafile/rtl.led_blink.autotvout_onoff.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_onoff_offset "../tv/rtldatafile/rtl.led_blink.autotvout_onoff_offset.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_led "../tv/rtldatafile/rtl.led_blink.autotvout_led.dat"

class INTER_TCL_FILE {
  public:
INTER_TCL_FILE(const char* name) {
  mName = name; 
  onoff_depth = 0;
  onoff_offset_depth = 0;
  led_depth = 0;
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
  total_list << "{onoff " << onoff_depth << "}\n";
  total_list << "{onoff_offset " << onoff_offset_depth << "}\n";
  total_list << "{led " << led_depth << "}\n";
  return total_list.str();
}
void set_num (int num , int* class_num) {
  (*class_num) = (*class_num) > num ? (*class_num) : num;
}
void set_string(std::string list, std::string* class_list) {
  (*class_list) = list;
}
  public:
    int onoff_depth;
    int onoff_offset_depth;
    int led_depth;
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
extern "C" void led_blink_hw_stub_wrapper(volatile void *, volatile void *);

extern "C" void apatb_led_blink_hw(volatile void * __xlx_apatb_param_onoff, volatile void * __xlx_apatb_param_led) {
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
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_led);
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
          std::vector<sc_bv<4> > led_pc_buffer(1);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "led");
  
            // push token into output port buffer
            if (AESL_token != "") {
              led_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {
            ((char*)__xlx_apatb_param_led)[0] = led_pc_buffer[0].to_int64();
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
//onoff
aesl_fh.touch(AUTOTB_TVIN_onoff);
aesl_fh.touch(AUTOTB_TVOUT_onoff);
//onoff_offset
aesl_fh.touch(AUTOTB_TVIN_onoff_offset);
aesl_fh.touch(AUTOTB_TVOUT_onoff_offset);
//led
aesl_fh.touch(AUTOTB_TVIN_led);
aesl_fh.touch(AUTOTB_TVOUT_led);
CodeState = DUMP_INPUTS;
unsigned __xlx_offset_byte_param_onoff = 0;
// print onoff Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_onoff, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_onoff = 0*1;
  if (__xlx_apatb_param_onoff) {
    for (int j = 0  - 0, e = 1 - 0; j != e; ++j) {
sc_bv<8> __xlx_tmp_lv = ((char*)__xlx_apatb_param_onoff)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_onoff, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(1, &tcl_file.onoff_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_onoff, __xlx_sprintf_buffer.data());
}
// print onoff_offset Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_onoff_offset, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = __xlx_offset_byte_param_onoff;

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_onoff_offset, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.onoff_offset_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_onoff_offset, __xlx_sprintf_buffer.data());
}
// print led Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_led, __xlx_sprintf_buffer.data());
  {
    sc_bv<4> __xlx_tmp_lv = *((char*)__xlx_apatb_param_led);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_led, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.led_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_led, __xlx_sprintf_buffer.data());
}
CodeState = CALL_C_DUT;
led_blink_hw_stub_wrapper(__xlx_apatb_param_onoff, __xlx_apatb_param_led);
CodeState = DUMP_OUTPUTS;
// print led Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_led, __xlx_sprintf_buffer.data());
  {
    sc_bv<4> __xlx_tmp_lv = *((char*)__xlx_apatb_param_led);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_led, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.led_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_led, __xlx_sprintf_buffer.data());
}
CodeState = DELETE_CHAR_BUFFERS;
AESL_transaction++;
tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
}
