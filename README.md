# kalibrate-rtl_openwrt
compile kalibrate-rtl on openwrt

about kalibrate-rtl: https://github.com/steve-m/kalibrate-rtl

1、before your build kalibrate-rtl on openwrt , you must setup a linux compile environment with automake.

2、then create a directory , such as : ~/openwrt/package/kalibrate-rtl

3、download the Makefile into ~/openwrt/package/kalibrate-rtl

4、make menuconfig

5、select Utilities->kalibrate-rtl as a module package : [M]

6、make V=99
