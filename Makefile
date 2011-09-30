GO_EASY_ON_ME = 1
include theos/makefiles/common.mk

TWEAK_NAME = LSMusicGestures
LSMusicGestures_FILES = Tweak.xm
LSMusicGestures_FRAMEWORKS = UIKit CoreGraphics
include $(THEOS_MAKE_PATH)/tweak.mk
