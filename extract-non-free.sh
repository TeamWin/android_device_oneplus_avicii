#!/bin/sh

go() {
	popd 2>/dev/null >/dev/null
	mkdir -p "$1"
	pushd "$1" >/dev/null
}

rm -rf non-free/recovery/root
mkdir -p non-free/recovery/root
cd non-free/recovery/root

# vibrator firmware
go vendor/firmware
for x in aw8697_haptic_166.bin aw8697_haptic_168.bin aw8697_haptic_170.bin aw8697_haptic_172.bin aw8697_haptic_174.bin aw8697_haptic.bin aw8697_rtp.bin aw8697_rtp_lighthouse.bin aw8697_rtp_silk.bin
do
	cp "$1/vendor/firmware/$x" .
done

# binaries
go system/bin
for x in android.hardware.keymaster@4.0-service-qti android.hardware.keymaster@4.1-service-qti android.hardware.gatekeeper@1.0-service-qti
do
	cp "$1/vendor/bin/hw/$x" .
done
for x in qseecomd
do
	cp "$1/vendor/bin/$x" .
done

# for qseecomd
go system/lib64
for x in libQSEEComAPI.so libdrmfs.so libdiag.so libssd.so librpmb.so libqdutils.so
do
	cp "$1/vendor/lib64/$x" .
done

# for gatekeeper
go system/lib64/hw
for x in android.hardware.gatekeeper@1.0-impl-qti.so
do
	cp "$1/vendor/lib64/hw/$x" .
done
go system/lib64
for x in libqtikeymaster4.so libkeymasterdeviceutils.so libkeymasterutils.so libqcbor.so
do
	cp "$1/vendor/lib64/$x" .
done

# for qseecomd
go vendor/etc
for x in gpfspath_oem_config.xml
do
	cp "$1/vendor/etc/$x" .
done

# for android.hardware.boot@1.1
go system/lib64/hw
for x in android.hardware.boot@1.0-impl-1.1-qti.so
do
	cp "$1/vendor/lib64/hw/$x" .
done
go system/lib64
for x in libboot_control_qti.so librecovery_updater.so
do
	cp "$1/vendor/lib64/$x" .
done
