resource "aws_iam_role" "serial_console" {
  name = "ec2-serial-console-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "serial_console" {
  name = "ec2-serial-console-policy"
  role = aws_iam_role.serial_console.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2-instance-connect:SendSerialConsoleSSHPublicKey"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "serial_console" {
  name = "ec2-serial-console-profile"
  role = aws_iam_role.serial_console.name
}
