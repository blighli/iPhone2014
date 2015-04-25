#import <Foundation/Foundation.h>

@protocol CJSONSerializable <NSObject>
@property (readonly, nonatomic, retain) NSData *serializedJSONData;
@end

#pragma mark -

@interface CJSONSerializedData : NSObject <CJSONSerializable> {
    NSData *data;
}

@property (readonly, nonatomic, retain) NSData *data;

- (id)initWithData:(NSData *)inData;

@end
