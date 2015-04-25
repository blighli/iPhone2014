#import <Foundation/Foundation.h>
#import "WcfRequest.h"
#import "RepairAssignDelegate.h"

@class RepairAssignModel;

// 维修指派 跟WCF服务器交互
@interface RepairAssignDAL : NSObject
<WcfRequestDelegate, NSXMLParserDelegate>
{
    WcfRequest *request;

    // xml 解析相关
    NSString *currentElement;     // 当前节点名称
    NSMutableString *currentData; // 当前节点的数据
    NSMutableDictionary *xmlData; // 解析后的字典数据
}

@property (nonatomic,assign) id<RepairAssignDelegate> delegate;

-(RepairAssignDAL *)initWithDelegate:(id)de;

// 更新
-(BOOL)updateItem:(RepairAssignModel *)item;

// 取单条
-(BOOL)getItem:(int)djLsh;

// 分页取列表
-(BOOL)getListWithPageOutCount:(int)nPageSize
                              :(int)nPageIndex
                              :(NSString *)techCode
                              :(int)doneState;
@end

