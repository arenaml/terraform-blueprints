resource "kubernetes_namespace" "argo" {
  metadata {
    name = "argo"
  }
}

resource "kubernetes_default_service_account" "default" {
  metadata {
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
}

resource "helm_release" "argo" {
  name = "argo"

  repository   = "https://argoproj.github.io/argo-helm"
  chart        = "argo-workflows"
  namespace    = kubernetes_namespace.argo.metadata[0].name
  force_update = true

  values = [
    yamlencode(local.argo_values)
  ]
}
