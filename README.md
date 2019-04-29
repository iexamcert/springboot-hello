###DEV

<del>
###DEV
---  
为了方便使用hub.docker.com来存放Artifacts. 实际生产中可以使用docker registry或者harbor来管理Artifacts。


STEPS：  
1.  在代码根目录运行```/bin/bash start.sh```  
</del>

###CICD  
---
<del>
   因为在整个CI/CD的过程中，涉及到jenkins slave的动态注册、使用全局工具tool编译打包jar文件、使用credentials推送镜像、使用kubectl工具操作k8s集群等操作。所以本案例提供了一个minikube的k8s环境和安装在k8s之上的jenkins。  

|项目名：|路径：|用户名：|密码|  
| ---|---|---|---|  
|jenkins|http://149.28.134.208:30002 |admin|admin|  
|项目访问地址：|http://149.28.134.208:30003/hello |||
|github:|https://github.com/iexamcert/springboot-hello.git |||    
|Dockerhub:|iexamcert/ springboot-hello | | |  
 </del>


