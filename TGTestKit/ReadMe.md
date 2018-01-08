#### AFNetworking 源码分析
##### 5个功能模块
网络通信模块(AFURLSessionManager、AFHTTPSessionManger)
网络状态监听模块(Reachability)
网络通信安全策略模块(Security)
网络通信信息序列化/反序列化模块(Serialization)
对于iOS UIKit库的扩展(UIKit)

SessionManager, Session, Task, TaskDelegate 等辨析
1 设置 AFURLSessionManager 作为所有 task 的代理
2 AF 自定义的 delegate
AFURLSessionManagerTaskDelegate
将 NSURLSessionTaskDelegate, NSURLSessionDataTaskDelegate, NSURLSessionDownloadTaskDelegate 转发这个AFURLSessionManagerTaskDelegate 代理中.
AFURLSessionManager 对 task 的代理做了一些公共处理, 但是转发了 上面的三条基本代理给 AF 的自定义代理. 这三条基础代理, 赋值将每个 task 对应的数据回调出去.


