#import <Foundation/Foundation.h>

// 技工信息 归档/解档
@interface TechInfoArchive : NSObject

// 解档数组
+(NSMutableArray *)getList;
// 归档数组
+(void)saveList:(NSMutableArray *)list;

@end

