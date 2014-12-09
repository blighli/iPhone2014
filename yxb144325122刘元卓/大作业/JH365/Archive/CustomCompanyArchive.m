#import "CustomCompanyArchive.h"

@implementation CustomCompanyArchive

// 得到沙盒文件路径
+(NSString *)getFilePathName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePathName = [documentsDirectory stringByAppendingPathComponent:@"CustomCompany.archive"];
    return filePathName;
}

// 解档数组
+(NSMutableArray *)getList
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[CustomCompanyArchive getFilePathName]];
}

// 归档数组
+(void)saveList:(NSMutableArray *)list
{
    if(list != nil)
    {
        //归档
        [NSKeyedArchiver archiveRootObject:list toFile:[CustomCompanyArchive getFilePathName]];
    }
}

@end

