locals {
  argo_values = {
    "server" = {
      "extraArgs" = ["--auth-mode=server"]
    }
    "workflow" = {
      "serviceAccount" = {
        "create" = true
      }
    }
    "controller" = {
      "containerRuntimeExecutor" = "emissary"
    }
    "useDefaultArtifactRepo" = true
    "useStaticCredentials"   = false
    "artifactRepository" = {
      "s3" = {
        "bucket"      = var.s3_bucket_name
        "keyFormat"   = "argo-artifacts/{{workflow.creationTimestamp.Y}}/{{workflow.creationTimestamp.m}}/{{workflow.creationTimestamp.d}}/{{workflow.name}}/{{pod.name}}"
        "region"      = data.aws_region.current.name
        "endpoint"    = "s3.amazonaws.com"
        "useSDKCreds" = true
        "insecure"    = false
      }
    }
  }
}