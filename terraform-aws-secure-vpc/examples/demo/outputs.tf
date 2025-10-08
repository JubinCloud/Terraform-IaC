output "vpc_id" {
  value = module.secure_vpc.vpc_id
}

output "public_subnets" {
  value = module.secure_vpc.public_subnets
}

output "private_subnets" {
  value = module.secure_vpc.private_subnets
}
