#import "WcfRequest.h"
#import "MacroDefine.h"

@implementation WcfRequest

@synthesize delegate;

-(id)init
{
    self = [super init];
    if(self)
    {
        urlPath = @"";
        wcfName = @"";
    }
    return self;
}

/*
 构造函数
 第1个参数：MessageInfoService.svc
 第2个参数：IMessageInfoService
 */
-(id)initWithUrlPara:(NSString *)urlPara wcfName:(NSString *)name
{
    self = [super init];
    if(self)
    {
        // 用户设置
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *wcfUrlStr = [defaults objectForKey:@"wcfurl"];
        if(wcfUrlStr == nil || wcfUrlStr.length == 0)
        {
            wcfUrlStr = WcfUrl;
            [defaults setObject:WcfUrl forKey:@"wcfurl"];
        }
        if(IfDebugDAL)
            NSLog(@"WcfRequest urlPath = %@", wcfUrlStr);

        urlPath = [[NSString alloc] initWithFormat:@"%@/Wcf/%@",wcfUrlStr,urlPara];
        wcfName = [name copy];
    }
    return self;
}
-(void)dealloc
{
    [urlPath release],urlPath = nil;
    [wcfName release],wcfName = nil;
    [theConnection cancel];
    [theConnection release],theConnection = nil;
    [super dealloc];
}

// 取消数据交互
-(void)cancel
{
    [theConnection cancel];
    [theConnection release],theConnection = nil;
}

/*
 参数范例：
 第1个参数：GetParaData
 第2个参数：<realName>cori</realName><passWord>121212</passWord>
 */
-(BOOL)requestWithPara:(NSString *)funcName :(NSString *)funcPara
{
    NSURL *url = [NSURL URLWithString:urlPath];

    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];

    // 拼接消息体字符串
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body>\n"
                             /*
                              "<GetItem xmlns=\"http://tempuri.org/\">"
                              "<realName>cori</realName>"
                              "<passWord>121212</passWord>"
                              "</GetItem>\n"
                              */
                             // 组装参数
                             "<%@ xmlns=\"http://tempuri.org/\">"
                             "%@"
                             "</%@>\
"
                             "</SOAP-ENV:Body>\n"
                             "</SOAP-ENV:Envelope>", funcName, funcPara, funcName];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:[NSString stringWithFormat:@"http://tempuri.org/%@/%@",wcfName,funcName] forHTTPHeaderField:@"SOAPAction"];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    if(IfDebugDAL)
    {
        NSLog(@"WcfRequest.m %@ = %@",funcName, funcPara);
        NSLog(@"%@",soapMessage);
    }

    // 创建网络链接
    [theConnection release];
    theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if(theConnection)
    {
        [webData release],webData = nil;        // 清空数据
        webData = [[NSMutableData alloc] init]; // 重新创建对象

        lastFuncName = funcName; // 最后调用的方法

        return TRUE;
    }
    else
    {
        NSLog(@"theConnection is NULL");
        return FALSE;
    }
}

#pragma mark - NSURLConnectionDelegate
// 接收到回应，准备接收数据
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(webData == nil)
        webData = [[NSMutableData alloc] init];
    [webData setLength:0]; // 清空容器
}
// 开始传递(续传)数据
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data]; // 分段接收数据
}
// 发生错误
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed: %@",[error description]);
    [delegate requestErrorCallBack:lastFuncName]; // 回调错误信息
}
// 连接交互结束
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [delegate requestCallBack:webData];// 回调
    [webData release],webData = nil;   // 清空
}

@end

