#import <Foundation/Foundation.h>

// 技工分组
@interface TechGroupModel : NSObject
<NSCoding,NSCopying>

@property (nonatomic,assign) int djLsh; // 单据流水号
@property (nonatomic,copy) NSString *groupCode; // 分组编号
@property (nonatomic,copy) NSString *groupName; // 分组名称

+(TechGroupModel *)itemWithDict:(NSDictionary *)dict;

-(void)exchangeNil;               // 替换所有的nil为空字符串
-(NSMutableString *)getJsonValue; // 转换成Json字符串
-(NSMutableString *)getXmlValue;  // 转换成Xml字符串

@end

