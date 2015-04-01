//
//  NSDate+RK.m
// 
//

//

#import "NSDate+RK.h"

@implementation NSDate (RK)


-(NSString *)RKStringFromDate
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM / dd / YYYY"];
    return [dateFormatter stringFromDate:self];
}

@end
