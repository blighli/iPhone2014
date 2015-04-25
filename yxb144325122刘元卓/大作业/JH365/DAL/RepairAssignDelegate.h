#import <Foundation/Foundation.h>
#import "RepairAssignModel.h"

// 维修指派 委托协议
@protocol RepairAssignDelegate<NSObject>

@optional
-(void)updateRepairAssignCallBack:(BOOL)result;
-(void)getRepairAssignItemCallBack:(RepairAssignModel *)item;
-(void)getRepairAssignPageListCallBack:(NSMutableArray *)list
                             andRecordCount:(int)recordCount
                               andPageCount:(int)pageCount
                                andPageSize:(int)pageSize
                               andPageIndex:(int)pageIndex;

@end

