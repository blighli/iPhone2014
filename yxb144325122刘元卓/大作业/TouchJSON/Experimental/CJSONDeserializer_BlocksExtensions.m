#import "CJSONDeserializer_BlocksExtensions.h"

#import "CJSONScanner.h"

@implementation CJSONDeserializer (CJSONDeserializer_BlocksExtensions)

- (void)deserializeAsDictionary:(NSData *)inData completionBlock:(void (^)(id result, NSError *error))block {
	
	NSError *noDataError = nil;
	if (inData == NULL || [inData length] == 0) {
		noDataError = [NSError errorWithDomain:kJSONDeserializerErrorDomain code:kJSONScannerErrorCode_NothingToScan userInfo:NULL];
		block(nil, noDataError);
	}
	
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		
		NSError *deserializationError = nil;
		self.scanner.data = inData;
		NSDictionary *theDictionary = NULL;
		BOOL successful = [self.scanner scanJSONDictionary:&theDictionary error:&deserializationError];
		
		dispatch_async(dispatch_get_main_queue (), ^{
			if (successful)
				block(theDictionary, nil);
			else
				block(nil, deserializationError);
		});
	}];
}

- (void)deserializeAsArray:(NSData *)inData completionBlock:(void (^)(id result, NSError *error))block {
	
	NSError *nullInDataError = nil;
	if (inData == NULL || [inData length] == 0) {
		nullInDataError = [NSError errorWithDomain:kJSONDeserializerErrorDomain code:kJSONScannerErrorCode_NothingToScan userInfo:NULL];
		block(nil, nullInDataError);
	}
    
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		
		NSError *deserializationError = nil;
        self.scanner.data = inData;
		NSArray *theArray = NULL;
		BOOL successful = [self.scanner scanJSONArray:&theArray error:&deserializationError];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (successful)
				block(theArray, nil);
			else
				block(nil, deserializationError);
		});
	}];
}

@end
