#import <Foundation/Foundation.h>

// 客户公司 归档/解档
@interface CustomCompanyArchive : NSObject

// 解档数组
+(NSMutableArray *)getList;
// 归档数组
+(void)saveList:(NSMutableArray *)list;

@end

