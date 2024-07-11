# Makefile

 cluster create: k3d cluster create k3s-default                                                                                                                                                                                                   
                --api-port 6550 -p '80:80@loadbalancer' -p '443:443@loadbalancer' --servers 1 --k3s-arg '--disable=traefik@server:*'