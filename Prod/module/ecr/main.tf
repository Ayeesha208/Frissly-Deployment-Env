# Create an ECR Repository with KMS Encryption
resource "aws_ecr_repository" "demo-repository" {
  name = var.repository_name
  image_scanning_configuration {
    scan_on_push = true
  }
}

# To attach the policy to above ECR
resource "aws_ecr_repository_policy" "demo-repo-policy" {
  repository = aws_ecr_repository.demo-repository.name
  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Sid       = "adds full ecr access to the demo repository",
        Effect    = "Allow",
        Principal = "*",
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DeleteRepository",
          "ecr:BatchDeleteImage",
          "ecr:SetRepositoryPolicy",
          "ecr:DeleteRepositoryPolicy"
        ]
      }
    ]
  })
}
