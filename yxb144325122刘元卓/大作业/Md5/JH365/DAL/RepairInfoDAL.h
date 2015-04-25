#import <Foundation/Foundation.h>
#import "WcfRequest.h"
#import "RepairInfoDelegate.h"

@class RepairInfoModel;

// 维修信息 跟WCF服务器交互
@interface RepairInfoDAL : NSObject
<WcfRequestDelegate, NSXMLParserDelegate>
{
    WcfRequest *request;

    // xml 解析相关
    NSString *currentElement;     // 当前节点名称
    NSMutableString *currentData; // 当前节点的数据
    NSMutableDictionary *xmlData; // 解析后的字典数据
}

@property (nonatomic,assign) id<RepairInfoDelegate> delegate;

-(RepairInfoDAL *)initWithDelegate:(id)de;

// 分页取列表
// nPageSize 每页的大小（15）
// nPageIndex 取第几页（1，2,3,4,5.....）
// customCode 客户编号，为空取全部
// regionID 所在区域编号，-1取全部
// keyWord 关键字，可以为空
-(BOOL)getListWithPageOutCount:(int)nPageSize
                              :(int)nPageIndex
                              :(NSString *)customCode
                              :(int)regionID
                              :(NSString *)keyWord;


@end

