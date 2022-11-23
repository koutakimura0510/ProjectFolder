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
struct __cosim_s4__ { char data[4]; };
extern "C" void display_shift(int*, int*, int, int, __cosim_s4__, __cosim_s4__, __cosim_s4__, __cosim_s4__, __cosim_s4__, __cosim_s4__, __cosim_s4__);
extern "C" void apatb_display_shift_hw(volatile void * __xlx_apatb_param_ddr_copy, volatile void * __xlx_apatb_param_ddr_update, __cosim_s4__ __xlx_apatb_param_width, __cosim_s4__ __xlx_apatb_param_height, __cosim_s4__ __xlx_apatb_param_xstart, __cosim_s4__ __xlx_apatb_param_xend, __cosim_s4__ __xlx_apatb_param_ystart, __cosim_s4__ __xlx_apatb_param_yend, __cosim_s4__ __xlx_apatb_param_frame_size) {
  // Collect __xlx_ddr_copy__tmp_vec
  vector<sc_bv<32> >__xlx_ddr_copy__tmp_vec;
  for (int j = 0, e = 307200; j != e; ++j) {
    __xlx_ddr_copy__tmp_vec.push_back(((int*)__xlx_apatb_param_ddr_copy)[j]);
  }
  int __xlx_size_param_ddr_copy = 307200;
  int __xlx_offset_param_ddr_copy = 0;
  int __xlx_offset_byte_param_ddr_copy = 0*4;
  int* __xlx_ddr_copy__input_buffer= new int[__xlx_ddr_copy__tmp_vec.size()];
  for (int i = 0; i < __xlx_ddr_copy__tmp_vec.size(); ++i) {
    __xlx_ddr_copy__input_buffer[i] = __xlx_ddr_copy__tmp_vec[i].range(31, 0).to_uint64();
  }
  // Collect __xlx_ddr_update__tmp_vec
  vector<sc_bv<32> >__xlx_ddr_update__tmp_vec;
  for (int j = 0, e = 307200; j != e; ++j) {
    __xlx_ddr_update__tmp_vec.push_back(((int*)__xlx_apatb_param_ddr_update)[j]);
  }
  int __xlx_size_param_ddr_update = 307200;
  int __xlx_offset_param_ddr_update = 0;
  int __xlx_offset_byte_param_ddr_update = 0*4;
  int* __xlx_ddr_update__input_buffer= new int[__xlx_ddr_update__tmp_vec.size()];
  for (int i = 0; i < __xlx_ddr_update__tmp_vec.size(); ++i) {
    __xlx_ddr_update__input_buffer[i] = __xlx_ddr_update__tmp_vec[i].range(31, 0).to_uint64();
  }
  // DUT call
  display_shift(__xlx_ddr_copy__input_buffer, __xlx_ddr_update__input_buffer, __xlx_offset_byte_param_ddr_copy, __xlx_offset_byte_param_ddr_update, __xlx_apatb_param_width, __xlx_apatb_param_height, __xlx_apatb_param_xstart, __xlx_apatb_param_xend, __xlx_apatb_param_ystart, __xlx_apatb_param_yend, __xlx_apatb_param_frame_size);
// print __xlx_apatb_param_ddr_copy
  sc_bv<32>*__xlx_ddr_copy_output_buffer = new sc_bv<32>[__xlx_size_param_ddr_copy];
  for (int i = 0; i < __xlx_size_param_ddr_copy; ++i) {
    __xlx_ddr_copy_output_buffer[i] = __xlx_ddr_copy__input_buffer[i+__xlx_offset_param_ddr_copy];
  }
  for (int i = 0; i < __xlx_size_param_ddr_copy; ++i) {
    ((int*)__xlx_apatb_param_ddr_copy)[i] = __xlx_ddr_copy_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_ddr_update
  sc_bv<32>*__xlx_ddr_update_output_buffer = new sc_bv<32>[__xlx_size_param_ddr_update];
  for (int i = 0; i < __xlx_size_param_ddr_update; ++i) {
    __xlx_ddr_update_output_buffer[i] = __xlx_ddr_update__input_buffer[i+__xlx_offset_param_ddr_update];
  }
  for (int i = 0; i < __xlx_size_param_ddr_update; ++i) {
    ((int*)__xlx_apatb_param_ddr_update)[i] = __xlx_ddr_update_output_buffer[i].to_uint64();
  }
}
