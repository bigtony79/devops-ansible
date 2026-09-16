module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "~>21.0"

    name = var.cluster_name
    kubernetes_version = "1.33"

    endpoint_public_access = true

    vpc_id = module.myapp-vpc.vpc_id
    subnet_ids = module.myapp-vpc.private_subnets

    enable_cluster_creator_admin_permissions = true

    addons = {
        coredns = {}
        kube-proxy = {}
        vpc-cni = {
            before_compute = true            
        }
    }
    
    eks_managed_node_groups = {
        dev = {
            min_size = 1
            max_size = 3
            desired_size = 3
            instance_types = ["t3.medium"]
        }
    }
    tags = {
        environment = "development"
        application = "myapp"
    }
}



