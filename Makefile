export TWEAK_NAME = Frame

ifeq ($(SIMULATOR), 1)
    export ARCHS = arm64
    export TARGET = simulator:clang:17.2:14.0
else
    export ARCHS = arm64 arm64e
	export TARGET = iphone:16.5:14.0
endif

INSTALL_TARGET_PROCESSES = SpringBoard

SUBPROJECTS += Tweak Preferences

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

sim:: clean all package
	@echo "Cleaning Tweak..."
	sudo rm -f /opt/simject/Library/MobileSubstrate/DynamicLibraries/$(TWEAK_NAME).dylib
	sudo rm -f /opt/simject/Library/MobileSubstrate/DynamicLibraries/$(TWEAK_NAME).plist
	@echo "Cleaning Preferences..."
	sudo rm -rf /opt/simject/Library/PreferenceBundles/$(TWEAK_NAME)Preferences.bundle
	sudo rm -f /opt/simject/Library/PreferenceLoader/Preferences/$(TWEAK_NAME)Preferences.plist
	@echo "Copying Tweak..."
	sudo cp -f .theos/_/Library/MobileSubstrate/DynamicLibraries/$(TWEAK_NAME).dylib /opt/simject/Library/MobileSubstrate/DynamicLibraries/$(TWEAK_NAME).dylib
	sudo cp -f .theos/_/Library/MobileSubstrate/DynamicLibraries/$(TWEAK_NAME).plist /opt/simject/Library/MobileSubstrate/DynamicLibraries/$(TWEAK_NAME).plist
	@echo "Copying Preferences..."
	sudo cp -rf .theos/_/Library/PreferenceBundles/$(TWEAK_NAME)Preferences.bundle /opt/simject/Library/PreferenceBundles/$(TWEAK_NAME)Preferences.bundle
	sudo cp -f .theos/_/Library/PreferenceLoader/Preferences/$(TWEAK_NAME)Preferences.plist /opt/simject/Library/PreferenceLoader/Preferences/$(TWEAK_NAME)Preferences.plist
	@echo "Respringing simulator..."
	resim
