#import <Foundation/Foundation.h>
#import "WcfRequest.h"
#import "TechDelegate.h"

@class TechInfoModel;

// 技工信息 跟WCF服务器交互
@interface TechDAL : NSObject
<WcfRequestDelegate, NSXMLParserDelegate>
{
    WcfRequest *request;

    // xml 解析相关
    NSString *currentElement;     // 当前节点名称
    NSMutableString *currentData; // 当前节点的数据
    NSMutableDictionary *xmlData; // 解析后的字典数据
}

@property (nonatomic,assign) id<TechDelegate> delegate;

-(TechDAL *)initWithDelegate:(id)de;

// 取 技工分组 列表
-(BOOL)getGroupList;

// 技工 登录
-(BOOL)login:(NSString *)techCode :(NSString *)passWord;

@end

