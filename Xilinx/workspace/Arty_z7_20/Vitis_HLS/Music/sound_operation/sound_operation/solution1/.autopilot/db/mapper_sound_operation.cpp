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
extern "C" void sound_operation(int*, int, volatile void *, volatile void *);
extern "C" void apatb_sound_operation_hw(volatile void * __xlx_apatb_param_ramadr, volatile void * __xlx_apatb_param_sdata, volatile void * __xlx_apatb_param_opeout) {
  // Collect __xlx_ramadr__tmp_vec
  vector<sc_bv<32> >__xlx_ramadr__tmp_vec;
  for (int j = 0, e = 1; j != e; ++j) {
    __xlx_ramadr__tmp_vec.push_back(((int*)__xlx_apatb_param_ramadr)[j]);
  }
  int __xlx_size_param_ramadr = 1;
  int __xlx_offset_param_ramadr = 0;
  int __xlx_offset_byte_param_ramadr = 0*4;
  int* __xlx_ramadr__input_buffer= new int[__xlx_ramadr__tmp_vec.size()];
  for (int i = 0; i < __xlx_ramadr__tmp_vec.size(); ++i) {
    __xlx_ramadr__input_buffer[i] = __xlx_ramadr__tmp_vec[i].range(31, 0).to_uint64();
  }
  // DUT call
  sound_operation(__xlx_ramadr__input_buffer, __xlx_offset_byte_param_ramadr, __xlx_apatb_param_sdata, __xlx_apatb_param_opeout);
// print __xlx_apatb_param_ramadr
  sc_bv<32>*__xlx_ramadr_output_buffer = new sc_bv<32>[__xlx_size_param_ramadr];
  for (int i = 0; i < __xlx_size_param_ramadr; ++i) {
    __xlx_ramadr_output_buffer[i] = __xlx_ramadr__input_buffer[i+__xlx_offset_param_ramadr];
  }
  for (int i = 0; i < __xlx_size_param_ramadr; ++i) {
    ((int*)__xlx_apatb_param_ramadr)[i] = __xlx_ramadr_output_buffer[i].to_uint64();
  }
}
