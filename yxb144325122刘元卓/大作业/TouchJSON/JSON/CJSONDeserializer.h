#import <Foundation/Foundation.h>

#import "CJSONScanner.h"

extern NSString *const kJSONDeserializerErrorDomain /* = @"CJSONDeserializerErrorDomain" */;

enum {
    kJSONDeserializationOptions_MutableContainers = kJSONScannerOptions_MutableContainers,
    kJSONDeserializationOptions_MutableLeaves = kJSONScannerOptions_MutableLeaves,
};
typedef NSUInteger EJSONDeserializationOptions;

@class CJSONScanner;

@interface CJSONDeserializer : NSObject {
    CJSONScanner *scanner;
    EJSONDeserializationOptions options;
}

@property (readwrite, nonatomic, retain) CJSONScanner *scanner;
/// Object to return instead when a null encountered in the JSON. Defaults to NSNull. Setting to null causes the scanner to skip null values.
@property (readwrite, nonatomic, retain) id nullObject;
/// JSON must be encoded in Unicode (UTF-8, UTF-16 or UTF-32). Use this if you expect to get the JSON in another encoding.
@property (readwrite, nonatomic, assign) NSStringEncoding allowedEncoding;
@property (readwrite, nonatomic, assign) EJSONDeserializationOptions options;

+ (CJSONDeserializer *)deserializer;

- (id)deserialize:(NSData *)inData error:(NSError **)outError;

- (id)deserializeAsDictionary:(NSData *)inData error:(NSError **)outError;
- (id)deserializeAsArray:(NSData *)inData error:(NSError **)outError;

@end
