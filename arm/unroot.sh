##########################################################################################
# Unroot Script
##########################################################################################

# Define the files that we are going to delete.
ROOT_FILES="
system/xbin/su
system/xbin/daemonsu
system/xbin/supolicy
system/lib/libsupol.so
system/bin/app_process_init
system/bin/app_process
system/bin/app_process32_original"

# Mount system as read-write.
mount -o remount -rw /system

# Delete the root files.
rm $ROOT_FILES

# Restore original app_process.
mv /system/bin/app_process_original /system/bin/app_process
mv /system/bin/app_process_original32 /system/bin/app_process32 

# Set correct permissions to app_process to satisfy SELinux.
chcon u:object_r:zygote_exec:s0 /system/bin/app_process32
chcon u:object_r:system_file:s0 /system/bin/app_process
