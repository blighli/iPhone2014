#import <Foundation/Foundation.h>

// 维修指派
@interface RepairAssignModel : NSObject
<NSCoding,NSCopying>

@property (nonatomic,assign) int djLsh;          // 单据流水号
@property (nonatomic,copy) NSString *assignCode; // 指派编号
@property (nonatomic,copy) NSString *repairCode; // 维修编号
@property (nonatomic,copy) NSString *techCode;   // 职工编号
@property (nonatomic,copy) NSString *techName;   // 职工名称
@property (nonatomic,copy) NSString *assignTime; // 指派时间
@property (nonatomic,assign) int doneState;      // 完成状态
@property (nonatomic,copy) NSString *doneTime;   // 完成时间
@property (nonatomic,assign) BOOL ifMoneyRepair; // 是否收费维修
@property (nonatomic,assign) float moneyCount;   // 费用数量

+(RepairAssignModel *)itemWithDict:(NSDictionary *)dict;

-(void)exchangeNil;               // 替换所有的nil为空字符串
-(NSMutableString *)getJsonValue; // 转换成Json字符串
-(NSMutableString *)getXmlValue;  // 转换成Xml字符串

@end

