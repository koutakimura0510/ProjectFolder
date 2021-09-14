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
struct __cosim_s1__ { char data[1]; };
extern "C" void mapchip(int*, int*, int, int, int, __cosim_s4__, __cosim_s4__, __cosim_s4__, __cosim_s4__, __cosim_s4__, __cosim_s4__, __cosim_s4__, __cosim_s1__, __cosim_s4__, __cosim_s4__);
extern "C" void apatb_mapchip_hw(volatile void * __xlx_apatb_param_srcin, volatile void * __xlx_apatb_param_dstin, volatile void * __xlx_apatb_param_dstout, __cosim_s4__ __xlx_apatb_param_mapchip_maxwidth, __cosim_s4__ __xlx_apatb_param_mapchip_maxheight, __cosim_s4__ __xlx_apatb_param_mapchip_draw_xsize, __cosim_s4__ __xlx_apatb_param_mapchip_draw_ysize, __cosim_s4__ __xlx_apatb_param_xstart_pos, __cosim_s4__ __xlx_apatb_param_ystart_pos, __cosim_s4__ __xlx_apatb_param_frame_size, __cosim_s1__ __xlx_apatb_param_alpha, __cosim_s4__ __xlx_apatb_param_id, __cosim_s4__ __xlx_apatb_param_crip) {
  // Collect __xlx_srcin__tmp_vec
  vector<sc_bv<32> >__xlx_srcin__tmp_vec;
  for (int j = 0, e = 307200; j != e; ++j) {
    __xlx_srcin__tmp_vec.push_back(((int*)__xlx_apatb_param_srcin)[j]);
  }
  int __xlx_size_param_srcin = 307200;
  int __xlx_offset_param_srcin = 0;
  int __xlx_offset_byte_param_srcin = 0*4;
  int* __xlx_srcin__input_buffer= new int[__xlx_srcin__tmp_vec.size()];
  for (int i = 0; i < __xlx_srcin__tmp_vec.size(); ++i) {
    __xlx_srcin__input_buffer[i] = __xlx_srcin__tmp_vec[i].range(31, 0).to_uint64();
  }
  // Collect __xlx_dstin_dstout__tmp_vec
  vector<sc_bv<32> >__xlx_dstin_dstout__tmp_vec;
  for (int j = 0, e = 307200; j != e; ++j) {
    __xlx_dstin_dstout__tmp_vec.push_back(((int*)__xlx_apatb_param_dstin)[j]);
  }
  int __xlx_size_param_dstin = 307200;
  int __xlx_offset_param_dstin = 0;
  int __xlx_offset_byte_param_dstin = 0*4;
  for (int j = 0, e = 307200; j != e; ++j) {
    __xlx_dstin_dstout__tmp_vec.push_back(((int*)__xlx_apatb_param_dstout)[j]);
  }
  int __xlx_size_param_dstout = 307200;
  int __xlx_offset_param_dstout = 307200;
  int __xlx_offset_byte_param_dstout = 307200*4;
  int* __xlx_dstin_dstout__input_buffer= new int[__xlx_dstin_dstout__tmp_vec.size()];
  for (int i = 0; i < __xlx_dstin_dstout__tmp_vec.size(); ++i) {
    __xlx_dstin_dstout__input_buffer[i] = __xlx_dstin_dstout__tmp_vec[i].range(31, 0).to_uint64();
  }
  // DUT call
  mapchip(__xlx_srcin__input_buffer, __xlx_dstin_dstout__input_buffer, __xlx_offset_byte_param_srcin, __xlx_offset_byte_param_dstin, __xlx_offset_byte_param_dstout, __xlx_apatb_param_mapchip_maxwidth, __xlx_apatb_param_mapchip_maxheight, __xlx_apatb_param_mapchip_draw_xsize, __xlx_apatb_param_mapchip_draw_ysize, __xlx_apatb_param_xstart_pos, __xlx_apatb_param_ystart_pos, __xlx_apatb_param_frame_size, __xlx_apatb_param_alpha, __xlx_apatb_param_id, __xlx_apatb_param_crip);
// print __xlx_apatb_param_srcin
  sc_bv<32>*__xlx_srcin_output_buffer = new sc_bv<32>[__xlx_size_param_srcin];
  for (int i = 0; i < __xlx_size_param_srcin; ++i) {
    __xlx_srcin_output_buffer[i] = __xlx_srcin__input_buffer[i+__xlx_offset_param_srcin];
  }
  for (int i = 0; i < __xlx_size_param_srcin; ++i) {
    ((int*)__xlx_apatb_param_srcin)[i] = __xlx_srcin_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_dstin
  sc_bv<32>*__xlx_dstin_output_buffer = new sc_bv<32>[__xlx_size_param_dstin];
  for (int i = 0; i < __xlx_size_param_dstin; ++i) {
    __xlx_dstin_output_buffer[i] = __xlx_dstin_dstout__input_buffer[i+__xlx_offset_param_dstin];
  }
  for (int i = 0; i < __xlx_size_param_dstin; ++i) {
    ((int*)__xlx_apatb_param_dstin)[i] = __xlx_dstin_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_dstout
  sc_bv<32>*__xlx_dstout_output_buffer = new sc_bv<32>[__xlx_size_param_dstout];
  for (int i = 0; i < __xlx_size_param_dstout; ++i) {
    __xlx_dstout_output_buffer[i] = __xlx_dstin_dstout__input_buffer[i+__xlx_offset_param_dstout];
  }
  for (int i = 0; i < __xlx_size_param_dstout; ++i) {
    ((int*)__xlx_apatb_param_dstout)[i] = __xlx_dstout_output_buffer[i].to_uint64();
  }
}
