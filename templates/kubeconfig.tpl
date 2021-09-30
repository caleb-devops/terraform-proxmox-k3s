apiVersion: v1
preferences: {}
kind: Config

clusters:
- cluster:
    server: ${api_endpoint}
    certificate-authority-data: ${cluster_ca_certificate}
  name: ${kubeconfig_name}

contexts:
- context:
    cluster: ${kubeconfig_name}
    user: ${kubeconfig_name}
  name: ${kubeconfig_name}

current-context: ${kubeconfig_name}

users:
- name: ${kubeconfig_name}
  user:
    client-certificate-data: ${client_certificate}
    client-key-data: ${client_key}