#!/bin/bash

function cecho(){
    local exp=$1;
    local color=$1;
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        fail) color=1 ;;
        pass) color=2 ;;
        manual) color=4 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput setaf $color;
    echo $exp;
    tput sgr0;
}

echo -n "- 1.2.1 确保将 --anonymous-auth 参数设置为 false "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "anonymous-auth=false" && cecho "pass" || cecho "fail"

echo -n "- 1.2.2 确保未设置 --basic-auth-file 参数 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "basic-auth-file" && cecho "fail" || cecho "pass"

echo -n "- 1.2.3 确保未设置 --token-auth-file 参数 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "token-auth-file" && cecho "fail" || cecho "pass"

echo -n "- 1.2.4 确保将 --kubelet-https 参数设置为 true "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "kubelet-https=true" && cecho "pass" || cecho "fail"

echo -n "- 1.2.5 确保对 --kubelet-client-certificate 和 --kubelet-client-key 参数进行适当设置 " 

ps -ef | grep kube-apiserver| grep -v grep|grep -q "kubelet-client-certificate" && cecho "pass" || cecho "fail"

echo -n "- 1.2.6 确保对 --kubelet-certificate-authority 参数进行适当设置 " 

ps -ef | grep kube-apiserver| grep -v grep|grep -q "kubelet-certificate-authority" && cecho "pass" || cecho "fail"

echo -n "- 1.2.7 确保 --authorization-mode 参数未设置为 AlwaysAllow "

ps -ef | grep kube-apiserver| grep -v grep|grep -q "authorization-mode=" && cecho "pass" || cecho "fail"

echo -n "- 1.2.8 确保 --authorization-mode 参数包含 Node "

ps -ef | grep kube-apiserver| grep -v grep|grep -q "authorization-mode=Node,RBAC" && cecho "pass" || cecho "fail"

echo -n "- 1.2.9 确保 --authorization-mode 参数包含 RBAC "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "authorization-mode=Node,RBAC" && cecho "pass" || cecho "fail"

echo -n "- 1.2.10 确保已设置准许控制插件 EventRateLimit "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "EventRateLimit" && cecho "pass" || cecho "fail"

echo -n "- 1.2.11 确保未设置准许控制插件 AlwaysAdmit "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "AlwaysAdmit" && cecho "fail" || cecho "pass"

echo -n "- 1.2.12 确保已设置准许控制插件 AlwaysPullImages "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "AlwaysPullImages" && cecho "pass" || cecho "fail"

echo -n "- 1.2.13 确保在未使用 PodSecurityPolicy 的情况下已设置准许控制插件 SecurityContextDeny "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "SecurityContextDeny" && cecho "pass" || cecho "fail"

echo -n "- 1.2.14 确保已设置准许控制插件 ServiceAccount "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "ServiceAccount" && cecho "pass" || cecho "fail"

echo -n "- 1.2.15 确保已设置准许控制插件 NamespaceLifecycle "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "NamespaceLifecycle" && cecho "pass" || cecho "fail"

echo -n "- 1.2.16 确保已设置准许控制插件 PodSecurityPolicy "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "PodSecurityPolicy" && cecho "pass" || cecho "fail"

echo -n "- 1.2.17 确保已设置准许控制插件 NodeRestriction "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "NodeRestriction" && cecho "pass" || cecho "fail"

echo -n "- 1.2.18 确保未设置 --insecure-bind-address 参数 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "insecure-bind-address" && cecho "fail" || cecho "pass"

echo -n "- 1.2.19 确保将 --insecure-port 参数设置为 0 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "insecure-port=0" && cecho "pass" || cecho "fail"

echo -n "- 1.2.20 确保 --secure-port 参数未设置为 0 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "secure-port=6443" && cecho "pass" || cecho "fail"

echo -n "- 1.2.21 确保将 --profiling 参数设置为 false "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "profiling=false" && cecho "pass" || cecho "fail"

echo -n "- 1.2.22 确保已设置 --audit-log-path 参数 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "audit-log-path" && cecho "pass" || cecho "fail"

echo -n "- 1.2.23 确保将 --audit-log-maxage 参数设置为 30 或进行适当设置 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "audit-log-maxage" && cecho "pass" || cecho "fail"

echo -n "- 1.2.24 确保将 --audit-log-maxbackup 参数设置为 10 或进行适当设置 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "audit-log-maxbackup" && cecho "pass" || cecho "fail"

echo -n "- 1.2.25 确保将 --audit-log-maxsize 参数设置为 100 或进行适当设置 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "audit-log-maxsize" && cecho "pass" || cecho "fail"

echo -n "- 1.2.26 确保对 --request-timeout 参数进行适当设置 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "request-timeout" && cecho "pass" || cecho "fail"

echo -n "- 1.2.27 确保将 --service-account-lookup 参数设置为 true "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "service-account-lookup=true" && cecho "pass" || cecho "fail"

echo -n "- 1.2.28 确保对 --service-account-key-file 参数进行适当设置 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "service-account-key-file" && cecho "pass" || cecho "fail"

echo -n "- 1.2.29 确保对 --etcd-certfile 和 --etcd-keyfile 参数进行适当设置 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "etcd-certfile" && cecho "pass" || cecho "fail"

echo -n "- 1.2.30 确保对 --tls-cert-file 和--tls-private-key-file 参数进行适当设置 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "tls-cert-file" && cecho "pass" || cecho "fail"

echo -n "- 1.2.31 确保对 --client-ca-file 参数进行适当设置 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "client-ca-file" && cecho "pass" || cecho "fail"

echo -n "- 1.2.32 确保对 --etcd-cafile 参数进行适当设置 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "etcd-cafile" && cecho "pass" || cecho "fail"

echo -n "- 1.2.33 确保对 --encryption-provider-config 参数进行适当设置 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "encryption-provider-config" && cecho "pass" || cecho "fail"

echo -n "- 1.2.34 确保正确配置加密提供程序 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "aescbc" && cecho "pass" || cecho "fail"

echo -n "- 1.2.35 确保 API 服务器仅使用强加密加密方式 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "tls-cipher-suites=TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384" && cecho "pass" || cecho "fail"

echo -n "- 1.3.1 确保对 --terminated-pod-gc-threshold 参数进行适当设置 "
ps -ef | grep kube-controller-manager| grep -v grep|grep -q "terminated-pod-gc-threshold" && cecho "pass" || cecho "fail"

echo -n "- 1.3.2 确保将 --profiling 参数设置为 false "
ps -ef | grep kube-controller-manager| grep -v grep|grep -q "profiling=false" && cecho "pass" || cecho "fail"

echo -n "- 1.3.3 确保将 --use-service-account-credentials 参数设置为 true "
ps -ef | grep kube-controller-manager| grep -v grep|grep -q "use-service-account-credentials=true" && cecho "pass" || cecho "fail"

echo -n "- 1.3.4 确保对 --service-account-private-key-file 参数进行适当设置 "
ps -ef | grep kube-controller-manager| grep -v grep|grep -q "service-account-private-key-file" && cecho "pass" || cecho "fail"

echo -n "- 1.3.5 确保对 --root-ca-file 参数进行适当设置 "
ps -ef | grep kube-controller-manager| grep -v grep|grep -q "root-ca-file" && cecho "pass" || cecho "fail"

echo -n "- 1.3.6 确保将 RotateKubeletServerCertificate 参数设置为 true "
ps -ef | grep kube-controller-manager| grep -v grep|grep -q "RotateKubeletServerCertificate=true" && cecho "pass" || cecho "fail"

echo -n "- 1.3.7 确保将 --bind-address 参数设置为 127.0.0.1 "
ps -ef | grep kube-controller-manager| grep -v grep|grep -q "127.0.0.1" && cecho "pass" || cecho "fail"

echo -n "- 1.4.1 确保将 --profiling 参数设置为 false "
ps -ef | grep kube-scheduler| grep -v grep|grep -q "profiling=false" && cecho "pass" || cecho "fail"

echo -n "- 1.4.2 确保将 --bind-address 参数设置为 127.0.0.1 "
ps -ef | grep kube-scheduler| grep -v grep|grep -q "127.0.0.1" && cecho "pass" || cecho "fail"

echo -n "- 3.1.1 不应对用户使用客户端证书身份验证(manual) "
cecho "fail"

echo -n "- 3.2.1 确保创建最低审核政策 "
ps -ef | grep kube-apiserver| grep -v grep|grep -q "audit-policy-file" && cecho "pass" || cecho "fail"

echo -n "- 3.2.2 确保审核政策涵盖关键的安全问题(manual) "
cecho "fail"