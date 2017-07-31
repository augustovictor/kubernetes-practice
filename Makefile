# VARIABLES
deployment_name = node-app
deployment_file_path = deployments/node-app-config.yml

service_name = node-app-service
service_file_path = services/node-app.yml

configmap_name = node-app-config
configmap_file_path = configmaps/node-app-configmap.yml

# OPTIONS
options:
	@echo -----------------------------------
	@echo Make Commands
	@echo -----------------------------------
	@echo -- GENERAL --
	@echo make dash			   : Opens a dashboard with all deployments, services, pods, etc in the default browser
	@echo make mount-all       : Creates a configmap $(configmap_name) and a deployment $(deployment_name)
	@echo make tear-down       : Removes a configmap $(configmap_name) and a deployment $(deployment_name)
	@echo -----------------------------------
	@echo -- CONFIGMAPS --
	@echo make configmap-ls    : List all configmaps
	@echo make configmap-new   : Create a new configmap named $(configmap_name) from $(configmap_file_path)
	@echo make configmap-del   : Delete configmap $(configmap_name)
	@echo make configmap-print : Outputs the configmap $(configmap_name) in yaml format
	@echo -----------------------------------
	@echo -- DEPLOYMENTS --
	@echo make deployment-ls   : List all deployments
	@echo make deployment-new  : Create a deployment from $(deployment_file_path)
	@echo make deployment-del  : Delete deployment $(deployment_name)
	@echo -----------------------------------
	@echo -- SERVICES --
	@echo make service-ls      : List services
	@echo make service-new     : Create a service from $(service_file_path)
	@echo -----------------------------------

# GENERAL
dash:
	@minikube dashboard

mount-all:
	@$(MAKE) configmap-new
	@$(MAKE) deployment-new

tear-down:
	@$(MAKE) configmap-del
	@$(MAKE) deployment-del

# CONFIGMAPS
configmap-ls:
	@kubectl get configmap

configmap-new:
	@echo Creating configmap $(configmap_name)
	@kubectl create configmap $(configmap_name) --from-file=$(configmap_file_path)

configmap-del:
	@echo Deleting configmap $(configmap_name)
	@kubectl delete configmap $(configmap_name)
configmap-print:
	@kubectl get configmap $(configmap_name) -o yaml

# DEPLOYMENTS
deployment-ls:
	@echo Deployments list
	@kubectl get deployments

deployment-new:
	@echo Creating deployment $(deployment_name)
	@kubectl create -f $(deployment_file_path)

deployment-del:
	@echo Deleting deployment $(deployment_name)
	@kubectl delete deployment $(deployment_name)

# SERVICES
services-new:
	@echo Creating service $(service_name)
	@kubectl create -f $(service_file_path)

service-ls:
	@echo Services list
	@kubectl get service