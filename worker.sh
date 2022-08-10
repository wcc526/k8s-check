#!/bin/bash

function cecho(){
    local exp=$1;
    local color=$1;
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        fail) color=1 ;;
        pass) color=2 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput setaf $color;
    echo $exp;
    tput sgr0;
}

echo -n "- 4.2.1 确保将 --anonymous-auth参数设置为false "
ps -ef | grep kubelet| grep -v grep|grep -q "anonymous-auth=false" && cecho "pass" || cecho "fail"

echo -n "- 4.2.2 确保 --authorization-mode参数未设置为AlwaysAllow "
ps -ef | grep kubelet| grep -v grep|grep -q "authorization-mode=Webhook" && cecho "pass" || cecho "fail"

echo -n "- 4.2.3 确保对 --client-ca-file参数进行适当设置 "
ps -ef | grep kubelet| grep -v grep|grep -q "client-ca-file" && cecho "pass" || cecho "fail"

echo -n "- 4.2.4 确保将 --read-only-port参数设置为0 "
ps -ef | grep kubelet| grep -v grep|grep -q "read-only-port=0" && cecho "pass" || cecho "fail"

echo -n "- 4.2.5 确保--streaming-connection-idel-timeout参数未设置为0 "
ps -ef | grep kubelet| grep -v grep|grep -q "streaming-connection-idel-timeout=0" && cecho "fail" || cecho "pass"

echo -n "- 4.2.6 确保将 --protect-kernel-defaults参数设置为true "
ps -ef | grep kubelet| grep -v grep|grep -q "protect-kernel-defaults=true" && cecho "pass" || cecho "fail"

echo -n "- 4.2.7 确保将 --make-iptables-util-chains参数设置未true "
ps -ef | grep kubelet| grep -v grep|grep -q "make-iptables-util-chains=true" && cecho "fail" || cecho "pass"

echo -n "- 4.2.8 确保未设置 --hostname-override参数 "
ps -ef | grep kubelet| grep -v grep|grep -q "hostname-override" && cecho "fail" || cecho "pass"

echo -n "- 4.2.9 确保将 --event-qps参数设置为0或者可确保正确捕获事件的级别 "
ps -ef | grep kubelet| grep -v grep|grep -q "event-qps" && cecho "pass" || cecho "fail"

echo -n "- 4.2.10 确保对 --tls-cert-file和 --tls-private-key-file参数进行适当设置 "
ps -ef | grep kubelet| grep -v grep|grep -q "tls-private-key-file" && cecho "pass" || cecho "fail"

echo -n "- 4.2.11 确保 --rotate-certificates 参数未设置为false "
ps -ef | grep kubelet| grep -v grep|grep -q "rotate-certificates=false" && cecho "pass" || cecho "fail"

echo -n "- 4.2.12 确保将RotateKubeletServerCertificate参数设置为true "
ps -ef | grep kubelet| grep -v grep|grep -q "RotateKubeletServerCertificate=true" && cecho "pass" || cecho "fail"

echo -n "- 4.2.13 确保kubelet仅使用强加密加密方式 "
ps -ef | grep kubelet| grep -v grep|grep -q "tls-cipher-suites=TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256" && cecho "pass" || cecho "fail"