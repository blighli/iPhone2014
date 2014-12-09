#import <Foundation/Foundation.h>

// 维修信息
@interface RepairInfoModel : NSObject
<NSCoding,NSCopying>

@property (nonatomic,assign) int djLsh; // 单据流水号
@property (nonatomic,copy) NSString *repairCode; // 维修编号
@property (nonatomic,assign) int regionID; // 区域ID
@property (nonatomic,copy) NSString *customKind; // 客户类型
@property (nonatomic,copy) NSString *companyCode; // 公司编号
@property (nonatomic,copy) NSString *companyName; // 公司名称
@property (nonatomic,copy) NSString *customCode; // 客户编号
@property (nonatomic,copy) NSString *customName; // 客户名称
@property (nonatomic,copy) NSString *deviceName; // 设备名称
@property (nonatomic,copy) NSString *deviceMainTypeCode; // 设备主类编号
@property (nonatomic,copy) NSString *deviceMainTypeName; // 设备主类名称
@property (nonatomic,copy) NSString *deviceSubTypeCode; // 设备二类编号
@property (nonatomic,copy) NSString *deviceSubTypeName; // 设备二类名称
@property (nonatomic,copy) NSString *realName; // 真实姓名
@property (nonatomic,copy) NSString *address; // 地址
@property (nonatomic,copy) NSString *phoneNum; // 电话号码
@property (nonatomic,copy) NSString *createTime; // 创建时间
@property (nonatomic,assign) int createUserID; // 制单人编号
@property (nonatomic,copy) NSString *createUserName; // 制单人姓名
@property (nonatomic,copy) NSString *callTime; // 通话时间
@property (nonatomic,copy) NSString *problemDesc; // 问题描述
@property (nonatomic,assign) int repairState; // 维修状态
@property (nonatomic,assign) BOOL ifAssigned; // 是否已指派
@property (nonatomic,copy) NSString *assignTechCode; // 指派技工编号
@property (nonatomic,copy) NSString *assignTechName; // 指派技工名称
@property (nonatomic,copy) NSString *assignTime; // 指派时间
@property (nonatomic,assign) BOOL ifMoneyRepair; // 是否收费维修
@property (nonatomic,assign) float moneyRepair; // MoneyRepair
@property (nonatomic,copy) NSString *repairBackMsg; // 维修反馈信息
@property (nonatomic,copy) NSString *needMaterial; // 所需材料
@property (nonatomic,assign) int callInID; // CallInID
@property (nonatomic,assign) int callBackID; // CallBackID
@property (nonatomic,assign) BOOL ifCallBack; // 是否已回访
@property (nonatomic,copy) NSString *customFeelLevel; // 客户满意度
@property (nonatomic,copy) NSString *customBackMsg; // 客户反馈信息
@property (nonatomic,assign) BOOL ifDelete; // IfDelete

+(RepairInfoModel *)itemWithDict:(NSDictionary *)dict;

-(void)exchangeNil;               // 替换所有的nil为空字符串
-(NSMutableString *)getJsonValue; // 转换成Json字符串
-(NSMutableString *)getXmlValue;  // 转换成Xml字符串

@end

