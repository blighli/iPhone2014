#import <Foundation/Foundation.h>
#import "RepairInfoModel.h"

// 维修信息 委托协议
@protocol RepairInfoDelegate<NSObject>

@optional
-(void)getRepairInfoPageListCallBack:(NSMutableArray *)list
                      andRecordCount:(int)recordCount
                        andPageCount:(int)pageCount
                         andPageSize:(int)pageSize
                        andPageIndex:(int)pageIndex;

@end

