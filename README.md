# k8s-check

- control.sh 控制层面扫描
- etcd.sh etcd扫描
- worker.sh worker节点扫描

# woker结点[CIS默认问题项目]

- 4.2.4 确保将 --read-only-port参数设置为0 fail
metric 功能需要⽤到 kubelet read only port，以及有很多问题需要解决：
https://github.com/kubernetes/kubernetes/issues/12968#issuecomment-622613486

- 4.2.6 确保将 --protect-kernel-defaults参数设置为true fail
⾮通⽤配置项，涉及到内核相关配置，ACK 不会默认修改这个配置，因为客户⼯作负载可能会有⾃定义的需求

- 4.2.8 确保未设置 --hostname-override参数 fail
根据⾃⼰的节点名称命名规则（域名+IP），更为清晰

- 4.2.9 确保将 --event-qps参数设置为0或者可确保正确捕获事件的级别 fail
⾮通⽤配置项，不会默认修改这个配置，因为如果设置不当会导致集群 event 丢失或 event 把etcd 打爆，客户根据⾃⼰的需求⾃定义修改。

- 4.2.12 确保将RotateKubeletServerCertificate参数设置为true fail
⾃身轮转机制维护

# control结点[CIS默认问题项目]

- 1.2.1 确保将 --anonymous-auth 参数设置为 false fail
设置为 false 会导致 apiserver 健康检查失败，以及其他依赖 /healthz 和 /version 接⼝的
功能失败：https://github.com/kubernetes/kubernetes/issues/51076#issuecomment-413261446

- 1.2.4 确保将 --kubelet-https 参数设置为 true fail
默认是 true，⽆需显式设置 https://v1-18.docs.kubernetes.io/docs/reference/command-line-tools-reference/kubeapiserver/

- 1.2.6 确保对 --kubelet-certificate-authority 参数进⾏适当设置 fail
暂不⽀持，apiserver到kubelet已配置https通讯，且通过基础设施层实现⽹络隔离

- 1.2.10 确保已设置准许控制插件 EventRateLimit fail
⾮通⽤需求，启⽤可能会导致⽆法集群 event 丢失，ACK 不默认设置。

- 1.2.12 确保已设置准许控制插件 AlwaysPullImages fail
⾮通⽤需求，客户不⼀定会希望所有 image 的 pull 策略都是 Always，ACK 不默认设置。

- 1.2.13 确保在未使⽤ PodSecurityPolicy 的情况下已设置准许控制插件
SecurityContextDeny fail ⾮必须。ACK 已默认启⽤ PodSecurityPolicy ，可以也可以在⻚⾯上⼿动启⽤PodSecurityPolicy

- 1.2.14 确保已设置准许控制插件 ServiceAccount fail
默认启⽤，不需要显式指定：https://kubernetes.io/docs/reference/command-linetools-reference/kube-apiserver/

- 1.2.15 确保已设置准许控制插件 NamespaceLifecycle fail
默认启⽤，不需要显式指定：https://kubernetes.io/docs/reference/command-linetools-reference/kube-apiserver/

- 1.2.26 确保对 --request-timeout 参数进⾏适当设置 fail
⾮通⽤需求，值设定为多少⽆固定标准。不默认设置。客户根据需要⾃定义设置。

- 1.2.27 确保将 --service-account-lookup 参数设置为 true fail
误报。默认启⽤，不需要显示指定：https://kubernetes.io/docs/reference/command-linetools-reference/kube-apiserver/

- 1.2.33 确保对 --encryption-provider-config 参数进⾏适当设置 fail
这个功能依赖客户⾃定义配置，ACK ⽆法进⾏默认设置。客户根据需要⾃⾏配置。
https://kubernetes.io/docs/tasks/administer-cluster/kmsprovider/#
configuring-the-kms-provider

- 1.2.34 确保正确配置加密提供程序 fail
同 1.2.33 ，跟 1.2.33 是⼀个功能

- 1.2.35 确保 API 服务器仅使⽤强加密加密⽅式 fail
需要兼容⼀些⽼的客户端。客户根据需要⾃定义设置。

- 1.3.1 确保对 --terminated-pod-gc-threshold 参数进⾏适当设置 fail
⾮通⽤需求，值设定为多少⽆固定标准。ACK 不默认设置。客户根据需要⾃定义设置。

- 1.3.6 确保将 RotateKubeletServerCertificate 参数设置为 true fail
依赖kubelet-certificate-authority开启后配置

- 3.1.1 不应对⽤户使⽤客户端证书身份验证(manual) fail
这个说的是禁⽤ kubeconfig 和证书认证，⾮通⽤需求，同时不建议设置。且ACK⽤户kubeconfig证
书⽀持吊销能⼒

- 3.2.2 确保审核政策涵盖关键的安全问题(manual) fail
这个⽆法⾃动化，【关键的安全问题】是主观项。客户可以⼿动开启集群审计功能，并按需要修改实现所谓的【涵盖关键的安全问题】。