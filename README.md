###DEV  
---  
思路： 开发人员完成代码开发之后，执行脚本。ansible在ec2上申请私钥和机器，将代码上传，在ec2中完成编译，打包，docker镜像构建，并推送至hub.docker.com或其他私有仓库。最后在ec2中运行镜像。开发人员确认改动之后，拆除机器，删除key。执行脚本时会根据传递的参数选择相应的构建脚本。  

####NOTE：  
执行时会要求输入aws_access_id和 aws_secret_key.    
请修改code/deployment/env/dev.sh中DOCKER_USER和DOCKER_PASS用于登录hub.docker.com。  

在代码根目录：
```bash
cd code && /bin/bash deploy.sh dev
```

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

