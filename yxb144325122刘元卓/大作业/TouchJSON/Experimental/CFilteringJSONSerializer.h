#import "CJSONSerializer.h"

typedef NSString *(^JSONConversionTest)(id inObject);
typedef id (^JSONConversionConverter)(id inObject); // TODO replace with value transformers.

@interface CFilteringJSONSerializer : CJSONSerializer {
	NSSet *tests;
	NSDictionary *convertersByName;
}

@property (readwrite, nonatomic, retain) NSSet *tests;
@property (readwrite, nonatomic, retain) NSDictionary *convertersByName;

- (void)addTest:(JSONConversionTest)inTest;
- (void)addConverter:(JSONConversionConverter)inConverter forName:(NSString *)inName;

@end
