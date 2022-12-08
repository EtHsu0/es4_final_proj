if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/3.2} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "C:/Users/gsess/OneDrive/Documents/es4_final_proj/openai_snake"
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- openai_snake_impl_1.vm openai_snake_impl_1.ldc
run_engine_newmsg synthesis -f "openai_snake_impl_1_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o openai_snake_impl_1_syn.udb openai_snake_impl_1.vm] "C:/Users/gsess/OneDrive/Documents/es4_final_proj/openai_snake/impl_1/openai_snake_impl_1.ldc"

} out]} {
   runtime_log $out
   exit 1
}
