# 限速小工具 net_limit.sh
##简介
**net_limit.sh**是用于在Flash备份模式备份Linux服务器时，只限制备份上传速度的脚本。
>原理是使用linux中的TC（流量控制模块），利用队列规定建立起数据包队列，并定义了队列中数据包的发送方式，从而实现对流量的控制。

##使用方式
启动限速，限制备份上传速度为200kb/s：

```
# sh net_limit.sh start 200
```

停止限速：

```
# sh net_limit.sh stop
```

