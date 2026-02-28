# ====================================
# Lab 3 Bringup – FINAL Safe Version
# ====================================

add wave -divider {CLOCK}
add wave sim:/testbench/dut/clk
add wave sim:/testbench/dut/reset

# -------------------------------
add wave -divider {FETCH}
add wave sim:/testbench/dut/PC
add wave sim:/testbench/dut/Instr
add wave sim:/testbench/dut/PCPlus4
add wave sim:/testbench/dut/PCSrc

# -------------------------------
add wave -divider {MEMORY INTERFACE}
add wave sim:/testbench/dut/IEUAdr
add wave sim:/testbench/dut/WriteData
add wave sim:/testbench/dut/ReadData
add wave sim:/testbench/dut/MemEn
add wave sim:/testbench/dut/WriteEn
add wave sim:/testbench/dut/WriteByteEn

# -------------------------------
add wave -divider {HOST}
add wave sim:/testbench/tohost_lo
add wave sim:/testbench/tohost_hi
add wave sim:/testbench/cycle_count

run -all
view wave
