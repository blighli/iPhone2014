#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "WcfRequestDelegate.h"

@interface WcfRequest : NSObject <NSURLConnectionDataDelegate>
{
    NSString *urlPath;   // eg:http://192.168.48.1:8080/Service1.svc
    NSString *wcfName;   // eg:IService1

    NSURLConnection *theConnection; // 当前网络链接
    NSMutableData *webData;         // 接收到的数据

    // 最后调用的方法(用户错误处理)
    NSString *lastFuncName;
}

@property (nonatomic,assign) id<WcfRequestDelegate> delegate;

// 构造函数
-(id)initWithUrlPara:(NSString *)path wcfName:(NSString *)name;

// 根据参数，创建一个 URLRequest（还没有执行该请求）
-(BOOL)requestWithPara:(NSString *)funcName :(NSString *)funcPara;

// 取消数据交互
-(void)cancel;

@end

