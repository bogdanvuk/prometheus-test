set -e

kubectl -n prometheus-test delete svc prometheus-test-service
# Output:
#
# service "prometheus-test-service" deleted

kubectl delete namespace prometheus-test

eksctl delete cluster --name prometheus-test
# Output:
#
# 2023-11-27 09:36:19 [ℹ]  deleting EKS cluster "prometheus-test"
# 2023-11-27 09:36:22 [ℹ]  will drain 0 unmanaged nodegroup(s) in cluster "prometheus-test"
# 2023-11-27 09:36:22 [ℹ]  starting parallel draining, max in-flight of 1
# 2023-11-27 09:36:23 [ℹ]  deleted 0 Fargate profile(s)
# 2023-11-27 09:36:25 [✔]  kubeconfig has been updated
# 2023-11-27 09:36:25 [ℹ]  cleaning up AWS load balancers created by Kubernetes objects of Kind Service or Ingress
# 2023-11-27 09:36:28 [ℹ]  
# 2 sequential tasks: { delete nodegroup "ng-c347089f", delete cluster control plane "prometheus-test" [async] 
# }
# 2023-11-27 09:36:29 [ℹ]  will delete stack "eksctl-prometheus-test-nodegroup-ng-c347089f"
# 2023-11-27 09:36:29 [ℹ]  waiting for stack "eksctl-prometheus-test-nodegroup-ng-c347089f" to get deleted
# 2023-11-27 09:36:29 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-c347089f"
# 2023-11-27 09:37:00 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-c347089f"
# 2023-11-27 09:37:40 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-c347089f"
# 2023-11-27 09:38:46 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-c347089f"
# 2023-11-27 09:39:29 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-c347089f"
# 2023-11-27 09:41:19 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-c347089f"
# 2023-11-27 09:42:46 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-c347089f"
# 2023-11-27 09:44:38 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-c347089f"
# 2023-11-27 09:46:12 [ℹ]  waiting for CloudFormation stack "eksctl-prometheus-test-nodegroup-ng-c347089f"
# 2023-11-27 09:46:12 [ℹ]  will delete stack "eksctl-prometheus-test-cluster"
# 2023-11-27 09:46:14 [✔]  all cluster resources were deleted

aws ecr delete-repository --repository-name prometheus_test_pod --force
# Output
#
# {
#     "repository": {
#         "repositoryArn": "arn:aws:ecr:us-west-2:234401896482:repository/prometheus_test_pod",
#         "registryId": "234401896482",
#         "repositoryName": "prometheus_test_pod",
#         "repositoryUri": "234401896482.dkr.ecr.us-west-2.amazonaws.com/prometheus_test_pod",
#         "createdAt": "2023-11-27T08:07:36+01:00",
#         "imageTagMutability": "MUTABLE"
#     }
# }
