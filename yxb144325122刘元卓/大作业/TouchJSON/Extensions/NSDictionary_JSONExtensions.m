#import "NSDictionary_JSONExtensions.h"

#import "CJSONDeserializer.h"

@implementation NSDictionary (NSDictionary_JSONExtensions)

+ (id)dictionaryWithJSONData:(NSData *)inData error:(NSError **)outError
{
    return([[CJSONDeserializer deserializer] deserialize:inData error:outError]);
}

+ (id)dictionaryWithJSONString:(NSString *)inJSON error:(NSError **)outError;
{
    NSData *theData = [inJSON dataUsingEncoding:NSUTF8StringEncoding];
    return([self dictionaryWithJSONData:theData error:outError]);
}

@end
