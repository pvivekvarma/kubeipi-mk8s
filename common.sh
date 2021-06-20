cat /boot/firmware/cmdline.txt | grep -qE "\bcgroup_memory=1" || sudo sed -i '1s/^/cgroup_memory=1 /' /boot/firmware/cmdline.txt
cat /boot/firmware/cmdline.txt | grep -qE "\bcgroup_enable=memory" || sudo sed -i '1s/^/cgroup_enable=memory /' /boot/firmware/cmdline.txt

sudo reboot