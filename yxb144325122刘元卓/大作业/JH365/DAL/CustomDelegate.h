#import <Foundation/Foundation.h>
#import "CustomUserModel.h"

// 客户联系人 委托协议
@protocol CustomDelegate<NSObject>

@optional
-(void)getCompanyListWithPageOutCount:(NSMutableArray *)list
                       andRecordCount:(int)recordCount
                         andPageCount:(int)pageCount
                          andPageSize:(int)pageSize
                         andPageIndex:(int)pageIndex;

-(void)getCustomListWithPageOutCount:(NSMutableArray *)list
                      andRecordCount:(int)recordCount
                        andPageCount:(int)pageCount
                         andPageSize:(int)pageSize
                        andPageIndex:(int)pageIndex;
-(void)getCustomListWithPageOutCount1:(NSMutableArray *)list;

@end

