#import <Foundation/Foundation.h>

@interface CDataScanner : NSObject {
	NSData *data;

	u_int8_t *start;
	u_int8_t *end;
	u_int8_t *current;
	NSUInteger length;
}

@property (readwrite, nonatomic, retain) NSData *data;
@property (readwrite, nonatomic, assign) NSUInteger scanLocation;
@property (readonly, nonatomic, assign) NSUInteger bytesRemaining;
@property (readonly, nonatomic, assign) BOOL isAtEnd;

- (id)initWithData:(NSData *)inData;

- (unichar)currentCharacter;
- (unichar)scanCharacter;
- (BOOL)scanCharacter:(unichar)inCharacter;

- (BOOL)scanUTF8String:(const char *)inString intoString:(NSString **)outValue;
- (BOOL)scanString:(NSString *)inString intoString:(NSString **)outValue;
- (BOOL)scanCharactersFromSet:(NSCharacterSet *)inSet intoString:(NSString **)outValue; // inSet must only contain 7-bit ASCII characters

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)outValue;
- (BOOL)scanUpToCharactersFromSet:(NSCharacterSet *)set intoString:(NSString **)outValue; // inSet must only contain 7-bit ASCII characters

- (BOOL)scanNumber:(NSNumber **)outValue;
- (BOOL)scanDecimalNumber:(NSDecimalNumber **)outValue;

- (BOOL)scanDataOfLength:(NSUInteger)inLength intoPointer:(void **)outPointer;
- (BOOL)scanDataOfLength:(NSUInteger)inLength intoData:(NSData **)outData;

- (void)skipWhitespace;

- (NSString *)remainingString;
- (NSData *)remainingData;

@end
