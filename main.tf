resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags       = local.vpc_tags
}

resource "aws_subnet" "web" {
  count             = length(var.web_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.web_subnet_cidr[count.index]
  tags              = local.web_subnet_tags
  availability_zone = var.azs[count.index]
}

resource "aws_subnet" "app" {
  count             = length(var.app_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app_subnet_cidr[count.index]
  tags              = local.app_subnet_tags
  availability_zone = var.azs[count.index]
}

resource "aws_subnet" "db" {
  count             = length(var.db_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_cidr[count.index]
  tags              = local.db_subnet_tags
  availability_zone = var.azs[count.index]
}

resource "aws_vpc_peering_connection" "main" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = var.default_vpc_id
  vpc_id        = aws_vpc.main.id
  auto_accept   = true
}

