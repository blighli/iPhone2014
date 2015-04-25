#import <Foundation/Foundation.h>

@protocol WcfRequestDelegate

@optional
// 成功返回
-(void)requestCallBack:(NSMutableData *)webData;
// 失败返回
-(void)requestErrorCallBack:(NSString *)funcName;

@end

