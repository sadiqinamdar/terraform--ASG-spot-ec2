data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

locals {
    common_tags = {
        owner = "sadiq"
        env = "test"
    }
}

resource "aws_autoscaling_group" "my-asg" {
  capacity_rebalance  = true
  desired_capacity    = 2
  max_size            = 5
  min_size            = 2
  vpc_zone_identifier = data.aws_subnet_ids.all.ids

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 25
      spot_allocation_strategy                 = "capacity-optimized"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.my-template.id
      }

      override {
        instance_type     = "t2.micro"
        weighted_capacity = "3"
      }

      override {
        instance_type     = "t2.small"
        weighted_capacity = "1"
      }
    }
  }
  tags = local.common_tags
  
}