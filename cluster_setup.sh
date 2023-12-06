set -e

source cluster_params.sh

cd test-app

sudo docker build -t test_pod .
# sudo docker run --name podContainer  -p 5000:5000 test_pod

eksctl create cluster --name $CLUSTER_NAME --region $REGION
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
eksctl get cluster $CLUSTER_NAME
# Output:
#
# NAME		VERSION	STATUS	CREATED			VPC			SUBNETS																	SECURITYGROUPS		PROVIDER
# $CLUSTER_NAME	1.27	ACTIVE	2023-11-27T08:51:29Z	vpc-07db8e43971691554	subnet-0052fdb8d4da054ab,subnet-064b8c01edf004d35,subnet-0c6e65f8ce42114fa,subnet-0c96fd99723534cb5,subnet-0db7d4c5364565ab3,subnet-0e538a43029c6c181	sg-0815731b7e1ae0cba	EKS


# Now following this guide: https://docs.aws.amazon.com/eks/latest/userguide/sample-deployment.html

#############################
#     Upload Docker image   #
#############################

aws ecr get-login-password --region $REGION | sudo docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
# Output:
#
# WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
# Configure a credential helper to remove this warning. See
# https://docs.docker.com/engine/reference/commandline/login/#credentials-store

# Login Succeeded

sudo docker tag test_pod:latest $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/prometheus_test_pod

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


sudo docker push $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/prometheus_test_pod


#############################
#     Configure kubernetes  #
#############################

kubectl create namespace $CLUSTER_NAME
envsubst < kubernetes/app.template > /tmp/app.yml
kubectl apply -f /tmp/app.yml
# Output:
#
# service/prometheus-test-service created
# deployment.apps/prometheus-test-app configured

kubectl get all -n $CLUSTER_NAME
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

kubectl -n $CLUSTER_NAME describe service prometheus-test-service
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


# NAME		VERSION	STATUS	CREATED			VPC			SUBNETS																	SECURITYGROUPS		PROVIDER
# prometheus-test	1.27	ACTIVE	2023-11-28T08:52:04Z	vpc-0608c61203adf59b6	subnet-03b801cdd887f01c5,subnet-04575e1129b0afb19,subnet-09851552469e41db1,subnet-0a219b6994d3c4502,subnet-0aba791d3c89b6fa9,subnet-0f030f0a1c5e2fe0c	sg-0491ee7c632b7e9e3	EKS

aws amp create-workspace --alias prometheus-workspace > /tmp/create-workspace-out.json
export WORKSPACE_ID=$(cat /tmp/create-workspace-out.json | jq -r '.workspaceId')
WORKSPACE_ARN=$(cat /tmp/create-workspace-out.json | jq -r '.arn')

until [[ $(aws amp describe-workspace --workspace-id $WORKSPACE_ID | jq -r ".workspace.status.statusCode") == ACTIVE ]]; do sleep 3; echo "Waiting for workspace creation..."; done
# {
#     "workspaceId": "ws-431451d8-56f2-4704-8298-396593f72cba",
#     "arn": "arn:aws:aps:us-west-2:234401896482:workspace/ws-431451d8-56f2-4704-8298-396593f72cba",
#     "status": {
#         "statusCode": "CREATING"
#     },
#     "tags": {}
# }

kubectl create namespace $SERVICE_ACCOUNT_NAMESPACE

IAM_PROXY_PROMETHEUS_INGEST_ROLE_ARN=arn:aws:iam::$WORKSPACE_ID:role/amp-iamproxy-ingest-role
IAM_PROXY_PROMETHEUS_QUERY_ROLE_ARN=arn:aws:iam::$WORKSPACE_ID:role/amp-iamproxy-query-role
SERVICE_ACCOUNT_IAM_AMP_INGEST_ARN=arn:aws:iam::$WORKSPACE_ID:policy/AMPIngestPolicy
SERVICE_ACCOUNT_IAM_AMP_QUERY_ARN=arn:aws:iam::$WORKSPACE_ID:policy/AMPQueryPolicy

aws iam detach-role-policy \
    --policy-arn $SERVICE_ACCOUNT_IAM_AMP_INGEST_ARN \
    --role-name $IAM_PROXY_PROMETHEUS_INGEST_ROLE_ARN

aws iam detach-role-policy \
    --policy-arn $SERVICE_ACCOUNT_IAM_AMP_QUERY_ARN \
    --role-name $IAM_PROXY_PROMETHEUS_QUERY_ROLE_ARN

aws iam delete-role --role-name $IAM_PROXY_PROMETHEUS_INGEST_ROLE_ARN
aws iam delete-role --role-name $IAM_PROXY_PROMETHEUS_QUERY_ROLE_ARN

aws iam delete-policy --role-name $SERVICE_ACCOUNT_IAM_AMP_INGEST_ARN
aws iam delete-policy --role-name $SERVICE_ACCOUNT_IAM_AMP_QUERY_ARN

output=$(./kubernetes/createIRSA-AMPIngest.sh | head -n 1)
# If Prometheus role already exists, additional words will be attached to output
stringarray=($output)
export IAM_PROXY_PROMETHEUS_ROLE_ARN=${stringarray[0]}

./kubernetes/createIRSA-AMPQuery.sh

# arn:aws:iam::$AWS_ACCOUNT_ID:role/amp-iamproxy-ingest-role
# 2023-11-28 20:01:34 [ℹ]  will create IAM Open ID Connect provider for cluster "prometheus-test" in "us-west-2"
# 2023-11-28 20:01:35 [✔]  created IAM Open ID Connect provider for cluster "prometheus-test" in "us-west-2"

OIDC=$(aws eks describe-cluster --name $CLUSTER_NAME --query "cluster.identity.oidc.issuer" --output text)

OIDC_ID=$(echo "$OIDC" | awk -F "/" '{print $5}')

echo "OIDC ID associated with the cluster is $OIDC_ID"

# https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html

echo "Creating Trust Policy"

eksctl utils associate-iam-oidc-provider --cluster $CLUSTER_NAME --approve

eksctl create iamserviceaccount \
           --name ebs-csi-controller-sa \
           --namespace kube-system \
           --cluster $CLUSTER_NAME \
           --role-name $EBS_CSI_DRIVER_ROLE_NAME \
           --role-only \
           --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
           --approve

# envsubst < kubernetes/trust-policy.template > /tmp/trust-policy.json

# cat /tmp/trust-policy.json

# aws iam create-role \
#         --role-name $EBS_CSI_DRIVER_ROLE_NAME \
#         --assume-role-policy-document file://"/tmp/trust-policy.json"

# aws iam attach-role-policy \
#         --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
#         --role-name $EBS_CSI_DRIVER_ROLE_NAME

echo "Creating addon"
# https://docs.aws.amazon.com/eks/latest/userguide/managing-ebs-csi.html
aws eks create-addon \
        --cluster-name $CLUSTER_NAME \
        --addon-name aws-ebs-csi-driver \
        --service-account-role-arn arn:aws:iam::$AWS_ACCOUNT_ID:role/$EBS_CSI_DRIVER_ROLE_NAME

until [[ $(aws eks describe-addon --cluster-name $CLUSTER_NAME --addon-name aws-ebs-csi-driver --query "addon.status" --output text) == ACTIVE ]]; do sleep 3; echo "Waiting for EBS driver to start..."; done
until [[ $(aws eks describe-addon --cluster-name $CLUSTER_NAME --addon-name aws-ebs-csi-driver --query "addon.status" --output text) == ACTIVE ]]; do sleep 3; echo "Waiting for EBS driver to start..."; done

cat kubernetes/prometheus_values_yaml.template | envsubst > /tmp/prometheus_values.yml

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
helm repo update

helm install prometheus-chart-name prometheus-community/prometheus -n $SERVICE_ACCOUNT_NAMESPACE \
     -f /tmp/prometheus_values.yml \
     --set alertmanager.persistentVolume.storageClass="gp2" \
     --set server.persistentVolume.storageClass="gp2"

# List prometheus pods
kubectl get pods -n $SERVICE_ACCOUNT_NAMESPACE
kubectl get deployments -n $SERVICE_ACCOUNT_NAMESPACE
kubectl get pvc -n $SERVICE_ACCOUNT_NAMESPACE

kubectl apply -f kubernetes/clusterrole-binding.yml

# export SCRAPE_CONFIGURATION=$(base64 -w 0 kubernetes/prometheus.yaml)
# export CLUSTER_SUBNET_IDS=$(eksctl get cluster -n $CLUSTER_NAME -o json | jq '.[0].ResourcesVpcConfig.SubnetIds[:2]')
# export CLUSTER_SECURITY_GROUP_IDS=$(eksctl get cluster -n $CLUSTER_NAME -o json | jq '.[0].ResourcesVpcConfig.SecurityGroupIds')
# cat kubernetes/create-scraper-json.template | envsubst > /tmp/create-scraper.json

# export SCRAPER_ID=$(aws amp create-scraper --cli-input-json file:///tmp/create-scraper.json | jq -r '.scraperId')
# # {
# #     "scraperId": "s-5683b718-5694-47f8-a22d-0563d286dee7",
# #     "arn": "arn:aws:aps:us-west-2:234401896482:scraper/s-5683b718-5694-47f8-a22d-0563d286dee7",
# #     "status": {
# #         "statusCode": "CREATING"
# #     },
# #     "tags": {}
# # }


# until [[ $(aws amp describe-scraper --scraper-id $SCRAPER_ID | jq -r ".scraper.status.statusCode") == ACTIVE ]]; do sleep 3; echo "Waiting for scraper creation..."; done

# SCRAPER_ROLE_ARN=$(aws amp describe-scraper --scraper-id $SCRAPER_ID | jq -r ".scraper.roleArn")

# export SCRAPER_ROLE_ARN=arn:aws:iam::234401896482:role/AWSServiceRoleForAmazonPrometheusScraper_9c101cc0-cc6d-4
# eksctl create iamidentitymapping --cluster $CLUSTER_NAME --region $REGION --arn $SCRAPER_ROLE_ARN --username aps-collector-user

# 2023-11-29 10:14:32 [ℹ]  checking arn arn:aws:iam::234401896482:role/aws-service-role/scraper.aps.amazonaws.com/AWSServiceRoleForAmazonPrometheusScraper_13b24080-cb77-4 against entries in the auth ConfigMap
# 2023-11-29 10:14:32 [ℹ]  adding identity "arn:aws:iam::234401896482:role/aws-service-role/scraper.aps.amazonaws.com/AWSServiceRoleForAmazonPrometheusScraper_13b24080-cb77-4" to auth ConfigMap

export loadbalancer=$(kubectl -n $CLUSTER_NAME get svc prometheus-test-service -o jsonpath='{.status.loadBalancer.ingress[*].hostname}')
curl -k -s http://${loadbalancer}/hello
# Output:
#
# {"msg":"Hello from Flask"}

