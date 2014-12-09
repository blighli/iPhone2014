#import <Foundation/Foundation.h>

// 材料信息
@interface MaterialInfoModel : NSObject
<NSCoding,NSCopying>

@property (nonatomic,assign) int djLsh;            // 单据流水号
@property (nonatomic,copy) NSString *materialCode; // 材料编号
@property (nonatomic,copy) NSString *materialName; // 材料名称
@property (nonatomic,copy) NSString *materialSize; // 材料规格
@property (nonatomic,copy) NSString *materialUnit; // 材料单位

+(MaterialInfoModel *)itemWithDict:(NSDictionary *)dict;

-(void)exchangeNil;               // 替换所有的nil为空字符串
-(NSMutableString *)getJsonValue; // 转换成Json字符串
-(NSMutableString *)getXmlValue;  // 转换成Xml字符串

@end

