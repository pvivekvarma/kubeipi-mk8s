sudo snap install microk8s --classic --channel=1.20/stable

# Add permissions to user
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube 
su - $USER

sudo apt-get install iptables-persistent
# Rules will be stored at /etc/iptables/rules.v4

sudo ufw allow in on vxlan.calico && sudo ufw allow out on vxlan.calico

echo "Exposing secure port 16443"
sudo ufw allow 16443

microk8s.kubectl cluster-info | grep -qE "running at" && echo "MicroK8s installed successfully!"
microk8s.enable dashboard

token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token

echo "Edit /var/snap/microk8s/current/args/kube-apiserver and set the --insecure-bind-address=127.0.0.1 to 0.0.0.0. Then restart MicroK8s with microk8s.stop and microk8s.start."