#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionary_JSONExtensions)

+ (id)dictionaryWithJSONData:(NSData *)inData error:(NSError **)outError;
+ (id)dictionaryWithJSONString:(NSString *)inJSON error:(NSError **)outError;

@end
