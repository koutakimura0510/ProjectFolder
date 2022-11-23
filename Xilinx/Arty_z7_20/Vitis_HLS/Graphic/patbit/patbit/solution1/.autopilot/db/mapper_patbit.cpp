#include <systemc>
#include <vector>
#include <iostream>
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_fixed.h"
using namespace std;
using namespace sc_dt;
class AESL_RUNTIME_BC {
  public:
    AESL_RUNTIME_BC(const char* name) {
      file_token.open( name);
      if (!file_token.good()) {
        cout << "Failed to open tv file " << name << endl;
        exit (1);
      }
      file_token >> mName;//[[[runtime]]]
    }
    ~AESL_RUNTIME_BC() {
      file_token.close();
    }
    int read_size () {
      int size = 0;
      file_token >> mName;//[[transaction]]
      file_token >> mName;//transaction number
      file_token >> mName;//pop_size
      size = atoi(mName.c_str());
      file_token >> mName;//[[/transaction]]
      return size;
    }
  public:
    fstream file_token;
    string mName;
};
struct __cosim_s2__ { char data[2]; };
struct __cosim_s4__ { char data[4]; };
extern "C" void patbit(int*, int, __cosim_s2__, __cosim_s2__, __cosim_s2__, __cosim_s2__, __cosim_s4__);
extern "C" void apatb_patbit_hw(volatile void * __xlx_apatb_param_dstout, __cosim_s2__ __xlx_apatb_param_xpos, __cosim_s2__ __xlx_apatb_param_ypos, __cosim_s2__ __xlx_apatb_param_width, __cosim_s2__ __xlx_apatb_param_height, __cosim_s4__ __xlx_apatb_param_color) {
  // Collect __xlx_dstout__tmp_vec
  vector<sc_bv<32> >__xlx_dstout__tmp_vec;
  for (int j = 0, e = 307200; j != e; ++j) {
    __xlx_dstout__tmp_vec.push_back(((int*)__xlx_apatb_param_dstout)[j]);
  }
  int __xlx_size_param_dstout = 307200;
  int __xlx_offset_param_dstout = 0;
  int __xlx_offset_byte_param_dstout = 0*4;
  int* __xlx_dstout__input_buffer= new int[__xlx_dstout__tmp_vec.size()];
  for (int i = 0; i < __xlx_dstout__tmp_vec.size(); ++i) {
    __xlx_dstout__input_buffer[i] = __xlx_dstout__tmp_vec[i].range(31, 0).to_uint64();
  }
  // DUT call
  patbit(__xlx_dstout__input_buffer, __xlx_offset_byte_param_dstout, __xlx_apatb_param_xpos, __xlx_apatb_param_ypos, __xlx_apatb_param_width, __xlx_apatb_param_height, __xlx_apatb_param_color);
// print __xlx_apatb_param_dstout
  sc_bv<32>*__xlx_dstout_output_buffer = new sc_bv<32>[__xlx_size_param_dstout];
  for (int i = 0; i < __xlx_size_param_dstout; ++i) {
    __xlx_dstout_output_buffer[i] = __xlx_dstout__input_buffer[i+__xlx_offset_param_dstout];
  }
  for (int i = 0; i < __xlx_size_param_dstout; ++i) {
    ((int*)__xlx_apatb_param_dstout)[i] = __xlx_dstout_output_buffer[i].to_uint64();
  }
}
