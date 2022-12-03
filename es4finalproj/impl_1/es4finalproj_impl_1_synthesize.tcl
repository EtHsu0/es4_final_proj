if {[catch {

# define run engine funtion
source [file join {C:/Program Files/lscc/radiant/3.0} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "C:/Users/ehsu05/Desktop/es4finalproj"
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- es4finalproj_impl_1.vm es4finalproj_impl_1.ldc
run_engine_newmsg synthesis -f "es4finalproj_impl_1_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o es4finalproj_impl_1_syn.udb es4finalproj_impl_1.vm] "C:/Users/ehsu05/Desktop/es4finalproj/impl_1/es4finalproj_impl_1.ldc"

} out]} {
   runtime_log $out
   exit 1
}
