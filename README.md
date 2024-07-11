# kustomize-example

*k3d create cluster:*
 ```zsh 
 k3d cluster create k3s-default --api-port 6550 -p '80:80@loadbalancer' -p '443:443@loadbalancer' --servers 1 --k3s-arg '--disable=traefik@server:*'

```

`kubectl get svc -A`

*change image prod*

```zsh 
yq eval '.images[0].newTag = "1.21"' -i overlays/prod/kustomization.yaml && kubectl apply -k overlays/prod

```



*change image dev*

```zsh 
yq eval '.images[0].newTag = "1.20"' -i overlays/dev/kustomization.yaml && kubectl apply -k overlays/dev

```