#import "CDataScanner.h"

@interface CDataScanner (CDataScanner_Extensions)

- (BOOL)scanCStyleComment:(NSString **)outComment;
- (BOOL)scanCPlusPlusStyleComment:(NSString **)outComment;

- (NSUInteger)lineOfScanLocation;
- (NSDictionary *)userInfoForScanLocation;

@end
