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

echo -n "- 2.1	确保对 --cert-file 和 --key-file 参数进行适当设置 "
ps -ef | grep /usr/bin/etcd| grep -v grep|grep -q 'key-file' && cecho "pass" || cecho "fail"

echo -n "- 2.2	确保将 --client-cert-auth 参数设置为true "
ps -ef | grep /usr/bin/etcd| grep -v grep|grep -q 'client-cert-auth' && cecho "pass" || cecho "fail"

echo -n "- 2.3	确保 --auto-tls 参数未设置为true(默认为false)"
cat /proc/`ps -ef | grep /usr/bin/etcd| grep -v grep|awk '{print $2}'`/environ |grep -q 'ETCD_AUTO_TLS' && cecho "fail" || cecho "pass"

echo -n "- 2.4	确保对 --peer-cert-file 和 --peer-key-file 参数进行适当设置 "
ps -ef | grep /usr/bin/etcd| grep -v grep|grep -q 'peer-cert-file' && cecho "pass" || cecho "fail"

echo -n "- 2.5	确保将 --peer-client-cert-auth 参数设置为 true "
ps -ef | grep /usr/bin/etcd| grep -v grep|grep -q 'peer-client-cert-auth' && cecho "pass" || cecho "fail"

echo -n "- 2.6	确保 --peer-auto-tls 参数未设置为 true (默认为false) "
cat /proc/`ps -ef | grep /usr/bin/etcd| grep -v grep|awk '{print $2}'`/environ |grep -q 'ETCD_PEER_AUTO_TLS' && cecho "fail" || cecho "pass"

echo -n "- 2.7	确保已对 etcd 使用唯一的证书授权机构 "
ps -ef | grep /usr/bin/etcd| grep -v grep|grep -q 'trusted-ca-file' && cecho "pass" || cecho "fail"