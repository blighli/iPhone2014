#import <Foundation/Foundation.h>

// 客户联系人 归档/解档
@interface CustomUserArchive : NSObject

// 解档数组
+(NSMutableArray *)getListuser;
// 归档数组
+(void)saveListuser:(NSMutableArray *)list;

@end

