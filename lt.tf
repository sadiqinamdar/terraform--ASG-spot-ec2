
locals {
    common_tags = {
        owner = "sadiq"
        env = "test"
    }
}

resource "aws_launch_template" "my-template" {
  name = "terraform-template"
  count = 1
  ebs_optimized = true
  instance_market_options {
    market_type = "spot"
  }
/*
  spot_options = {
      instance_interruption_behavior = hibernate
      max_price = 0.0034
      spot_instance_type = persistent
  }

  /**/
  #instance_type = var.instance_type
  #kernel_id = "test"
  #key_name = var.key_name
  monitoring {
    enabled = true
  }
  tags = local.common_tags
  #vpc_security_group_ids = ["sg-12345678"]
  #user_data = filebase64("${path.module}/example.sh")
}