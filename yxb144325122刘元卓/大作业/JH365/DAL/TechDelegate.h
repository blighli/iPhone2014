#import <Foundation/Foundation.h>
#import "TechInfoModel.h"

// 技工信息 委托协议
@protocol TechDelegate

@optional
-(void)getGroupListCallBack:(NSMutableArray *)list;
-(void)loginCallBack:(TechInfoModel *)item;

@end

