include $(TOPDIR)/rules.mk

PKG_NAME:=kalibrate-rtl
PKG_VERSION:=0.4.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/steve-m/kalibrate-rtl.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=master
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=Joshua Lackey (jl@thre.at)
#PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
#include $(INCLUDE_DIR)/cmake.mk

define Package/kalibrate-rtl/Default
  TITLE:=Kalibrate, or kal, can scan for GSM base stations in a given frequency band
  URL:=https://github.com/steve-m/kalibrate-rtl.git
endef

define Build/Prepare
        mkdir -p $(PKG_BUILD_DIR)
        $(CP) /home/openwrt/tmp/kalibrate-rtl/* $(PKG_BUILD_DIR)/
        (cd $(PKG_BUILD_DIR) && ./bootstrap)
endef

define  Build/Configure
#  $(PKG_BUILD_DIR)/configrue
        $(Build/Configure/Default)
endef

define Package/kalibrate-rtl
  $(call Package/kalibrate-rtl/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+fftw3 +librtlsdr
endef

define Package/kalibrate-rtl/description
  Kalibrate, or kal, can scan for GSM base stations in a given frequency band and
  can use those GSM base stations to calculate the local oscillator frequency
offset.

  See http://thre.at/kalibrate

  Copyright (c) 2010, Joshua Lackey (jl@thre.at)

  modified for use with rtl-sdr devices,
  Copyright (c) 2012, Steve Markgraf (steve@steve-m.de)
endef

#define Package/kalibrate-rtl/conffiles
#  /etc/config/kalibrate-rtl
#endef

define Package/kalibrate-rtl/install
        $(INSTALL_DIR) $(1)/usr/bin
        $(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin
#       $(INSTALL_DIR) $(1)/etc/multimon-ng
#       $(INSTALL_DATA) ./files/multimon-ng.template $(1)/etc/multimon-ng/config.template
endef

$(eval $(call BuildPackage,kalibrate-rtl))
