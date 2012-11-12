#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

if [ "X`grep "Description:" $deb_dir/DEBIAN/control`" = "X" ]
then
	echo "Description: Firmware-tools Inventory/Execution module plugin for Broadcom nic firmware." >> $deb_dir/DEBIAN/control
fi

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
        echo "Depends: dell-ft-ie-interface, dell-ie-bios, libgcc1, libc6, tcl8.4" >> $deb_dir/DEBIAN/control
fi

cat << EOF > $deb_dir/usr/libexec/dell_dup/BROADCOM_FRMW/brcm_pci.ids
14e4  Broadcom Corporation
	0800  Sentry5 Chipcommon I/O Controller
	0804  Sentry5 PCI Bridge
	0805  Sentry5 MIPS32 CPU
	0806  Sentry5 Ethernet Controller
	080b  Sentry5 Crypto Accelerator
	080f  Sentry5 DDR/SDR RAM Controller
	0811  Sentry5 External Interface Core
	0816  BCM3302 Sentry5 MIPS32 CPU
	1600  NetXtreme BCM5752 Gigabit Ethernet PCI Express
		107b 5048  E4500 Onboard
	1601  NetXtreme BCM5752M Gigabit Ethernet PCI Express
	1639  NetXtreme II BCM5709 Gigabit Ethernet
	163a  NetXtreme II BCM5709S Gigabit Ethernet
	163b  NetXtreme II BCM5716 Gigabit Ethernet
	163c  NetXtreme II BCM5716S Gigabit Ethernet
	1644  NetXtreme BCM5700 Gigabit Ethernet
		1014 0277  Broadcom Vigil B5700 1000Base-T
		1028 00d1  Broadcom BCM5700
		1028 0106  Broadcom BCM5700
		1028 0109  Broadcom BCM5700 1000Base-T
		1028 010a  Broadcom BCM5700 1000BaseTX
		10b7 1000  3C996-T 1000Base-T
		10b7 1001  3C996B-T 1000Base-T
		10b7 1002  3C996C-T 1000Base-T
		10b7 1003  3C997-T 1000Base-T Dual Port
		10b7 1004  3C996-SX 1000Base-SX
		10b7 1005  3C997-SX 1000Base-SX Dual Port
		10b7 1008  3C942 Gigabit LOM (31X31)
		14e4 0002  NetXtreme 1000Base-SX
		14e4 0003  NetXtreme 1000Base-SX
		14e4 0004  NetXtreme 1000Base-T
		14e4 1028  NetXtreme 1000BaseTX
		14e4 1644  BCM5700 1000Base-T
	1645  NetXtreme BCM5701 Gigabit Ethernet
		0e11 007c  NC7770 Gigabit Server Adapter (PCI-X, 10/100/1000-T)
		0e11 007d  NC6770 Gigabit Server Adapter (PCI-X, 1000-SX)
		0e11 0085  NC7780 Gigabit Server Adapter (embedded, WOL)
		0e11 0099  NC7780 Gigabit Server Adapter (embedded, WOL)
		0e11 009a  NC7770 Gigabit Server Adapter (PCI-X, 10/100/1000-T)
		0e11 00c1  NC6770 Gigabit Server Adapter (PCI-X, 1000-SX)
		1028 0121  Broadcom BCM5701 1000Base-T
		103c 128a  1000Base-T (PCI) [A7061A]
		103c 128b  1000Base-SX (PCI) [A7073A]
		103c 12a4  Core Lan 1000Base-T
		103c 12c1  IOX Core Lan 1000Base-T [A7109AX]
		103c 1300  Core LAN/SCSI Combo [A6794A]
		10a9 8010  IO9/IO10 Gigabit Ethernet (Copper)
		10a9 8011  Gigabit Ethernet (Copper)
		10a9 8012  Gigabit Ethernet (Fiber)
		10b7 1004  3C996-SX 1000Base-SX
		10b7 1006  3C996B-T 1000Base-T
		10b7 1007  3C1000-T 1000Base-T
		10b7 1008  3C940-BR01 1000Base-T
		14e4 0001  BCM5701 1000Base-T
		14e4 0005  BCM5701 1000Base-T
		14e4 0006  BCM5701 1000Base-T
		14e4 0007  BCM5701 1000Base-SX
		14e4 0008  BCM5701 1000Base-T
		14e4 8008  BCM5701 1000Base-T
	1646  NetXtreme BCM5702 Gigabit Ethernet
		0e11 00bb  NC7760 1000BaseTX
		1028 0126  Broadcom BCM5702 1000BaseTX
		14e4 8009  BCM5702 1000BaseTX
	1647  NetXtreme BCM5703 Gigabit Ethernet
		0e11 0099  NC7780 1000BaseTX
		0e11 009a  NC7770 1000BaseTX
		10a9 8010  SGI IO9 Gigabit Ethernet (Copper)
		14e4 0009  BCM5703 1000BaseTX
		14e4 000a  BCM5703 1000BaseSX
		14e4 000b  BCM5703 1000BaseTX
		14e4 8009  BCM5703 1000BaseTX
		14e4 800a  BCM5703 1000BaseTX
	1648  NetXtreme BCM5704 Gigabit Ethernet
		0e11 00cf  NC7772 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
		0e11 00d0  NC7782 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
		0e11 00d1  NC7783 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
		10a9 8013  Dual Port Gigabit Ethernet (PCI-X,Copper)
		10a9 8018  Dual Port Gigabit Ethernet (A330)
		10a9 801a  Dual Port Gigabit Ethernet (IA-blade)
		10a9 801b  Quad Port Gigabit Ethernet (PCI-E,Copper)
		10b7 2000  3C998-T Dual Port 10/100/1000 PCI-X
		10b7 3000  3C999-T Quad Port 10/100/1000 PCI-X
		1166 1648  NetXtreme CIOB-E 1000Base-T
		1734 100b  Primergy RX300
	164a  NetXtreme II BCM5706 Gigabit Ethernet
		103c 3070  NC380T PCI Express Dual Port Multifunction Gigabit Server Adapter
		103c 3101  NC370T MultifuNCtion Gigabit Server Adapter
	164c  NetXtreme II BCM5708 Gigabit Ethernet
		103c 7037  NC373T PCI Express Multifunction Gigabit Server Adapter
		103c 7038  NC373i Integrated Multifunction Gigabit Server Adapter
	164d  NetXtreme BCM5702FE Gigabit Ethernet
	164e  NetXtreme II BCM57710 10Gigabit PCIe
	164f  NetXtreme II BCM57711 10Gigabit PCIe
	1650  NetXtreme II BCM57711E 10Gigabit PCIe
	1653  NetXtreme BCM5705 Gigabit Ethernet
		0e11 00e3  NC7761 Gigabit Server Adapter
	1654  NetXtreme BCM5705_2 Gigabit Ethernet
		0e11 00e3  NC7761 Gigabit Server Adapter
		103c 3100  NC1020 ProLiant Gigabit Server Adapter 32 PCI
		103c 3226  NC150T 4-port Gigabit Combo Switch & Adapter
    1655  NetXtreme BCM5717 Gigabit Ethernet PCIe
    1656  NetXtreme BCM5718 Gigabit Ethernet PCIe
    1657  NetXtreme BCM5719 Gigabit Ethernet PCIe
	1659  NetXtreme BCM5721 Gigabit Ethernet PCI Express
		1014 02c6  eServer xSeries server mainboard
		103c 7031  NC320T PCIe Gigabit Server Adapter
		103c 7032  NC320i PCIe Gigabit Server Adapter
		1734 1061  Primergy RX300 S2
	165a  NetXtreme BCM5722 Gigabit Ethernet PCI Express
	165b  NetXtreme BCM5723 Gigabit Ethernet PCIe
	165d  NetXtreme BCM5705M Gigabit Ethernet
		1028 865d  Latitude D400
	165e  NetXtreme BCM5705M_2 Gigabit Ethernet
		103c 088c  NC8000 laptop
		103c 0890  NC6000 laptop
		103c 099c  NX6110/NC6120
    165f  NetXtreme BCM5720 Gigabit Ethernet PCIe
    1662  NetXtreme II BCM57712 10Gigabit PCIe
    1663  NetXtreme II BCM57712E 10Gigabit PCIe
	1668  NetXtreme BCM5714 Gigabit Ethernet
		103c 7039  NC324i PCIe Dual Port Gigabit Server Adapter
	1669  NetXtreme 5714S Gigabit Ethernet
	166a  NetXtreme BCM5780 Gigabit Ethernet
	166b  NetXtreme BCM5780S Gigabit Ethernet
	166e  570x 10/100 Integrated Controller
	1672  NetXtreme BCM5754M Gigabit Ethernet PCI Express
	1673  NetXtreme BCM5755M Gigabit Ethernet PCI Express
	1674  NetXtreme BCM5756ME Gigabit Ethernet PCI Express
	1677  NetXtreme BCM5751 Gigabit Ethernet PCI Express
		1028 0179  Optiplex GX280
		1028 0182  Latitude D610
		1028 0187  Precision M70
		1028 01ad  Optiplex GX620
		103c 3006  DC7100 SFF(DX878AV)
		1734 105d  Scenic W620
	1678  NetXtreme BCM5715 Gigabit Ethernet
	1679  NetXtreme BCM5715S Gigabit Ethernet
		103c 1707  NC326m PCIe Dual Port Adapter
		103c 170c  NC325m PCIe Quad Port Adapter
		103c 703c  NC326i PCIe Dual Port Gigabit Server Adapter
	167a  NetXtreme BCM5754 Gigabit Ethernet PCI Express
	167b  NetXtreme BCM5755 Gigabit Ethernet PCI Express
	167d  NetXtreme BCM5751M Gigabit Ethernet PCI Express
		17aa 2081  Thinkpad R60e model 0657
	167e  NetXtreme BCM5751F Fast Ethernet PCI Express
	167f  NetLink BCM5787F Fast Ethernet PCI Express
	1680  NetXtreme BCM5761e Gigabit Ethernet PCIe
	1681  NetXtreme BCM5761 Gigabit Ethernet PCIe
	1682  NetXtreme BCM57762 Gigabit Ethernet PCIe
	1684  NetXtreme BCM5764M Gigabit Ethernet PCIe
	1686  NetXtreme BCM57766 Gigabit Ethernet PCIe
	1688  NetXtreme BCM5761S Gigabit Ethernet PCIe
	168a  NetXtreme II BCM57800 10 Gigabit Ethernet PCIe
	168d  NetXtreme II BCM57840 20 Gigabit Ethernet PCIe
	168e  NetXtreme II BCM57810 10 Gigabit Ethernet PCIe
	1690  NetXtreme BCM57760 Gigabit Ethernet PCIe
	1691  NetLink BCM57788 Gigabit Ethernet PCIe
	1692  NetLink BCM57780 Gigabit Ethernet PCIe
	1693  NetLink BCM5787M Gigabit Ethernet PCI Express
	1694  NetLink BCM57790 Gigabit Ethernet PCIe
	1696  NetXtreme BCM5782 Gigabit Ethernet
		103c 12bc  d530 CMT (DG746A)
		14e4 000d  NetXtreme BCM5782 1000Base-T
	1698  NetLink BCM5784M Gigabit Ethernet PCIe
	1699  NetLink BCM5785 Gigabit Ethernet
	16a0  NetLink BCM5785 Fast Ethernet
	169a  NetLink BCM5786 Gigabit Ethernet PCI Express
	169b  NetLink BCM5787 Gigabit Ethernet PCI Express
	169c  NetXtreme BCM5788 Gigabit Ethernet
		103c 308b  MX6125
	169d  NetLink BCM5789 Gigabit Ethernet PCI Express
	16a5  NetXtreme II BCM57800 10 Gigabit Ethernet PCIe
	16a6  NetXtreme BCM5702X Gigabit Ethernet
		0e11 00bb  NC7760 Gigabit Server Adapter (PCI-X, 10/100/1000-T)
		1028 0126  BCM5702 1000Base-T
		14e4 000c  BCM5702 1000Base-T
		14e4 8009  BCM5702 1000Base-T
	16a7  NetXtreme BCM5703X Gigabit Ethernet
		0e11 00ca  NC7771 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
		0e11 00cb  NC7781 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
		14e4 0009  NetXtreme BCM5703 1000Base-T
		14e4 000a  NetXtreme BCM5703 1000Base-SX
		14e4 000b  NetXtreme BCM5703 1000Base-T
		14e4 800a  NetXtreme BCM5703 1000Base-T
	16a8  NetXtreme BCM5704S Gigabit Ethernet
		10a9 8014  Dual Port Gigabit Ethernet (PCI-X,Fiber)
		10a9 801c  Quad Port Gigabit Ethernet (PCI-E,Fiber)
		10b7 2001  3C998-SX Dual Port 1000-SX PCI-X
	16aa  NetXtreme II BCM5706S Gigabit Ethernet
		103c 3102  NC370F MultifuNCtion Gigabit Server Adapter
	16ab  NetXtreme II BCM57840 20 Gigabit Ethernet PCIe
	16ac  NetXtreme II BCM5708S Gigabit Ethernet
		103c 1706  NC373m Multifunction Gigabit Server Adapter
		103c 703b  NC373i Integrated Multifunction Gigabit Server Adapter
		103c 703d  NC373F PCI Express Multifunction Gigabit Server Adapter
	16ae  NetXtreme II BCM57810 10 Gigabit Ethernet PCIe
    16b0  NetXtreme BCM57761 Gigabit Ethernet PCIe
    16b1  NetLink BCM57781 Gigabit Ethernet PCIe
    16b2  NetLink BCM57791 Fast Ethernet PCIe
    16b3  NetXtreme BCM57786x Gigabit Ethernet PCIe
    16b4  NetXtreme BCM57765 Gigabit Ethernet PCIe
    16b5  NetLink BCM57785 Gigabit Ethernet PCIe
    16b6  NetLink BCM57795 Fast Ethernet PCIe
    16b7  NetXtreme BCM57782 Gigabit Ethernet PCIe
	16c6  NetXtreme BCM5702A3 Gigabit Ethernet
		10b7 1100  3C1000B-T 10/100/1000 PCI
		14e4 000c  BCM5702 1000Base-T
		14e4 8009  BCM5702 1000Base-T
	16c7  NetXtreme BCM5703 Gigabit Ethernet
		0e11 00ca  NC7771 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
		0e11 00cb  NC7781 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
		103c 12c3  Combo FC/GigE-SX [A9782A]
		103c 12ca  Combo FC/GigE-T [A9784A]
		14e4 0009  NetXtreme BCM5703 1000Base-T
		14e4 000a  NetXtreme BCM5703 1000Base-SX
	16dd  NetLink BCM5781 Gigabit Ethernet PCI Express
	16f7  NetXtreme BCM5753 Gigabit Ethernet PCI Express
	16fd  NetXtreme BCM5753M Gigabit Ethernet PCI Express
	16fe  NetXtreme BCM5753F Fast Ethernet PCI Express
	170c  BCM4401-B0 100Base-TX
		1028 0188  Inspiron 6000 laptop
		1028 0196  Inspiron 5160
		103c 099c  NX6110/NC6120
	170d  NetXtreme BCM5901 100Base-TX
		1014 0545  ThinkPad R40e (2684-HVG) builtin ethernet controller
	170e  NetXtreme BCM5901 100Base-TX
	1712  NetLink BCM5906 Fast Ethernet PCI Express
	1713  NetLink BCM5906M Fast Ethernet PCI Express
	3352  BCM3352
	3360  BCM3360
	4210  BCM4210 iLine10 HomePNA 2.0
	4211  BCM4211 iLine10 HomePNA 2.0 + V.90 56k modem
	4212  BCM4212 v.90 56k modem
	4301  BCM4303 802.11b Wireless LAN Controller
		1028 0407  TrueMobile 1180 Onboard WLAN
		1043 0120  WL-103b Wireless LAN PC Card
	4305  BCM4307 V.90 56k Modem
	4306  BCM4307 Ethernet Controller
	4307  BCM4307 802.11b Wireless LAN Controller
	4310  BCM4310 Chipcommon I/OController
	4311  Dell Wireless 1390 WLAN Mini-PCI Card
	4312  BCM4310 UART
	4313  BCM4310 Ethernet Controller
	4315  BCM4310 USB Controller
	4318  BCM4318 [AirForce One 54g] 802.11g Wireless LAN Controller
		103c 1356  MX6125
		1043 120f  A6U notebook embedded card
		1468 0311  Aspire 3022WLMi, 5024WLMi
		1468 0312  TravelMate 2410
		14e4 0449  Gateway 7510GX
		14e4 4318  WPC54G version 3 [Wireless-G Notebook Adapter] 802.11g Wireless Lan Controller
		16ec 0119  U.S.Robotics Wireless MAXg PC Card
		1737 0048  WPC54G-EU version 3 [Wireless-G Notebook Adapter]
	4319  BCM4311 [AirForce 54g] 802.11a/b/g PCI Express Transceiver
	4320  BCM4306 802.11b/g Wireless LAN Controller
		1028 0001  TrueMobile 1300 WLAN Mini-PCI Card
		1028 0003  Wireless 1350 WLAN Mini-PCI Card
		103c 12f4  NX9500 Built-in Wireless
		103c 12fa  Presario R3000 802.11b/g
		1043 100f  WL-100G
		1057 7025  WN825G
		106b 004e  AirPort Extreme
		1154 0330  Buffalo WLI2-PCI-G54S High Speed Mode Wireless Desktop Adapter
		144f 7050  eMachines M6805 802.11g Built-in Wireless
		14e4 4320  Linksys WMP54G PCI
		1737 4320  WPC54G
		1799 7001  Belkin F5D7001 High-Speed Mode Wireless G Network Card
		1799 7010  Belkin F5D7010 54g Wireless Network card
		1799 7011  F5D7011 54g+ Wireless Network card
		185f 1220  TravelMate 290E WLAN Mini-PCI Card
	4321  BCM4306 802.11a Wireless LAN Controller
	4322  BCM4306 UART
	4324  BCM4309 802.11a/b/g
		1028 0001  Truemobile 1400
		1028 0003  Truemobile 1450 MiniPCI
	4325  BCM43xG 802.11b/g
		1414 0003  Wireless Notebook Adapter MN-720
		1414 0004  Wireless PCI Adapter MN-730
	4326  BCM4307 Chipcommon I/O Controller?
	4329  BCM43XG
	4401  BCM4401 100Base-T
		103c 08b0  tc1100 tablet
		1043 80a8  A7V8X motherboard
	4402  BCM4402 Integrated 10/100BaseT
	4403  BCM4402 V.90 56k Modem
	4410  BCM4413 iLine32 HomePNA 2.0
	4411  BCM4413 V.90 56k modem
	4412  BCM4412 10/100BaseT
	4430  BCM44xx CardBus iLine32 HomePNA 2.0
	4432  BCM4432 CardBus 10/100BaseT
	4610  BCM4610 Sentry5 PCI to SB Bridge
	4611  BCM4610 Sentry5 iLine32 HomePNA 1.0
	4612  BCM4610 Sentry5 V.90 56k Modem
	4613  BCM4610 Sentry5 Ethernet Controller
	4614  BCM4610 Sentry5 External Interface
	4615  BCM4610 Sentry5 USB Controller
	4704  BCM4704 PCI to SB Bridge
	4705  BCM4704 Sentry5 802.11b Wireless LAN Controller
	4706  BCM4704 Sentry5 Ethernet Controller
	4707  BCM4704 Sentry5 USB Controller
	4708  BCM4704 Crypto Accelerator
	4710  BCM4710 Sentry5 PCI to SB Bridge
	4711  BCM47xx Sentry5 iLine32 HomePNA 2.0
	4712  BCM47xx V.92 56k modem
	4713  Sentry5 Ethernet Controller
	4714  BCM47xx Sentry5 External Interface
	4715  Sentry5 USB Controller
	4716  BCM47xx Sentry5 USB Host Controller
	4717  BCM47xx Sentry5 USB Device Controller
	4718  Sentry5 Crypto Accelerator
	4719  BCM47xx/53xx RoboSwitch Core
	4720  BCM4712 MIPS CPU
	5365  BCM5365P Sentry5 Host Bridge
	5600  BCM5600 StrataSwitch 24+2 Ethernet Switch Controller
	5605  BCM5605 StrataSwitch 24+2 Ethernet Switch Controller
	5615  BCM5615 StrataSwitch 24+2 Ethernet Switch Controller
	5625  BCM5625 StrataSwitch 24+2 Ethernet Switch Controller
	5645  BCM5645 StrataSwitch 24+2 Ethernet Switch Controller
	5670  BCM5670 8-Port 10GE Ethernet Switch Fabric
	5680  BCM5680 G-Switch 8 Port Gigabit Ethernet Switch Controller
	5690  BCM5690 12-port Multi-Layer Gigabit Ethernet Switch
	5691  BCM5691 GE/10GE 8+2 Gigabit Ethernet Switch Controller
	5692  BCM5692 12-port Multi-Layer Gigabit Ethernet Switch
	5820  BCM5820 Crypto Accelerator
	5821  BCM5821 Crypto Accelerator
	5822  BCM5822 Crypto Accelerator
	5823  BCM5823 Crypto Accelerator
	5824  BCM5824 Crypto Accelerator
	5840  BCM5840 Crypto Accelerator
	5841  BCM5841 Crypto Accelerator
	5850  BCM5850 Crypto Accelerator
EOF
