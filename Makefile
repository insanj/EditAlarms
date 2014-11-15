THEOS_PACKAGE_DIR_NAME = debs
TARGET = :clang
ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = EditAlarms
EditAlarms_FILES = Tweak.xm
EditAlarms_FRAMEWORKS = Foundation UIKit 

include $(THEOS_MAKE_PATH)/tweak.mk

internal-after-install::
	install.exec "killall -9 MobileTimer"
	