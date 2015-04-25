#import <Foundation/Foundation.h>

// 技工信息
@interface TechInfoModel : NSObject
<NSCoding,NSCopying>

@property (nonatomic,assign) int djLsh;           // 单据流水号
@property (nonatomic,assign) int regionID;        // 区域ID
@property (nonatomic,copy) NSString *groupCode;   // 分组编号
@property (nonatomic,copy) NSString *techCode;    // 职工编号
@property (nonatomic,copy) NSString *passWord;    // 密码
@property (nonatomic,copy) NSString *techName;    // 技工姓名
@property (nonatomic,copy) NSString *PYJM;        // 拼音简码
@property (nonatomic,copy) NSString *techSex;     // 技工性别
@property (nonatomic,copy) NSString *homeAddress; // 家庭地址
@property (nonatomic,copy) NSString *homePhone;   // 家庭电话
@property (nonatomic,copy) NSString *faxNumber;   // 传真号码
@property (nonatomic,copy) NSString *mobilePhone; // 手机号码
@property (nonatomic,copy) NSString *createTime;  // 创建时间

+(TechInfoModel *)itemWithDict:(NSDictionary *)dict;

-(void)exchangeNil;               // 替换所有的nil为空字符串
-(NSMutableString *)getJsonValue; // 转换成Json字符串
-(NSMutableString *)getXmlValue;  // 转换成Xml字符串

@end

