- udevがなかった
  - https://note.spage.jp/archives/233
- dockerとkubeletのcgroup統一
  - https://stackoverflow.com/questions/45708175/kubelet-failed-with-kubelet-cgroup-driver-cgroupfs-is-different-from-docker-c
  - https://kubernetes.io/ja/docs/setup/production-environment/container-runtimes/
- ClusterConfigはyaml作ったほうが楽だった
  - https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/control-plane-flags/
- ネットワークアドオン
```
 kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
 kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
```