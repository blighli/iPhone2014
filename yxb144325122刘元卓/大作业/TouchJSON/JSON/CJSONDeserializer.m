#import "CJSONDeserializer.h"

#import "CJSONScanner.h"
#import "CDataScanner.h"

NSString *const kJSONDeserializerErrorDomain  = @"CJSONDeserializerErrorDomain";

@interface CJSONDeserializer ()
@end

@implementation CJSONDeserializer

@synthesize scanner;
@synthesize options;

+ (CJSONDeserializer *)deserializer
{
    return([[[self alloc] init] autorelease]);
}

- (id)init
{
    if ((self = [super init]) != NULL)
    {
    }
    return(self);
}

- (void)dealloc
{
    [scanner release];
    scanner = NULL;
    //
    [super dealloc];
}

#pragma mark -

- (CJSONScanner *)scanner
{
    if (scanner == NULL)
    {
        scanner = [[CJSONScanner alloc] init];
    }
    return(scanner);
}

- (id)nullObject
{
    return(self.scanner.nullObject);
}

- (void)setNullObject:(id)inNullObject
{
    self.scanner.nullObject = inNullObject;
}

#pragma mark -

- (NSStringEncoding)allowedEncoding
{
    return(self.scanner.allowedEncoding);
}

- (void)setAllowedEncoding:(NSStringEncoding)inAllowedEncoding
{
    self.scanner.allowedEncoding = inAllowedEncoding;
}

#pragma mark -

- (id)deserialize:(NSData *)inData error:(NSError **)outError
{
    if (inData == NULL || [inData length] == 0)
    {
        if (outError)
            *outError = [NSError errorWithDomain:kJSONDeserializerErrorDomain code:kJSONScannerErrorCode_NothingToScan userInfo:NULL];
        
        return(NULL);
    }
    if ([self.scanner setData:inData error:outError] == NO)
    {
        return(NULL);
    }
    id theObject = NULL;
    if ([self.scanner scanJSONObject:&theObject error:outError] == YES)
        return(theObject);
    else
        return(NULL);
}

- (id)deserializeAsDictionary:(NSData *)inData error:(NSError **)outError
{
    if (inData == NULL || [inData length] == 0)
    {
        if (outError)
            *outError = [NSError errorWithDomain:kJSONDeserializerErrorDomain code:kJSONScannerErrorCode_NothingToScan userInfo:NULL];
        
        return(NULL);
    }
    if ([self.scanner setData:inData error:outError] == NO)
    {
        return(NULL);
    }
    NSDictionary *theDictionary = NULL;
    if ([self.scanner scanJSONDictionary:&theDictionary error:outError] == YES)
        return(theDictionary);
    else
        return(NULL);
}

- (id)deserializeAsArray:(NSData *)inData error:(NSError **)outError
{
    if (inData == NULL || [inData length] == 0)
    {
        if (outError)
            *outError = [NSError errorWithDomain:kJSONDeserializerErrorDomain code:kJSONScannerErrorCode_NothingToScan userInfo:NULL];
        
        return(NULL);
    }
    if ([self.scanner setData:inData error:outError] == NO)
    {
        return(NULL);
    }
    NSArray *theArray = NULL;
    if ([self.scanner scanJSONArray:&theArray error:outError] == YES)
        return(theArray);
    else
        return(NULL);
}

@end
