#import <Foundation/Foundation.h>

// 客户公司
@interface CustomCompanyModel : NSObject
<NSCoding,NSCopying>

@property (nonatomic,assign) int djLsh; // 单据流水号
@property (nonatomic,copy) NSString *companyCode; // 公司编号
@property (nonatomic,copy) NSString *companyName; // 公司名称
@property (nonatomic,copy) NSString *pYJM; // 拼音简码
@property (nonatomic,assign) int peopleCount; // 人数
@property (nonatomic,copy) NSString *beginTime; // 开始时间
@property (nonatomic,copy) NSString *keepTime; // 续费时间
@property (nonatomic,copy) NSString *endTime; // 结束时间
@property (nonatomic,copy) NSString *insuranceTypeCode; // 保险类型编号
@property (nonatomic,copy) NSString *insuranceNumber; // 保险单号
@property (nonatomic,copy) NSString *contactName; // 联系人
@property (nonatomic,copy) NSString *address; // 地址
@property (nonatomic,copy) NSString *phoneNum; // 电话号码
@property (nonatomic,copy) NSString *email; // 电子邮箱
@property (nonatomic,copy) NSString *dutyServer; // 服务负责人
@property (nonatomic,assign) int createUserID; // 制单人编号
@property (nonatomic,copy) NSString *createTime; // 创建时间
@property (nonatomic,assign) BOOL ifPerson; // IfPerson

+(CustomCompanyModel *)itemWithDict:(NSDictionary *)dict;

-(void)exchangeNil;               // 替换所有的nil为空字符串
-(NSMutableString *)getJsonValue; // 转换成Json字符串
-(NSMutableString *)getXmlValue;  // 转换成Xml字符串

@end

