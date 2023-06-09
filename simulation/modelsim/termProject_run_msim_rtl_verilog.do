transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/altera/13.1/Projects/TermProject {D:/altera/13.1/Projects/TermProject/debounced_input_handler.v}

