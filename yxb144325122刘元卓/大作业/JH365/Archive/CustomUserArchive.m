#import "CustomUserArchive.h"

@implementation CustomUserArchive

// 得到沙盒文件路径
+(NSString *)getFilePathName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePathName = [documentsDirectory stringByAppendingPathComponent:@"CustomUser.archive"];
    return filePathName;
}

// 解档数组
+(NSMutableArray *)getListuser
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[CustomUserArchive getFilePathName]];
}

// 归档数组
+(void)saveListuser:(NSMutableArray *)list
{
    if(list != nil)
    {
        //归档
        [NSKeyedArchiver archiveRootObject:list toFile:[CustomUserArchive getFilePathName]];
    }
}

@end

