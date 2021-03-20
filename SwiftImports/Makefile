.PHONY: develop
develop:
	swift package generate-xcodeproj --xcconfig-overrides settings.xcconfig
	(killall -9 Xcode && sleep 0.25) || true # Kills Xcode and waits for the process to terminate if Xcode is open.
	open SwiftImports.xcodeproj
