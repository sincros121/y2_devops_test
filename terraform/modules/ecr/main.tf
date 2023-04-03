resource "aws_ecr_repository" "go-app-ecr-repo" {
  count = length(var.ecr_repos)

  name                 = var.ecr_repos[count.index].name
  image_tag_mutability = var.ecr_repos[count.index].image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }
}


# Lifecycle policy to expire all images after the ones staring with tag "dev"
resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  count = length(var.ecr_repos)

  repository = var.ecr_repos[count.index].name
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Dont expire images with tag 'dev'",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["dev"],
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 99999
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Expire all images older than 14 days",
            "selection": {
                "tagStatus": "tagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Expire all images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}