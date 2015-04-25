#import <Foundation/Foundation.h>
#import "MaterialInfoModel.h"

// 材料信息 委托协议
@protocol MaterialInfoDelegate<NSObject>

@optional
-(void)getMaterialInfoItemCallBack:(MaterialInfoModel *)item;
-(void)getMaterialInfoListCallBack:(NSMutableArray *)list;
-(void)getMaterialInfoPageListCallBack:(NSMutableArray *)list
                             andRecordCount:(int)recordCount
                               andPageCount:(int)pageCount
                                andPageSize:(int)pageSize
                               andPageIndex:(int)pageIndex;

@end

