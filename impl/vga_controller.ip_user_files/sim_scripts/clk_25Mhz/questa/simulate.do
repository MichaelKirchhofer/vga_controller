onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib clk_25Mhz_opt

do {wave.do}

view wave
view structure
view signals

do {clk_25Mhz.udo}

run -all

quit -force
