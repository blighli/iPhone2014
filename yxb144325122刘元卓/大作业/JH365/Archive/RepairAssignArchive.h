#import <Foundation/Foundation.h>

// 维修指派 归档/解档
@interface RepairAssignArchive : NSObject

// 解档数组
+(NSMutableArray *)getList;
// 归档数组
+(void)saveList:(NSMutableArray *)list;

@end

