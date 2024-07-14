# Makefile

 cluster create: k3d cluster create k3s-default                                                                                                                                                                                                   
                --api-port 6550 -p '80:80@loadbalancer' -p '443:443@loadbalancer' --servers 1 --k3s-arg '--disable=traefik@server:*'


install-istio:
    kubectl create namespace istio-system
    helm install istio-base istio/base -n istio-system --wait
    helm install istiod istio/istiod -n istio-system --wait
    kubectl create namespace istio-ingress
    helm install istio-ingressgateway istio/gateway -n istio-ingress --wait


deployment dev: 
    kubectl get namespace dev-namespace || kubectl create namespace dev-namespace && \
    yq eval ".namespace = \"dev-namespace\"" -i overlays/kustomization.yaml && \
    yq eval ".images[0].newTag = \"1.20\"" -i overlays/kustomization.yaml && \
    yq eval '.spec.hosts[0] = "dev.localtest.me"' -i overlays/virtualservice-patch.yaml && \
    kubectl apply -k overlays/

deployment test:
    kubectl get namespace test-namespace || kubectl create namespace test-namespace && \
    yq eval ".namespace = \"test-namespace\"" -i overlays/kustomization.yaml && \
    yq eval ".images[0].newTag = \"1.21\"" -i overlays/kustomization.yaml && \
    yq eval '.spec.hosts[0] = "test.localtest.me"' -i overlays/virtualservice-patch.yaml && \
    kubectl apply -k overlays/






                    