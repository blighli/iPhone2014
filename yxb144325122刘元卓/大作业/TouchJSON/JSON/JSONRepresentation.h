#import <Foundation/Foundation.h>

@protocol JSONRepresentation

@optional
- (id)initWithJSONDataRepresentation:(NSData *)inJSONData;
- (NSData *)JSONDataRepresentation;

@end
