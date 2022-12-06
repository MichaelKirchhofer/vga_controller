vsim -t ns -novopt -lib work work.tb_src_mux
view *
do src_mux.do
run 10 ms
