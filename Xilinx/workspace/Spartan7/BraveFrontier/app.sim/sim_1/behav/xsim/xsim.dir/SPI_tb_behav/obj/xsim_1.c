/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_2(char*, char *);
IKI_DLLESPEC extern void execute_4(char*, char *);
IKI_DLLESPEC extern void execute_8(char*, char *);
IKI_DLLESPEC extern void execute_11(char*, char *);
IKI_DLLESPEC extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
IKI_DLLESPEC extern void execute_134(char*, char *);
IKI_DLLESPEC extern void execute_135(char*, char *);
IKI_DLLESPEC extern void execute_136(char*, char *);
IKI_DLLESPEC extern void execute_137(char*, char *);
IKI_DLLESPEC extern void execute_138(char*, char *);
IKI_DLLESPEC extern void execute_139(char*, char *);
IKI_DLLESPEC extern void execute_140(char*, char *);
IKI_DLLESPEC extern void execute_141(char*, char *);
IKI_DLLESPEC extern void execute_42(char*, char *);
IKI_DLLESPEC extern void execute_129(char*, char *);
IKI_DLLESPEC extern void execute_130(char*, char *);
IKI_DLLESPEC extern void execute_131(char*, char *);
IKI_DLLESPEC extern void execute_132(char*, char *);
IKI_DLLESPEC extern void execute_133(char*, char *);
IKI_DLLESPEC extern void execute_36(char*, char *);
IKI_DLLESPEC extern void execute_117(char*, char *);
IKI_DLLESPEC extern void execute_118(char*, char *);
IKI_DLLESPEC extern void execute_119(char*, char *);
IKI_DLLESPEC extern void execute_120(char*, char *);
IKI_DLLESPEC extern void execute_121(char*, char *);
IKI_DLLESPEC extern void execute_122(char*, char *);
IKI_DLLESPEC extern void execute_15(char*, char *);
IKI_DLLESPEC extern void execute_16(char*, char *);
IKI_DLLESPEC extern void execute_18(char*, char *);
IKI_DLLESPEC extern void execute_19(char*, char *);
IKI_DLLESPEC extern void execute_20(char*, char *);
IKI_DLLESPEC extern void execute_22(char*, char *);
IKI_DLLESPEC extern void execute_23(char*, char *);
IKI_DLLESPEC extern void execute_24(char*, char *);
IKI_DLLESPEC extern void execute_25(char*, char *);
IKI_DLLESPEC extern void execute_26(char*, char *);
IKI_DLLESPEC extern void execute_27(char*, char *);
IKI_DLLESPEC extern void execute_70(char*, char *);
IKI_DLLESPEC extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
IKI_DLLESPEC extern void execute_106(char*, char *);
IKI_DLLESPEC extern void execute_109(char*, char *);
IKI_DLLESPEC extern void execute_110(char*, char *);
IKI_DLLESPEC extern void execute_111(char*, char *);
IKI_DLLESPEC extern void execute_112(char*, char *);
IKI_DLLESPEC extern void execute_113(char*, char *);
IKI_DLLESPEC extern void execute_114(char*, char *);
IKI_DLLESPEC extern void execute_115(char*, char *);
IKI_DLLESPEC extern void execute_116(char*, char *);
IKI_DLLESPEC extern void execute_71(char*, char *);
IKI_DLLESPEC extern void execute_72(char*, char *);
IKI_DLLESPEC extern void execute_73(char*, char *);
IKI_DLLESPEC extern void execute_74(char*, char *);
IKI_DLLESPEC extern void execute_75(char*, char *);
IKI_DLLESPEC extern void execute_76(char*, char *);
IKI_DLLESPEC extern void execute_77(char*, char *);
IKI_DLLESPEC extern void execute_78(char*, char *);
IKI_DLLESPEC extern void execute_79(char*, char *);
IKI_DLLESPEC extern void execute_38(char*, char *);
IKI_DLLESPEC extern void execute_39(char*, char *);
IKI_DLLESPEC extern void execute_40(char*, char *);
IKI_DLLESPEC extern void execute_41(char*, char *);
IKI_DLLESPEC extern void execute_44(char*, char *);
IKI_DLLESPEC extern void execute_45(char*, char *);
IKI_DLLESPEC extern void execute_46(char*, char *);
IKI_DLLESPEC extern void execute_47(char*, char *);
IKI_DLLESPEC extern void execute_142(char*, char *);
IKI_DLLESPEC extern void execute_143(char*, char *);
IKI_DLLESPEC extern void execute_144(char*, char *);
IKI_DLLESPEC extern void execute_145(char*, char *);
IKI_DLLESPEC extern void execute_146(char*, char *);
IKI_DLLESPEC extern void execute_147(char*, char *);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[72] = {(funcp)execute_2, (funcp)execute_4, (funcp)execute_8, (funcp)execute_11, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_134, (funcp)execute_135, (funcp)execute_136, (funcp)execute_137, (funcp)execute_138, (funcp)execute_139, (funcp)execute_140, (funcp)execute_141, (funcp)execute_42, (funcp)execute_129, (funcp)execute_130, (funcp)execute_131, (funcp)execute_132, (funcp)execute_133, (funcp)execute_36, (funcp)execute_117, (funcp)execute_118, (funcp)execute_119, (funcp)execute_120, (funcp)execute_121, (funcp)execute_122, (funcp)execute_15, (funcp)execute_16, (funcp)execute_18, (funcp)execute_19, (funcp)execute_20, (funcp)execute_22, (funcp)execute_23, (funcp)execute_24, (funcp)execute_25, (funcp)execute_26, (funcp)execute_27, (funcp)execute_70, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_106, (funcp)execute_109, (funcp)execute_110, (funcp)execute_111, (funcp)execute_112, (funcp)execute_113, (funcp)execute_114, (funcp)execute_115, (funcp)execute_116, (funcp)execute_71, (funcp)execute_72, (funcp)execute_73, (funcp)execute_74, (funcp)execute_75, (funcp)execute_76, (funcp)execute_77, (funcp)execute_78, (funcp)execute_79, (funcp)execute_38, (funcp)execute_39, (funcp)execute_40, (funcp)execute_41, (funcp)execute_44, (funcp)execute_45, (funcp)execute_46, (funcp)execute_47, (funcp)execute_142, (funcp)execute_143, (funcp)execute_144, (funcp)execute_145, (funcp)execute_146, (funcp)execute_147, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 72;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/SPI_tb_behav/xsim.reloc",  (void **)funcTab, 72);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/SPI_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/SPI_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

	iki_vlog_add_strength_resolution_functions_time_0(*(char**)(dp + 1664), dp + 1776, dp + 1832, 4294967295, 0, 0, 0, 0, dp + 1616);

	iki_vlog_add_strength_resolution_functions_time_0(*(char**)(dp + 1896), dp + 2008, dp + 2064, 4294967295, 0, 0, 0, 0, dp + 1848);

	iki_vlog_add_strength_resolution_functions_time_0(*(char**)(dp + 2128), dp + 2240, dp + 2296, 4294967295, 0, 0, 0, 0, dp + 2080);

	iki_vlog_add_strength_resolution_functions_time_0(*(char**)(dp + 2360), dp + 2472, dp + 2528, 4294967295, 0, 0, 0, 0, dp + 2312);

	iki_vlog_add_strength_resolution_functions_time_0(*(char**)(dp + 2592), dp + 2704, dp + 2760, 4294967295, 0, 0, 0, 0, dp + 2544);

	iki_vlog_add_strength_resolution_functions_time_0(*(char**)(dp + 2824), dp + 2936, dp + 2992, 4294967295, 0, 0, 0, 0, dp + 2776);

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/SPI_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/SPI_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/SPI_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
