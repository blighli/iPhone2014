#import "CJSONSerializedData.h"

@interface CJSONSerializedData ()
@end

#pragma mark -

@implementation CJSONSerializedData

@synthesize data;

- (id)initWithData:(NSData *)inData
{
    if ((self = [super init]) != NULL)
    {
        data = [inData retain];
    }
    return(self);
}

- (void)dealloc
{
    [data release];
    data = NULL;
    //
    [super dealloc];
}

- (NSData *)serializedJSONData
{
    return(self.data);
}

@end
