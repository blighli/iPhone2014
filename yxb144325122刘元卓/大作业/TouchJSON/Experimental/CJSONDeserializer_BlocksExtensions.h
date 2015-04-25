#import "CJSONDeserializer.h"

@interface CJSONDeserializer (CJSONDeserializer_BlocksExtensions)

- (void)deserializeAsDictionary:(NSData *)inData
                completionBlock:(void (^)(id result, NSError *error))block;

- (void)deserializeAsArray:(NSData *)inData
           completionBlock:(void (^)(id result, NSError *error))block;

@end
