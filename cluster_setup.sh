set -e
cd test-app

sudo docker build -t test_pod .
# sudo docker run --name podContainer  -p 5000:5000 test_pod

eksctl create cluster --name prometheus-test --region us-west-2
# Output:
#
# 2023-11-27 09:51:01 [ℹ]  eksctl version 0.164.0
# 2023-11-27 09:51:01 [ℹ]  using region us-west-2
# 2023-11-27 09:51:02 [ℹ]  setting availability zones to [us-west-2c us-west-2a us-west-2d]
# 2023-11-27 09:51:02 [ℹ]  subnets for us-west-2c - public:192.168.0.0/19 private:192.168.96.0/19
# 2023-11-27 09:51:02 [ℹ]  subnets for us-west-2a - public:192.168.32.0/19 private:192.168.128.0/19
# 2023-11-27 09:51:02 [ℹ]  subnets for us-west-2d - public:192.168.64.0/19 private:192.168.160.0/19
# 2023-11-27 09:51:02 [ℹ]  nodegroup "ng-075667a1" will use "" [AmazonLinux2/1.27]
# 2023-11-27 09:51:02 [ℹ]  using Kubernetes version 1.27
# 2023-11-27 09:51:02 [ℹ]  creating EKS cluster "prometheus-test" in "us-west-2" region with managed nodes
# 2023-11-27 09:51:02 [ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial managed nodegroup
# 2023-11-27 09:51:02 [ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=us-west-2 --cluster=prometheus-test'
# 2023-11-27 09:51:02 [ℹ]  Kubernetes API endpoint access will use default of {publicAccess=true, privateAccess=false} for cluster "prometheus-test" in "us-west-2"
# 2023-11-27 09:51:02 [ℹ]  CloudWatch logging will not be enabled for cluster "prometheus-test" in "us-west-2"
# 2023-11-27 09:51:02 [ℹ]  you can enable it with 'eksctl utils update-cluster-logging --enable-types={SPECIFY-YOUR-LOG-TYPES-HERE (e.g. all)} --region=us-west-2 --cluster=prometheus-test'
# 2023-11-27 09:51:02 [ℹ]  
# 2 sequential tasks: { create cluster control plane "prometheus-test", 
#     2 sequential sub-tasks: { 
#         wait for control plane to become ready,
#         create managed nodegroup "ng-075667a1",
#     } 
# }
# 2023-11-27 09:51:02 [ℹ]  building cluster stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:51:04 [ℹ]  deploying stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:51:34 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:52:04 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:53:05 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:54:06 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:55:07 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:56:08 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:57:09 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:58:10 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:59:10 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-cluster"
# 2023-11-27 10:01:18 [ℹ]  building managed nodegroup stack "eksctl-prometheus-test-nodegroup-ng-075667a1"
# 2023-11-27 10:01:19 [ℹ]  deploying stack "eksctl-prometheus-test-nodegroup-ng-075667a1"
# 2023-11-27 10:01:20 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-075667a1"
# 2023-11-27 10:01:51 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-075667a1"
# 2023-11-27 10:02:29 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-075667a1"
# 2023-11-27 10:04:12 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-075667a1"
# 2023-11-27 10:04:12 [ℹ]  waiting for the control plane to become ready
# 2023-11-27 10:04:12 [✔]  saved kubeconfig as "/home/bvu/.kube/config"
# 2023-11-27 10:04:12 [ℹ]  no tasks
# 2023-11-27 10:04:12 [✔]  all EKS cluster resources for "prometheus-test" have been created
# 2023-11-27 10:04:13 [ℹ]  nodegroup "ng-075667a1" has 2 node(s)
# 2023-11-27 10:04:13 [ℹ]  node "ip-192-168-27-211.us-west-2.compute.internal" is ready
# 2023-11-27 10:04:13 [ℹ]  node "ip-192-168-47-220.us-west-2.compute.internal" is ready
# 2023-11-27 10:04:13 [ℹ]  waiting for at least 2 node(s) to become ready in "ng-075667a1"
# 2023-11-27 10:04:14 [ℹ]  nodegroup "ng-075667a1" has 2 node(s)
# 2023-11-27 10:04:14 [ℹ]  node "ip-192-168-27-211.us-west-2.compute.internal" is ready
# 2023-11-27 10:04:14 [ℹ]  node "ip-192-168-47-220.us-west-2.compute.internal" is ready
# 2023-11-27 10:04:15 [ℹ]  kubectl command should work with "/home/bvu/.kube/config", try 'kubectl get nodes'
# 2023-11-27 10:04:15 [✔]  EKS cluster "prometheus-test" in "us-west-2" region is ready

echo "Check if cluster creation is succesfull..."
eksctl get cluster prometheus-test
# Output:
#
# NAME		VERSION	STATUS	CREATED			VPC			SUBNETS																	SECURITYGROUPS		PROVIDER
# prometheus-test	1.27	ACTIVE	2023-11-27T08:51:29Z	vpc-07db8e43971691554	subnet-0052fdb8d4da054ab,subnet-064b8c01edf004d35,subnet-0c6e65f8ce42114fa,subnet-0c96fd99723534cb5,subnet-0db7d4c5364565ab3,subnet-0e538a43029c6c181	sg-0815731b7e1ae0cba	EKS


# Now following this guide: https://docs.aws.amazon.com/eks/latest/userguide/sample-deployment.html

#############################
#     Upload Docker image   #
#############################

aws ecr get-login-password --region us-west-2 | sudo docker login --username AWS --password-stdin 234401896482.dkr.ecr.us-west-2.amazonaws.com
# Output:
#
# WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
# Configure a credential helper to remove this warning. See
# https://docs.docker.com/engine/reference/commandline/login/#credentials-store

# Login Succeeded

sudo docker tag test_pod:latest 234401896482.dkr.ecr.us-west-2.amazonaws.com/prometheus_test_pod

aws ecr create-repository --repository-name prometheus_test_pod

# Output:
#
# {
#     "repository": {
#         "repositoryArn": "arn:aws:ecr:us-west-2:234401896482:repository/prometheus_test_pod",
#         "registryId": "234401896482",
#         "repositoryName": "prometheus_test_pod",
#         "repositoryUri": "234401896482.dkr.ecr.us-west-2.amazonaws.com/prometheus_test_pod",
#         "createdAt": "2023-11-27T08:07:36+01:00",
#         "imageTagMutability": "MUTABLE",
#         "imageScanningConfiguration": {
#             "scanOnPush": false
#         },
#         "encryptionConfiguration": {
#             "encryptionType": "AES256"
#         }
#     }
# }


sudo docker push 234401896482.dkr.ecr.us-west-2.amazonaws.com/prometheus_test_pod


#############################
#     Configure kubernetes  #
#############################

kubectl create namespace prometheus-test
kubectl apply -f kubernetes/app.yml
# Output:
#
# service/prometheus-test-service created
# deployment.apps/prometheus-test-app configured

kubectl get all -n prometheus-test
# Output:
#
# NAME                                       READY   STATUS    RESTARTS   AGE
# pod/prometheus-test-app-646cd5cc78-9298j   1/1     Running   0          4m34s
# pod/prometheus-test-app-646cd5cc78-r4wbh   1/1     Running   0          4m34s
# pod/prometheus-test-app-646cd5cc78-scmd8   1/1     Running   0          4m34s

# NAME                              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
# service/kubernetes                ClusterIP   10.100.0.1      <none>        443/TCP   3d20h
# service/prometheus-test-service   ClusterIP   10.100.84.187   <none>        80/TCP    70s

# NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
# deployment.apps/prometheus-test-app   3/3     3            3           4m35s

# NAME                                             DESIRED   CURRENT   READY   AGE
# replicaset.apps/prometheus-test-app-646cd5cc78   3         3         3       4m35s

kubectl -n prometheus-test describe service prometheus-test-service
# Output:
#
# Name:              prometheus-test-service
# Namespace:         prometheus-test
# Labels:            app=prometheus-test-app
# Annotations:       <none>
# Selector:          app=prometheus-test-app
# Type:              ClusterIP
# IP Family Policy:  SingleStack
# IP Families:       IPv4
# IP:                10.100.84.187
# IPs:               10.100.84.187
# Port:              <unset>  80/TCP
# TargetPort:        5000/TCP
# Endpoints:         192.168.25.137:5000,192.168.30.107:5000,192.168.88.182:5000
# Session Affinity:  None
# Events:            <none>

export loadbalancer=$(kubectl -n prometheus-test get svc prometheus-test-service -o jsonpath='{.status.loadBalancer.ingress[*].hostname}')
curl -k -s http://${loadbalancer}/hello
# Output:
#
# {"msg":"Hello from Flask"}

