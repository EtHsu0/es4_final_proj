if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/3.2} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "C:/Users/gsess/OneDrive/Documents/es4_final_proj/ES4_Snake"
# synthesize IPs
# synthesize VMs
# propgate constraints
file delete -force -- es4finalproj_impl_1_cpe.ldc
run_engine_newmsg cpe -f "es4finalproj_impl_1.cprj" "mypll.cprj" -a "iCE40UP"  -o es4finalproj_impl_1_cpe.ldc
# synthesize top design
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o es4finalproj_impl_1_syn.udb es4finalproj_impl_1.vm] "C:/Users/gsess/OneDrive/Documents/es4_final_proj/ES4_Snake/impl_1/es4finalproj_impl_1.ldc"

} out]} {
   runtime_log $out
   exit 1
}
