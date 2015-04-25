#import "CDataScanner.h"

enum {
    kJSONScannerOptions_MutableContainers = 0x1,
    kJSONScannerOptions_MutableLeaves = 0x2,
};
typedef NSUInteger EJSONScannerOptions;

/// CDataScanner subclass that understands JSON syntax natively. You should generally use CJSONDeserializer instead of this class. (TODO - this could have been a category?)
@interface CJSONScanner : CDataScanner {
	BOOL strictEscapeCodes;
    id nullObject;
	NSStringEncoding allowedEncoding;
    EJSONScannerOptions options;
}

@property (readwrite, nonatomic, assign) BOOL strictEscapeCodes;
@property (readwrite, nonatomic, retain) id nullObject;
@property (readwrite, nonatomic, assign) NSStringEncoding allowedEncoding;
@property (readwrite, nonatomic, assign) EJSONScannerOptions options;

- (BOOL)setData:(NSData *)inData error:(NSError **)outError;

- (BOOL)scanJSONObject:(id *)outObject error:(NSError **)outError;
- (BOOL)scanJSONDictionary:(NSDictionary **)outDictionary error:(NSError **)outError;
- (BOOL)scanJSONArray:(NSArray **)outArray error:(NSError **)outError;
- (BOOL)scanJSONStringConstant:(NSString **)outStringConstant error:(NSError **)outError;
- (BOOL)scanJSONNumberConstant:(NSNumber **)outNumberConstant error:(NSError **)outError;

@end

extern NSString *const kJSONScannerErrorDomain /* = @"kJSONScannerErrorDomain" */;

typedef enum {
    
    // Fundamental scanning errors
    kJSONScannerErrorCode_NothingToScan = -11,
    kJSONScannerErrorCode_CouldNotDecodeData = -12,
    kJSONScannerErrorCode_CouldNotSerializeData = -13,
    kJSONScannerErrorCode_CouldNotSerializeObject = -14,
    kJSONScannerErrorCode_CouldNotScanObject = -15,
    
    // Dictionary scanning
    kJSONScannerErrorCode_DictionaryStartCharacterMissing = -101,
    kJSONScannerErrorCode_DictionaryKeyScanFailed = -102,
    kJSONScannerErrorCode_DictionaryKeyNotTerminated = -103,
    kJSONScannerErrorCode_DictionaryValueScanFailed = -104,
    kJSONScannerErrorCode_DictionaryKeyValuePairNoDelimiter = -105,
    kJSONScannerErrorCode_DictionaryNotTerminated = -106,
    
    // Array scanning
    kJSONScannerErrorCode_ArrayStartCharacterMissing = -201,
    kJSONScannerErrorCode_ArrayValueScanFailed = -202,
    kJSONScannerErrorCode_ArrayValueIsNull = -203,
    kJSONScannerErrorCode_ArrayNotTerminated = -204,
    
    // String scanning
    kJSONScannerErrorCode_StringNotStartedWithBackslash = -301,
    kJSONScannerErrorCode_StringUnicodeNotDecoded = -302,
    kJSONScannerErrorCode_StringUnknownEscapeCode = -303,
    kJSONScannerErrorCode_StringNotTerminated = -304,
    
    // Number scanning
    kJSONScannerErrorCode_NumberNotScannable = -401
    
} EJSONScannerErrorCode;
