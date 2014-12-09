#import <Foundation/Foundation.h>

// 维修信息 归档/解档
@interface RepairInfoArchive : NSObject

// 解档数组
+(NSMutableArray *)getList;
// 归档数组
+(void)saveList:(NSMutableArray *)list;

@end

