#import <Foundation/Foundation.h>
#import "WcfRequest.h"
#import "CustomDelegate.h"

@class CustomUserModel;

// 客户联系人 跟WCF服务器交互
@interface CustomDAL : NSObject
<WcfRequestDelegate, NSXMLParserDelegate>
{
    WcfRequest *request;

    // xml 解析相关
    NSString *currentElement;     // 当前节点名称
    NSMutableString *currentData; // 当前节点的数据
    NSMutableDictionary *xmlData; // 解析后的字典数据
}

@property (nonatomic,assign) id<CustomDelegate> delegate;

-(CustomDAL *)initWithDelegate:(id)de;

// 分页取列表
-(BOOL)getCompanyListWithPageOutCount:(int)nPageSize :(int)nPageIndex;
-(BOOL)getCustomListWithPageOutCount:(int)nPageSize :(int)nPageIndex;
//-(BOOL)getCompanyListWithPageOutCount;
-(BOOL)getCustomListWithPageOutCount:(int)nPageSize :(int)nPageIndex :(NSString *)company :(int)KeyWord;

@end

