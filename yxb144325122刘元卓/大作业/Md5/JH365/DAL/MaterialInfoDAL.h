#import <Foundation/Foundation.h>
#import "WcfRequest.h"
#import "MaterialInfoDelegate.h"

@class MaterialInfoModel;

// 材料信息 跟WCF服务器交互
@interface MaterialInfoDAL : NSObject
<WcfRequestDelegate, NSXMLParserDelegate>
{
    WcfRequest *request;

    // xml 解析相关
    NSString *currentElement;     // 当前节点名称
    NSMutableString *currentData; // 当前节点的数据
    NSMutableDictionary *xmlData; // 解析后的字典数据
}

@property (nonatomic,assign) id<MaterialInfoDelegate> delegate;

-(MaterialInfoDAL *)initWithDelegate:(id)de;

// 取单条
-(BOOL)getItem:(int)djLsh;

// 取列表
-(BOOL)getList;

// 分页取列表
-(BOOL)getListWithPageOutCount:(int)nPageSize :(int)nPageIndex :(NSString *)keyWord;

@end

