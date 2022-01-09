- udevがなかった
  - https://note.spage.jp/archives/233
- dockerとkubeletのcgroup統一
  - https://stackoverflow.com/questions/45708175/kubelet-failed-with-kubelet-cgroup-driver-cgroupfs-is-different-from-docker-c
  - https://kubernetes.io/ja/docs/setup/production-environment/container-runtimes/
- ClusterConfigはyaml作ったほうが楽だった
  - https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/control-plane-flags/
- MasterNodeセットアップ
```
kubeadm init --config=/kubeadm.conf
```
- kubeconfigセットアップ
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
- WorkerNodeセットアップ
  - MasterNodeセットアップ後に表示されるので基本それをコピーかな
```
kubeadm join 10.0.0.2:6443 --token xxxx \
        --discovery-token-ca-cert-hash xxxx
```
- ネットワークアドオン
```
 kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
 kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
```