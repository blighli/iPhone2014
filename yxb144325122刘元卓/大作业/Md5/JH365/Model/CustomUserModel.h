#import <Foundation/Foundation.h>

// 客户联系人
@interface CustomUserModel : NSObject
<NSCoding,NSCopying>

@property (nonatomic,assign) int djLsh;             // 单据流水号
@property (nonatomic,copy) NSString *companyCode;   // 公司编号
@property (nonatomic,assign) int regionID;          // 区域ID
@property (nonatomic,copy) NSString *regionName;    // 区域名称
@property (nonatomic,copy) NSString *customCode;    // 客户编号
@property (nonatomic,copy) NSString *customName;    // 客户名称
@property (nonatomic,copy) NSString *homeAddress;   // 家庭地址
@property (nonatomic,copy) NSString *homePhone;     // 家庭电话
@property (nonatomic,copy) NSString *workPhone;     // 办公电话
@property (nonatomic,copy) NSString *faxNumber;     // 传真号码
@property (nonatomic,copy) NSString *mobilePhone;   // 手机号码
@property (nonatomic,copy) NSString *insuranceTypeName; // 保险类型名称
@property (nonatomic,copy) NSString *insuranceNumber;   // 保险单号
@property (nonatomic,copy) NSString *beginTime;     // 开始时间
@property (nonatomic,copy) NSString *keepTime;      // 续费时间
@property (nonatomic,copy) NSString *endTime;       // 结束时间

+(CustomUserModel *)itemWithDict:(NSDictionary *)dict;

-(void)exchangeNil;               // 替换所有的nil为空字符串
-(NSMutableString *)getJsonValue; // 转换成Json字符串
-(NSMutableString *)getXmlValue;  // 转换成Xml字符串

@end

