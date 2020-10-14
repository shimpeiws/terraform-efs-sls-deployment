# EFS security group

resource "aws_security_group" "efs" {
  name   = "efs-security-group-${var.env_name}"
  vpc_id = var.vpc_id

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_file_system" "efs_file_system" {
  tags = {
    Name = "efs-file-system-${var.env_name}"
  }
}

resource "aws_efs_mount_target" "subnet_a" {
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = var.subnet_id_a
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "subnet_b" {
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = var.subnet_id_b
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "subnet_c" {
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = var.subnet_id_c
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_access_point" "efs_access_point" {
  file_system_id = aws_efs_file_system.efs_file_system.id

  posix_user {
    gid = 1001
    uid = 1001
  }

  root_directory {
    path = "/data"
    creation_info {
      owner_gid   = 1001
      owner_uid   = 1001
      permissions = 705
    }
  }
}
