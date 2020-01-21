python /root/ipmi.py off
export HOME=/root
export KUBECONFIG=/root/ocp/auth/kubeconfig
export OS_CLOUD=metal3-bootstrap
export OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE=registry.svc.ci.openshift.org/ocp/release:{{ tag }}
mkdir -p ocp/openshift
cp install-config.yaml ocp
openshift-baremetal-install --dir ocp --log-level debug create manifests
cp metal3-config.yaml ocp/openshift/99_metal3-config.yaml
cp manifests/* ocp/openshift/
openshift-baremetal-install --dir ocp --log-level debug create cluster
openshift-baremetal-install --dir ocp --log-level debug wait-for install-complete
openshift-baremetal-install --dir ocp --log-level debug wait-for install-complete
