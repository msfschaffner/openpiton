# Copyright (c) 2016 Princeton University
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Princeton University nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY PRINCETON UNIVERSITY "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL PRINCETON UNIVERSITY BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Clock signals
set_property IOSTANDARD LVDS [get_ports clk_osc_p]
set_property PACKAGE_PIN AD12 [get_ports clk_osc_p]
set_property PACKAGE_PIN AD11 [get_ports clk_osc_n]
set_property IOSTANDARD LVDS [get_ports clk_osc_n]

set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets clk_mmcm/inst/clk_in1_clk_mmcm]

# Non-MMCM clock constraints
create_clock -period 5.000 -name passthru_chipset_clk_p -waveform {0.000 2.500} [get_ports passthru_chipset_clk_p]
create_clock -period 5.000 -name passthru_chipset_clk_n -waveform {2.500 5.000} [get_ports passthru_chipset_clk_n]
create_clock -period 5.000 -name passthru_chipset_clk -waveform {0.000 2.500} [get_pins passthru_chipset_clk_ibufgds/O]
create_clock -period 5.000 -name chipset_passthru_clk_p -waveform {0.000 2.500} [get_ports chipset_passthru_clk_p]
create_clock -period 5.000 -name chipset_passthru_clk_n -waveform {2.500 5.000} [get_ports chipset_passthru_clk_n]

# Constraint RGMII interface
create_generated_clock -name txc_gen -source [get_pins net_phy_txc_oddr/C] -multiply_by 1 [get_ports net_phy_txc]
set_output_delay -clock txc_gen 2.000 [get_ports net_phy_txctl]
set_output_delay -clock txc_gen 2.000 [get_ports {net_phy_txd[0]}]
set_output_delay -clock txc_gen 2.000 [get_ports {net_phy_txd[1]}]
set_output_delay -clock txc_gen 2.000 [get_ports {net_phy_txd[2]}]
set_output_delay -clock txc_gen 2.000 [get_ports {net_phy_txd[3]}]

# Reset
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property PACKAGE_PIN R19 [get_ports rst_n]

# False paths
set_false_path -to [get_cells -hierarchical *afifo_ui_rst_r*]
set_false_path -to [get_cells -hierarchical *ui_clk_sync_rst_r*]
set_false_path -to [get_cells -hierarchical *ui_clk_syn_rst_delayed*]
set_false_path -to [get_cells -hierarchical *init_calib_complete_f*]
set_false_path -from [get_clocks chipset_clk_clk_mmcm] -to [get_clocks net_axi_clk_clk_mmcm]
set_false_path -from [get_clocks net_axi_clk_clk_mmcm] -to [get_clocks chipset_clk_clk_mmcm]



#### UART
#IO_L11N_T1_SRCC_35 Sch=uart_rxd_out
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]
set_property PACKAGE_PIN Y20 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]
set_property PACKAGE_PIN Y23 [get_ports uart_tx]

# Switches
set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
set_property PACKAGE_PIN P27 [get_ports {sw[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property PACKAGE_PIN P26 [get_ports {sw[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[5]}]
set_property PACKAGE_PIN P19 [get_ports {sw[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[4]}]
set_property PACKAGE_PIN N19 [get_ports {sw[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[3]}]
set_property PACKAGE_PIN K19 [get_ports {sw[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[2]}]
set_property PACKAGE_PIN H24 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[1]}]
set_property PACKAGE_PIN G25 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[0]}]
set_property PACKAGE_PIN G19 [get_ports {sw[0]}]

# Loopback control for UART
#set_property IOSTANDARD LVCMOS12 [get_ports uart_lb_sw]
#set_property PACKAGE_PIN G19 [get_ports uart_lb_sw]

# Soft reset
#set_property IOSTANDARD LVCMOS12 [get_ports pin_soft_rst]
#set_property PACKAGE_PIN E18 [get_ports pin_soft_rst]

# SD
set_property IOSTANDARD LVCMOS33 [get_ports sd_clk_out]
set_property PACKAGE_PIN R28 [get_ports sd_clk_out]
set_property IOSTANDARD LVCMOS33 [get_ports sd_cmd]
set_property PACKAGE_PIN R29 [get_ports sd_cmd]
set_property IOSTANDARD LVCMOS33 [get_ports {sd_dat[0]}]
set_property PACKAGE_PIN R26 [get_ports {sd_dat[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sd_dat[1]}]
set_property PACKAGE_PIN R30 [get_ports {sd_dat[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sd_dat[2]}]
set_property PACKAGE_PIN P29 [get_ports {sd_dat[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sd_dat[3]}]
set_property PACKAGE_PIN T30 [get_ports {sd_dat[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports sd_reset]
set_property PACKAGE_PIN AE24 [get_ports sd_reset]
set_property IOSTANDARD LVCMOS33 [get_ports sd_cd]
set_property PACKAGE_PIN P28 [get_ports sd_cd]

## LEDs

set_property PACKAGE_PIN T28 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property PACKAGE_PIN V19 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property PACKAGE_PIN U30 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property PACKAGE_PIN U29 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property PACKAGE_PIN V20 [get_ports {leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]
set_property PACKAGE_PIN V26 [get_ports {leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]
set_property PACKAGE_PIN W24 [get_ports {leds[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]
set_property PACKAGE_PIN W23 [get_ports {leds[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[7]}]


## OLED
set_property -dict {PACKAGE_PIN AC17 IOSTANDARD LVCMOS18} [get_ports oled_dc]
set_property -dict {PACKAGE_PIN AB17 IOSTANDARD LVCMOS18} [get_ports oled_rst_n]
set_property -dict {PACKAGE_PIN AF17 IOSTANDARD LVCMOS18} [get_ports oled_sclk]
set_property -dict {PACKAGE_PIN Y15 IOSTANDARD LVCMOS18} [get_ports oled_data]
set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVCMOS33} [get_ports oled_vbat_n]
set_property -dict {PACKAGE_PIN AG17 IOSTANDARD LVCMOS18} [get_ports oled_vdd_n]


## Buttons
set_property PACKAGE_PIN M20 [get_ports btnl]
set_property IOSTANDARD LVCMOS25 [get_ports btnl]
set_property PACKAGE_PIN C19 [get_ports btnr]
set_property IOSTANDARD LVCMOS25 [get_ports btnr]
set_property PACKAGE_PIN M19 [get_ports btnd]
set_property IOSTANDARD LVCMOS25 [get_ports btnd]
set_property PACKAGE_PIN B19 [get_ports btnu]
set_property IOSTANDARD LVCMOS25 [get_ports btnu]

## Ethernet

# NOTUSED? set_property PACKAGE_PIN AK16 [get_ports net_ip2intc_irpt]
# NOTUSED? set_property IOSTANDARD LVCMOS18 [get_ports net_ip2intc_irpt]
# NOTUSED? set_property PULLUP true [get_ports net_ip2intc_irpt]
set_property PACKAGE_PIN AF12 [get_ports net_phy_mdc]
set_property IOSTANDARD LVCMOS15 [get_ports net_phy_mdc]
set_property PACKAGE_PIN AG12 [get_ports net_phy_mdio_io]
set_property IOSTANDARD LVCMOS15 [get_ports net_phy_mdio_io]
set_property PACKAGE_PIN AH24 [get_ports net_phy_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports net_phy_rst_n]
#set_property -dict { PACKAGE_PIN AK15  IOSTANDARD LVCMOS18 } [get_ports { ETH_PMEB }]; #IO_L1N_T0_32 Sch=eth_pmeb
set_property PACKAGE_PIN AG10 [get_ports net_phy_rxc]
set_property IOSTANDARD LVCMOS15 [get_ports net_phy_rxc]
set_property PACKAGE_PIN AH11 [get_ports net_phy_rxctl]
set_property IOSTANDARD LVCMOS15 [get_ports net_phy_rxctl]
set_property PACKAGE_PIN AJ14 [get_ports {net_phy_rxd[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {net_phy_rxd[0]}]
set_property PACKAGE_PIN AH14 [get_ports {net_phy_rxd[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {net_phy_rxd[1]}]
set_property PACKAGE_PIN AK13 [get_ports {net_phy_rxd[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {net_phy_rxd[2]}]
set_property PACKAGE_PIN AJ13 [get_ports {net_phy_rxd[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {net_phy_rxd[3]}]
set_property PACKAGE_PIN AE10 [get_ports net_phy_txc]
set_property IOSTANDARD LVCMOS15 [get_ports net_phy_txc]
set_property PACKAGE_PIN AJ12 [get_ports {net_phy_txd[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {net_phy_txd[0]}]
set_property PACKAGE_PIN AK11 [get_ports {net_phy_txd[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {net_phy_txd[1]}]
set_property PACKAGE_PIN AJ11 [get_ports {net_phy_txd[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {net_phy_txd[2]}]
set_property PACKAGE_PIN AK10 [get_ports {net_phy_txd[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {net_phy_txd[3]}]
set_property PACKAGE_PIN AK14 [get_ports net_phy_txctl]
set_property IOSTANDARD LVCMOS15 [get_ports net_phy_txctl]

# FMC Clocks
set_property -dict {PACKAGE_PIN E20 IOSTANDARD LVDS_25} [get_ports chipset_passthru_clk_n]
set_property -dict {PACKAGE_PIN F20 IOSTANDARD LVDS_25} [get_ports chipset_passthru_clk_p]
set_property -dict {PACKAGE_PIN D28 IOSTANDARD LVDS_25} [get_ports passthru_chipset_clk_n]
set_property -dict {PACKAGE_PIN E28 IOSTANDARD LVDS_25} [get_ports passthru_chipset_clk_p]

# FMC Signals
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[11]}]
set_property PACKAGE_PIN D27 [get_ports {chipset_passthru_data_p[11]}]
set_property PACKAGE_PIN C27 [get_ports {chipset_passthru_data_n[11]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[11]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_credit_back_n[0]}]
set_property PACKAGE_PIN D26 [get_ports {passthru_chipset_credit_back_p[0]}]
set_property PACKAGE_PIN C26 [get_ports {passthru_chipset_credit_back_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_credit_back_p[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[16]}]
set_property PACKAGE_PIN H30 [get_ports {chipset_passthru_data_p[16]}]
set_property PACKAGE_PIN G30 [get_ports {chipset_passthru_data_n[16]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[16]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[12]}]
set_property PACKAGE_PIN E29 [get_ports {chipset_passthru_data_p[12]}]
set_property PACKAGE_PIN E30 [get_ports {chipset_passthru_data_n[12]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[12]}]
set_property -dict { PACKAGE_PIN H27   IOSTANDARD LVCMOS25 } [get_ports { F4_N }]; #IO_L23N_T3_16 Sch=fmc_la_n[04]
set_property -dict { PACKAGE_PIN H26   IOSTANDARD LVCMOS25 } [get_ports { F4_P }]; #IO_L23P_T3_16 Sch=fmc_la_p[04]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_credit_back_n[2]}]
set_property PACKAGE_PIN B30 [get_ports {passthru_chipset_credit_back_p[2]}]
set_property PACKAGE_PIN A30 [get_ports {passthru_chipset_credit_back_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_credit_back_p[2]}]
set_property -dict { PACKAGE_PIN C30   IOSTANDARD LVCMOS25 } [get_ports { F6_N }]; #IO_L16N_T2_16 Sch=fmc_la_n[06]
set_property -dict { PACKAGE_PIN D29   IOSTANDARD LVCMOS25 } [get_ports { F6_P }]; #IO_L16P_T2_16 Sch=fmc_la_p[06]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_channel_n[0]}]
set_property PACKAGE_PIN F25 [get_ports {chipset_passthru_channel_p[0]}]
set_property PACKAGE_PIN E25 [get_ports {chipset_passthru_channel_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_channel_p[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[29]}]
set_property PACKAGE_PIN C29 [get_ports {passthru_chipset_data_p[29]}]
set_property PACKAGE_PIN B29 [get_ports {passthru_chipset_data_n[29]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[29]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[0]}]
set_property PACKAGE_PIN B28 [get_ports {chipset_passthru_data_p[0]}]
set_property PACKAGE_PIN A28 [get_ports {chipset_passthru_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[30]}]
set_property PACKAGE_PIN B27 [get_ports {passthru_chipset_data_p[30]}]
set_property PACKAGE_PIN A27 [get_ports {passthru_chipset_data_n[30]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[30]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[31]}]
set_property PACKAGE_PIN A25 [get_ports {chipset_passthru_data_p[31]}]
set_property PACKAGE_PIN A26 [get_ports {chipset_passthru_data_n[31]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[31]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[9]}]
set_property PACKAGE_PIN F26 [get_ports {chipset_passthru_data_p[9]}]
set_property PACKAGE_PIN E26 [get_ports {chipset_passthru_data_n[9]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[9]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[20]}]
set_property PACKAGE_PIN E24 [get_ports {passthru_chipset_data_p[20]}]
set_property PACKAGE_PIN D24 [get_ports {passthru_chipset_data_n[20]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[20]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[25]}]
set_property PACKAGE_PIN C24 [get_ports {passthru_chipset_data_p[25]}]
set_property PACKAGE_PIN B24 [get_ports {passthru_chipset_data_n[25]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[25]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[25]}]
set_property PACKAGE_PIN B23 [get_ports {chipset_passthru_data_p[25]}]
set_property PACKAGE_PIN A23 [get_ports {chipset_passthru_data_n[25]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[25]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[15]}]
set_property PACKAGE_PIN E23 [get_ports {passthru_chipset_data_p[15]}]
set_property PACKAGE_PIN D23 [get_ports {passthru_chipset_data_n[15]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[15]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[16]}]
set_property PACKAGE_PIN F21 [get_ports {passthru_chipset_data_p[16]}]
set_property PACKAGE_PIN E21 [get_ports {passthru_chipset_data_n[16]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[16]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[21]}]
set_property PACKAGE_PIN D17 [get_ports {passthru_chipset_data_p[21]}]
set_property PACKAGE_PIN D18 [get_ports {passthru_chipset_data_n[21]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[21]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[14]}]
set_property PACKAGE_PIN H21 [get_ports {passthru_chipset_data_p[14]}]
set_property PACKAGE_PIN H22 [get_ports {passthru_chipset_data_n[14]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[14]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[6]}]
set_property PACKAGE_PIN G22 [get_ports {chipset_passthru_data_p[6]}]
set_property PACKAGE_PIN F22 [get_ports {chipset_passthru_data_n[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[11]}]
set_property PACKAGE_PIN L17 [get_ports {passthru_chipset_data_p[11]}]
set_property PACKAGE_PIN L18 [get_ports {passthru_chipset_data_n[11]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[11]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[7]}]
set_property PACKAGE_PIN J17 [get_ports {passthru_chipset_data_p[7]}]
set_property PACKAGE_PIN H17 [get_ports {passthru_chipset_data_n[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[13]}]
set_property PACKAGE_PIN G17 [get_ports {passthru_chipset_data_p[13]}]
set_property PACKAGE_PIN F17 [get_ports {passthru_chipset_data_n[13]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[13]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[8]}]
set_property PACKAGE_PIN H20 [get_ports {passthru_chipset_data_p[8]}]
set_property PACKAGE_PIN G20 [get_ports {passthru_chipset_data_n[8]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[8]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[9]}]
set_property PACKAGE_PIN D22 [get_ports {passthru_chipset_data_p[9]}]
set_property PACKAGE_PIN C22 [get_ports {passthru_chipset_data_n[9]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[9]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[18]}]
set_property PACKAGE_PIN B22 [get_ports {passthru_chipset_data_p[18]}]
set_property PACKAGE_PIN A22 [get_ports {passthru_chipset_data_n[18]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[18]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[22]}]
set_property PACKAGE_PIN A20 [get_ports {passthru_chipset_data_p[22]}]
set_property PACKAGE_PIN A21 [get_ports {passthru_chipset_data_n[22]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[22]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[31]}]
set_property PACKAGE_PIN J19 [get_ports {passthru_chipset_data_p[31]}]
set_property PACKAGE_PIN H19 [get_ports {passthru_chipset_data_n[31]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[31]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[2]}]
set_property PACKAGE_PIN B18 [get_ports {chipset_passthru_data_p[2]}]
set_property PACKAGE_PIN A18 [get_ports {chipset_passthru_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[0]}]
set_property PACKAGE_PIN A16 [get_ports {passthru_chipset_data_p[0]}]
set_property PACKAGE_PIN A17 [get_ports {passthru_chipset_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[6]}]
set_property PACKAGE_PIN C17 [get_ports {passthru_chipset_data_p[6]}]
set_property PACKAGE_PIN B17 [get_ports {passthru_chipset_data_n[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[10]}]
set_property PACKAGE_PIN K18 [get_ports {passthru_chipset_data_p[10]}]
set_property PACKAGE_PIN J18 [get_ports {passthru_chipset_data_n[10]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[10]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_credit_back_n[1]}]
set_property PACKAGE_PIN D16 [get_ports {chipset_passthru_credit_back_p[1]}]
set_property PACKAGE_PIN C16 [get_ports {chipset_passthru_credit_back_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_credit_back_p[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[15]}]
set_property PACKAGE_PIN K28 [get_ports {chipset_passthru_data_p[15]}]
set_property PACKAGE_PIN K29 [get_ports {chipset_passthru_data_n[15]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[15]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[13]}]
set_property PACKAGE_PIN M28 [get_ports {chipset_passthru_data_p[13]}]
set_property PACKAGE_PIN L28 [get_ports {chipset_passthru_data_n[13]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[13]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[24]}]
set_property PACKAGE_PIN P21 [get_ports {chipset_passthru_data_p[24]}]
set_property PACKAGE_PIN P22 [get_ports {chipset_passthru_data_n[24]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[24]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[26]}]
set_property PACKAGE_PIN N25 [get_ports {chipset_passthru_data_p[26]}]
set_property PACKAGE_PIN N26 [get_ports {chipset_passthru_data_n[26]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[26]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[18]}]
set_property PACKAGE_PIN M24 [get_ports {chipset_passthru_data_p[18]}]
set_property PACKAGE_PIN M25 [get_ports {chipset_passthru_data_n[18]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[18]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[17]}]
set_property PACKAGE_PIN J29 [get_ports {chipset_passthru_data_p[17]}]
set_property PACKAGE_PIN H29 [get_ports {chipset_passthru_data_n[17]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[17]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[19]}]
set_property PACKAGE_PIN N29 [get_ports {chipset_passthru_data_p[19]}]
set_property PACKAGE_PIN N30 [get_ports {chipset_passthru_data_n[19]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[19]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[1]}]
set_property PACKAGE_PIN M29 [get_ports {chipset_passthru_data_p[1]}]
set_property PACKAGE_PIN M30 [get_ports {chipset_passthru_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[10]}]
set_property PACKAGE_PIN J27 [get_ports {chipset_passthru_data_p[10]}]
set_property PACKAGE_PIN J28 [get_ports {chipset_passthru_data_n[10]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[10]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[14]}]
set_property PACKAGE_PIN L30 [get_ports {chipset_passthru_data_p[14]}]
set_property PACKAGE_PIN K30 [get_ports {chipset_passthru_data_n[14]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[14]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[28]}]
set_property PACKAGE_PIN N21 [get_ports {chipset_passthru_data_p[28]}]
set_property PACKAGE_PIN N22 [get_ports {chipset_passthru_data_n[28]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[28]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[30]}]
set_property PACKAGE_PIN P23 [get_ports {chipset_passthru_data_p[30]}]
set_property PACKAGE_PIN N24 [get_ports {chipset_passthru_data_n[30]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[30]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[22]}]
set_property PACKAGE_PIN L26 [get_ports {chipset_passthru_data_p[22]}]
set_property PACKAGE_PIN L27 [get_ports {chipset_passthru_data_n[22]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[22]}]
set_property PACKAGE_PIN J26 [get_ports piton_prsnt_n]
set_property IOSTANDARD LVCMOS25 [get_ports piton_prsnt_n]
set_property PULLUP true [get_ports piton_prsnt_n]
set_property -dict { PACKAGE_PIN K26   IOSTANDARD LVCMOS25 } [get_ports { F47_P }]; #IO_L10P_T1_AD4P_15 Sch=fmc_ha_p[13]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[29]}]
set_property PACKAGE_PIN N27 [get_ports {chipset_passthru_data_p[29]}]
set_property PACKAGE_PIN M27 [get_ports {chipset_passthru_data_n[29]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[29]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_credit_back_n[1]}]
set_property PACKAGE_PIN J21 [get_ports {passthru_chipset_credit_back_p[1]}]
set_property PACKAGE_PIN J22 [get_ports {passthru_chipset_credit_back_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_credit_back_p[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_channel_n[1]}]
set_property PACKAGE_PIN M22 [get_ports {chipset_passthru_channel_p[1]}]
set_property PACKAGE_PIN M23 [get_ports {chipset_passthru_channel_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_channel_p[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[20]}]
set_property PACKAGE_PIN C25 [get_ports {chipset_passthru_data_p[20]}]
set_property PACKAGE_PIN B25 [get_ports {chipset_passthru_data_n[20]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[20]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[28]}]
set_property PACKAGE_PIN E19 [get_ports {passthru_chipset_data_p[28]}]
set_property PACKAGE_PIN D19 [get_ports {passthru_chipset_data_n[28]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[28]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[3]}]
set_property PACKAGE_PIN G29 [get_ports {chipset_passthru_data_p[3]}]
set_property PACKAGE_PIN F30 [get_ports {chipset_passthru_data_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[5]}]
set_property PACKAGE_PIN G27 [get_ports {chipset_passthru_data_p[5]}]
set_property PACKAGE_PIN F27 [get_ports {chipset_passthru_data_n[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[21]}]
set_property PACKAGE_PIN G28 [get_ports {chipset_passthru_data_p[21]}]
set_property PACKAGE_PIN F28 [get_ports {chipset_passthru_data_n[21]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[21]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[23]}]
set_property PACKAGE_PIN D21 [get_ports {chipset_passthru_data_p[23]}]
set_property PACKAGE_PIN C21 [get_ports {chipset_passthru_data_n[23]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[23]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[27]}]
set_property PACKAGE_PIN G18 [get_ports {chipset_passthru_data_p[27]}]
set_property PACKAGE_PIN F18 [get_ports {chipset_passthru_data_n[27]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[27]}]
set_property PACKAGE_PIN F13 [get_ports piton_ready_n]
set_property IOSTANDARD LVCMOS25 [get_ports piton_ready_n]
set_property PULLUP true [get_ports piton_ready_n]
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS25} [get_ports chipset_prsnt_n]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[7]}]
set_property PACKAGE_PIN H15 [get_ports {chipset_passthru_data_p[7]}]
set_property PACKAGE_PIN G15 [get_ports {chipset_passthru_data_n[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[8]}]
set_property PACKAGE_PIN L15 [get_ports {chipset_passthru_data_p[8]}]
set_property PACKAGE_PIN K15 [get_ports {chipset_passthru_data_n[8]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[8]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_n[4]}]
set_property PACKAGE_PIN H14 [get_ports {chipset_passthru_data_p[4]}]
set_property PACKAGE_PIN G14 [get_ports {chipset_passthru_data_n[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_data_p[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[23]}]
set_property PACKAGE_PIN J16 [get_ports {passthru_chipset_data_p[23]}]
set_property PACKAGE_PIN H16 [get_ports {passthru_chipset_data_n[23]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[23]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[27]}]
set_property PACKAGE_PIN L16 [get_ports {passthru_chipset_data_p[27]}]
set_property PACKAGE_PIN K16 [get_ports {passthru_chipset_data_n[27]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[27]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[17]}]
set_property PACKAGE_PIN F12 [get_ports {passthru_chipset_data_p[17]}]
set_property PACKAGE_PIN E13 [get_ports {passthru_chipset_data_n[17]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[17]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[24]}]
set_property PACKAGE_PIN B13 [get_ports {passthru_chipset_data_p[24]}]
set_property PACKAGE_PIN A13 [get_ports {passthru_chipset_data_n[24]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[24]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[26]}]
set_property PACKAGE_PIN K14 [get_ports {passthru_chipset_data_p[26]}]
set_property PACKAGE_PIN J14 [get_ports {passthru_chipset_data_n[26]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[26]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[19]}]
set_property PACKAGE_PIN C15 [get_ports {passthru_chipset_data_p[19]}]
set_property PACKAGE_PIN B15 [get_ports {passthru_chipset_data_n[19]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[19]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[1]}]
set_property PACKAGE_PIN J11 [get_ports {passthru_chipset_data_p[1]}]
set_property PACKAGE_PIN J12 [get_ports {passthru_chipset_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[12]}]
set_property PACKAGE_PIN D11 [get_ports {passthru_chipset_data_p[12]}]
set_property PACKAGE_PIN C11 [get_ports {passthru_chipset_data_n[12]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[12]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[2]}]
set_property PACKAGE_PIN A11 [get_ports {passthru_chipset_data_p[2]}]
set_property PACKAGE_PIN A12 [get_ports {passthru_chipset_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[4]}]
set_property PACKAGE_PIN C12 [get_ports {passthru_chipset_data_p[4]}]
set_property PACKAGE_PIN B12 [get_ports {passthru_chipset_data_n[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_channel_n[1]}]
set_property PACKAGE_PIN H11 [get_ports {passthru_chipset_channel_p[1]}]
set_property PACKAGE_PIN H12 [get_ports {passthru_chipset_channel_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_channel_p[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[3]}]
set_property PACKAGE_PIN L12 [get_ports {passthru_chipset_data_p[3]}]
set_property PACKAGE_PIN L13 [get_ports {passthru_chipset_data_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_credit_back_n[0]}]
set_property PACKAGE_PIN K13 [get_ports {chipset_passthru_credit_back_p[0]}]
set_property PACKAGE_PIN J13 [get_ports {chipset_passthru_credit_back_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_credit_back_p[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_channel_n[0]}]
set_property PACKAGE_PIN D12 [get_ports {passthru_chipset_channel_p[0]}]
set_property PACKAGE_PIN D13 [get_ports {passthru_chipset_channel_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_channel_p[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_n[5]}]
set_property PACKAGE_PIN E14 [get_ports {passthru_chipset_data_p[5]}]
set_property PACKAGE_PIN E15 [get_ports {passthru_chipset_data_n[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {passthru_chipset_data_p[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_credit_back_n[2]}]
set_property PACKAGE_PIN E11 [get_ports {chipset_passthru_credit_back_n[2]}]
set_property PACKAGE_PIN F11 [get_ports {chipset_passthru_credit_back_p[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {chipset_passthru_credit_back_p[2]}]
set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS25 } [get_ports { F78_N }]; #IO_L24N_T3_18 Sch=fmc_hb_n[20]
set_property -dict { PACKAGE_PIN B14   IOSTANDARD LVCMOS25 } [get_ports { F78_P }]; #IO_L24P_T3_18 Sch=fmc_hb_p[20]
set_property -dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS25 } [get_ports { F79_N }]; #IO_L21N_T3_DQS_18 Sch=fmc_hb_n[21]
set_property -dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS25 } [get_ports { F79_P }]; #IO_L21P_T3_DQS_18 Sch=fmc_hb_p[21]


### False paths
set_clock_groups -name sync_gr1 -logically_exclusive -group [get_clocks chipset_clk_clk_mmcm] -group [get_clocks -include_generated_clocks mc_sys_clk_clk_mmcm]
set_false_path -from [get_clocks clk_osc_p] -to [get_clocks clk_osc_n]
set_false_path -from [get_clocks clk_osc_n] -to [get_clocks clk_osc_p]
#set_false_path -from [get_clocks chipset_clk_clk_mmcm] -to [get_clocks chipset_clk_mmcm_1]
#set_false_path -from [get_clocks chipset_clk_clk_mmcm_1] -to [get_clocks chipset_clk_clk_mmcm]
#set_false_path -from [get_clocks clk_pll_i_1] -to [get_clocks clk_pll_i]
#set_false_path -from [get_clocks clk_pll_i] -to [get_clocks clk_pll_i_1]
#set_false_path -from [get_clocks core_ref_clk_clk_mmcm] -to [get_clocks clk_pll_i_1]
#set_false_path -from [get_clocks clk_pll_i_1] -to [get_clocks core_ref_clk_clk_mmcm]




###############################################################






#set_false_path -from [get_clocks core_ref_clk_clk_mmcm_1] -to [get_clocks clk_pll_i]

#set_false_path -from [get_clocks core_ref_clk_clk_mmcm_1] -to [get_clocks clk_pll_i_1]

set_property LOC ILOGIC_X1Y119 [get_cells {chipset_impl/mc_top/mig_7series_0/u_mig_7series_0_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/gen_dqs_iobuf_HP.gen_dqs_iobuf[2].gen_dqs_diff.u_iddr_edge_det/u_phase_detector}]
set_property PACKAGE_PIN AG2 [get_ports {ddr_dqs_p[2]}]
set_property PACKAGE_PIN AH1 [get_ports {ddr_dqs_n[2]}]

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

#############################################
# SD Card Constraints for 25MHz
#############################################
create_generated_clock -name sd_fast_clk -source [get_pins clk_mmcm/sd_sys_clk] -divide_by 2 [get_pins chipset_impl/io_ctrl_top/piton_sd_top/sdc_controller/clock_divider0/fast_clk_reg/Q]
create_generated_clock -name sd_slow_clk -source [get_pins clk_mmcm/sd_sys_clk] -divide_by 200 [get_pins chipset_impl/io_ctrl_top/piton_sd_top/sdc_controller/clock_divider0/slow_clk_reg/Q]
create_generated_clock -name sd_clk_out -source [get_pins sd_clk_oddr/C] -divide_by 1 -add -master_clock sd_fast_clk [get_ports sd_clk_out]
create_generated_clock -name sd_clk_out_1 -source [get_pins sd_clk_oddr/C] -divide_by 1 -add -master_clock sd_slow_clk [get_ports sd_clk_out]
create_clock -period 40.000 -name VIRTUAL_sd_fast_clk -waveform {0.000 20.000}
create_clock -period 4000.000 -name VIRTUAL_sd_slow_clk -waveform {0.000 2000.000}
set_output_delay -clock [get_clocks sd_clk_out] -min -add_delay 5.000 [get_ports {sd_dat[*]}]
set_output_delay -clock [get_clocks sd_clk_out] -max -add_delay 15.000 [get_ports {sd_dat[*]}]
set_output_delay -clock [get_clocks sd_clk_out_1] -min -add_delay 5.000 [get_ports {sd_dat[*]}]
set_output_delay -clock [get_clocks sd_clk_out_1] -max -add_delay 1500.000 [get_ports {sd_dat[*]}]
set_output_delay -clock [get_clocks sd_clk_out] -min -add_delay 5.000 [get_ports sd_cmd]
set_output_delay -clock [get_clocks sd_clk_out] -max -add_delay 15.000 [get_ports sd_cmd]
set_output_delay -clock [get_clocks sd_clk_out_1] -min -add_delay 5.000 [get_ports sd_cmd]
set_output_delay -clock [get_clocks sd_clk_out_1] -max -add_delay 1500.000 [get_ports sd_cmd]
set_input_delay -clock [get_clocks VIRTUAL_sd_fast_clk] -min -add_delay 20.000 [get_ports {sd_dat[*]}]
set_input_delay -clock [get_clocks VIRTUAL_sd_fast_clk] -max -add_delay 35.000 [get_ports {sd_dat[*]}]
set_input_delay -clock [get_clocks VIRTUAL_sd_slow_clk] -min -add_delay 2000.000 [get_ports {sd_dat[*]}]
set_input_delay -clock [get_clocks VIRTUAL_sd_slow_clk] -max -add_delay 3500.000 [get_ports {sd_dat[*]}]
set_input_delay -clock [get_clocks VIRTUAL_sd_fast_clk] -min -add_delay 20.000 [get_ports sd_cmd]
set_input_delay -clock [get_clocks VIRTUAL_sd_fast_clk] -max -add_delay 35.000 [get_ports sd_cmd]
set_input_delay -clock [get_clocks VIRTUAL_sd_slow_clk] -min -add_delay 2000.000 [get_ports sd_cmd]
set_input_delay -clock [get_clocks VIRTUAL_sd_slow_clk] -max -add_delay 3500.000 [get_ports sd_cmd]
set_clock_groups -physically_exclusive -group [get_clocks -include_generated_clocks sd_clk_out] -group [get_clocks -include_generated_clocks sd_clk_out_1]
set_clock_groups -logically_exclusive -group [get_clocks -include_generated_clocks {VIRTUAL_sd_fast_clk sd_fast_clk}] -group [get_clocks -include_generated_clocks {sd_slow_clk VIRTUAL_sd_slow_clk}]
set_clock_groups -asynchronous -group [get_clocks [list [get_clocks -of_objects [get_pins clk_mmcm/chipset_clk]]]] -group [get_clocks -filter { NAME =~  "*sd*" }]