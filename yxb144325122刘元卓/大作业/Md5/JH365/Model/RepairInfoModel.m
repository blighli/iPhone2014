#import "RepairInfoModel.h"

@implementation RepairInfoModel

@synthesize djLsh;
@synthesize repairCode;
@synthesize customKind;
@synthesize companyName;
@synthesize customName;
@synthesize deviceName;
@synthesize deviceMainTypeName;
@synthesize deviceSubTypeName;
@synthesize realName;
@synthesize address;
@synthesize phoneNum;
@synthesize createTime;
@synthesize createUserName;
@synthesize callTime;
@synthesize problemDesc;
@synthesize repairState;
@synthesize ifAssigned;
@synthesize assignTechCode;
@synthesize assignTechName;
@synthesize assignTime;
@synthesize ifMoneyRepair;
@synthesize moneyRepair;
@synthesize repairBackMsg;
@synthesize needMaterial;
@synthesize ifCallBack;
@synthesize customFeelLevel;
@synthesize customBackMsg;
@synthesize ifDelete;

-(void)dealloc
{
    self.repairCode = nil;
    self.customKind = nil;
    self.companyName = nil;
    self.customName = nil;
    self.deviceName = nil;
    self.deviceMainTypeName = nil;
    self.deviceSubTypeName = nil;
    self.realName = nil;
    self.address = nil;
    self.phoneNum = nil;
    self.createTime = nil;
    self.createUserName = nil;
    self.callTime = nil;
    self.problemDesc = nil;
    self.assignTechCode = nil;
    self.assignTechName = nil;
    self.assignTime = nil;
    self.repairBackMsg = nil;
    self.needMaterial = nil;
    self.customFeelLevel = nil;
    self.customBackMsg = nil;
    [super dealloc];
}

+(RepairInfoModel *)itemWithDict:(NSDictionary *)dict
{
    RepairInfoModel *item = [[[RepairInfoModel alloc] init] autorelease];
    item.djLsh = [[dict valueForKey:@"DjLsh"] intValue];
    item.repairCode = [dict valueForKey:@"RepairCode"];
    item.customKind = [dict valueForKey:@"CustomKind"];
    item.companyName = [dict valueForKey:@"CompanyName"];
    item.customName = [dict valueForKey:@"CustomName"];
    item.deviceName = [dict valueForKey:@"DeviceName"];
    item.deviceMainTypeName = [dict valueForKey:@"DeviceMainTypeName"];
    item.deviceSubTypeName = [dict valueForKey:@"DeviceSubTypeName"];
    item.realName = [dict valueForKey:@"RealName"];
    item.address = [dict valueForKey:@"Address"];
    item.phoneNum = [dict valueForKey:@"PhoneNum"];
    item.createTime = [dict valueForKey:@"CreateTime"];
    item.createUserName = [dict valueForKey:@"CreateUserName"];
    item.callTime = [dict valueForKey:@"CallTime"];
    item.problemDesc = [dict valueForKey:@"ProblemDesc"];
    item.repairState = [[dict valueForKey:@"RepairState"] intValue];
    item.ifAssigned = [[[dict valueForKey:@"IfAssigned"] lowercaseString] boolValue];
    item.assignTechCode = [dict valueForKey:@"AssignTechCode"];
    item.assignTechName = [dict valueForKey:@"AssignTechName"];
    item.assignTime = [dict valueForKey:@"AssignTime"];
    item.ifMoneyRepair = [[[dict valueForKey:@"IfMoneyRepair"] lowercaseString] boolValue];
    item.moneyRepair = [[dict valueForKey:@"MoneyRepair"] floatValue];
    item.repairBackMsg = [dict valueForKey:@"RepairBackMsg"];
    item.needMaterial = [dict valueForKey:@"NeedMaterial"];
    item.ifCallBack = [[[dict valueForKey:@"IfCallBack"] lowercaseString] boolValue];
    item.customFeelLevel = [dict valueForKey:@"CustomFeelLevel"];
    item.customBackMsg = [dict valueForKey:@"CustomBackMsg"];
    item.ifDelete = [[[dict valueForKey:@"IfDelete"] lowercaseString] boolValue];
    return item;
}

-(void)exchangeNil
{
    if(repairCode == nil) repairCode = @"";
    if(customKind == nil) customKind = @"";
    if(companyName == nil) companyName = @"";
    if(customName == nil) customName = @"";
    if(deviceName == nil) deviceName = @"";
    if(deviceMainTypeName == nil) deviceMainTypeName = @"";
    if(deviceSubTypeName == nil) deviceSubTypeName = @"";
    if(realName == nil) realName = @"";
    if(address == nil) address = @"";
    if(phoneNum == nil) phoneNum = @"";
    if(createTime == nil) createTime = @"";
    if(createUserName == nil) createUserName = @"";
    if(callTime == nil) callTime = @"";
    if(problemDesc == nil) problemDesc = @"";
    if(assignTechCode == nil) assignTechCode = @"";
    if(assignTechName == nil) assignTechName = @"";
    if(assignTime == nil) assignTime = @"";
    if(repairBackMsg == nil) repairBackMsg = @"";
    if(needMaterial == nil) needMaterial = @"";
    if(customFeelLevel == nil) customFeelLevel = @"";
    if(customBackMsg == nil) customBackMsg = @"";
    [super dealloc];
}
-(NSMutableString *)getJsonValue
{
    [self exchangeNil];

    NSMutableString * jsonItem = [NSMutableString string];
    [jsonItem appendFormat:@"{"];
    [jsonItem appendFormat:@"\"DjLsh\":%i,", djLsh];
    [jsonItem appendFormat:@"\"RepairCode\":\"%@\",", repairCode];
    [jsonItem appendFormat:@"\"CustomKind\":\"%@\",", customKind];
    [jsonItem appendFormat:@"\"CompanyName\":\"%@\",", companyName];
    [jsonItem appendFormat:@"\"CustomName\":\"%@\",", customName];
    [jsonItem appendFormat:@"\"DeviceName\":\"%@\",", deviceName];
    [jsonItem appendFormat:@"\"DeviceMainTypeName\":\"%@\",", deviceMainTypeName];
    [jsonItem appendFormat:@"\"DeviceSubTypeName\":\"%@\",", deviceSubTypeName];
    [jsonItem appendFormat:@"\"RealName\":\"%@\",", realName];
    [jsonItem appendFormat:@"\"Address\":\"%@\",", address];
    [jsonItem appendFormat:@"\"PhoneNum\":\"%@\",", phoneNum];
    [jsonItem appendFormat:@"\"CreateTime\":\"%@\",", createTime];
    [jsonItem appendFormat:@"\"CreateUserName\":\"%@\",", createUserName];
    [jsonItem appendFormat:@"\"CallTime\":\"%@\",", callTime];
    [jsonItem appendFormat:@"\"ProblemDesc\":\"%@\",", problemDesc];
    [jsonItem appendFormat:@"\"RepairState\":%i,", repairState];
    [jsonItem appendFormat:@"\"IfAssigned\":%i,", ifAssigned];
    [jsonItem appendFormat:@"\"AssignTechCode\":\"%@\",", assignTechCode];
    [jsonItem appendFormat:@"\"AssignTechName\":\"%@\",", assignTechName];
    [jsonItem appendFormat:@"\"AssignTime\":\"%@\",", assignTime];
    [jsonItem appendFormat:@"\"IfMoneyRepair\":%i,", ifMoneyRepair];
    [jsonItem appendFormat:@"\"MoneyRepair\":%f,", moneyRepair];
    [jsonItem appendFormat:@"\"RepairBackMsg\":\"%@\",", repairBackMsg];
    [jsonItem appendFormat:@"\"NeedMaterial\":\"%@\",", needMaterial];
    [jsonItem appendFormat:@"\"IfCallBack\":%i,", ifCallBack];
    [jsonItem appendFormat:@"\"CustomFeelLevel\":\"%@\",", customFeelLevel];
    [jsonItem appendFormat:@"\"CustomBackMsg\":\"%@\",", customBackMsg];
    [jsonItem appendFormat:@"\"IfDelete\":%i", ifDelete];
    [jsonItem appendFormat:@"}"];
    return jsonItem;
}
-(NSMutableString *)getXmlValue
{
    [self exchangeNil];

    NSMutableString *xmlItem = [NSMutableString string];
    [xmlItem appendFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"];
    [xmlItem appendFormat:@"<item>"];
    [xmlItem appendFormat:@"<DjLsh>%i</DjLsh>",djLsh];
    [xmlItem appendFormat:@"<RepairCode>%@</RepairCode>",repairCode];
    [xmlItem appendFormat:@"<CustomKind>%@</CustomKind>",customKind];
    [xmlItem appendFormat:@"<CompanyName>%@</CompanyName>",companyName];
    [xmlItem appendFormat:@"<CustomName>%@</CustomName>",customName];
    [xmlItem appendFormat:@"<DeviceName>%@</DeviceName>",deviceName];
    [xmlItem appendFormat:@"<DeviceMainTypeName>%@</DeviceMainTypeName>",deviceMainTypeName];
    [xmlItem appendFormat:@"<DeviceSubTypeName>%@</DeviceSubTypeName>",deviceSubTypeName];
    [xmlItem appendFormat:@"<RealName>%@</RealName>",realName];
    [xmlItem appendFormat:@"<Address>%@</Address>",address];
    [xmlItem appendFormat:@"<PhoneNum>%@</PhoneNum>",phoneNum];
    [xmlItem appendFormat:@"<CreateTime>%@</CreateTime>",createTime];
    [xmlItem appendFormat:@"<CreateUserName>%@</CreateUserName>",createUserName];
    [xmlItem appendFormat:@"<CallTime>%@</CallTime>",callTime];
    [xmlItem appendFormat:@"<ProblemDesc>%@</ProblemDesc>",problemDesc];
    [xmlItem appendFormat:@"<RepairState>%i</RepairState>",repairState];
    [xmlItem appendFormat:@"<IfAssigned>%i</IfAssigned>",ifAssigned];
    [xmlItem appendFormat:@"<AssignTechCode>%@</AssignTechCode>",assignTechCode];
    [xmlItem appendFormat:@"<AssignTechName>%@</AssignTechName>",assignTechName];
    [xmlItem appendFormat:@"<AssignTime>%@</AssignTime>",assignTime];
    [xmlItem appendFormat:@"<IfMoneyRepair>%i</IfMoneyRepair>",ifMoneyRepair];
    [xmlItem appendFormat:@"<MoneyRepair>%f</MoneyRepair>",moneyRepair];
    [xmlItem appendFormat:@"<RepairBackMsg>%@</RepairBackMsg>",repairBackMsg];
    [xmlItem appendFormat:@"<NeedMaterial>%@</NeedMaterial>",needMaterial];
    [xmlItem appendFormat:@"<IfCallBack>%i</IfCallBack>",ifCallBack];
    [xmlItem appendFormat:@"<CustomFeelLevel>%@</CustomFeelLevel>",customFeelLevel];
    [xmlItem appendFormat:@"<CustomBackMsg>%@</CustomBackMsg>",customBackMsg];
    [xmlItem appendFormat:@"<IfDelete>%i</IfDelete>",ifDelete];
    [xmlItem appendFormat:@"</item>"];
    return xmlItem;
}

#pragma mark - NSCoding
-(void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeInt:djLsh forKey: @"djLsh"];
    [encoder encodeObject:repairCode forKey: @"repairCode"];
    [encoder encodeObject:customKind forKey: @"customKind"];
    [encoder encodeObject:companyName forKey: @"companyName"];
    [encoder encodeObject:customName forKey: @"customName"];
    [encoder encodeObject:deviceName forKey: @"deviceName"];
    [encoder encodeObject:deviceMainTypeName forKey: @"deviceMainTypeName"];
    [encoder encodeObject:deviceSubTypeName forKey: @"deviceSubTypeName"];
    [encoder encodeObject:realName forKey: @"realName"];
    [encoder encodeObject:address forKey: @"address"];
    [encoder encodeObject:phoneNum forKey: @"phoneNum"];
    [encoder encodeObject:createTime forKey: @"createTime"];
    [encoder encodeObject:createUserName forKey: @"createUserName"];
    [encoder encodeObject:callTime forKey: @"callTime"];
    [encoder encodeObject:problemDesc forKey: @"problemDesc"];
    [encoder encodeInt:repairState forKey: @"repairState"];
    [encoder encodeBool:ifAssigned forKey: @"ifAssigned"];
    [encoder encodeObject:assignTechCode forKey: @"assignTechCode"];
    [encoder encodeObject:assignTechName forKey: @"assignTechName"];
    [encoder encodeObject:assignTime forKey: @"assignTime"];
    [encoder encodeBool:ifMoneyRepair forKey: @"ifMoneyRepair"];
    [encoder encodeFloat:moneyRepair forKey: @"moneyRepair"];
    [encoder encodeObject:repairBackMsg forKey: @"repairBackMsg"];
    [encoder encodeObject:needMaterial forKey: @"needMaterial"];
    [encoder encodeBool:ifCallBack forKey: @"ifCallBack"];
    [encoder encodeObject:customFeelLevel forKey: @"customFeelLevel"];
    [encoder encodeObject:customBackMsg forKey: @"customBackMsg"];
    [encoder encodeBool:ifDelete forKey: @"ifDelete"];
}
-(id) initWithCoder: (NSCoder *) decoder
{
    djLsh = [decoder decodeIntForKey:@"djLsh"];
    repairCode = [[decoder decodeObjectForKey:@"repairCode"] retain];
    customKind = [[decoder decodeObjectForKey:@"customKind"] retain];
    companyName = [[decoder decodeObjectForKey:@"companyName"] retain];
    customName = [[decoder decodeObjectForKey:@"customName"] retain];
    deviceName = [[decoder decodeObjectForKey:@"deviceName"] retain];
    deviceMainTypeName = [[decoder decodeObjectForKey:@"deviceMainTypeName"] retain];
    deviceSubTypeName = [[decoder decodeObjectForKey:@"deviceSubTypeName"] retain];
    realName = [[decoder decodeObjectForKey:@"realName"] retain];
    address = [[decoder decodeObjectForKey:@"address"] retain];
    phoneNum = [[decoder decodeObjectForKey:@"phoneNum"] retain];
    createTime = [[decoder decodeObjectForKey:@"createTime"] retain];
    createUserName = [[decoder decodeObjectForKey:@"createUserName"] retain];
    callTime = [[decoder decodeObjectForKey:@"callTime"] retain];
    problemDesc = [[decoder decodeObjectForKey:@"problemDesc"] retain];
    repairState = [decoder decodeIntForKey:@"repairState"];
    ifAssigned = [decoder decodeBoolForKey:@"ifAssigned"];
    assignTechCode = [[decoder decodeObjectForKey:@"assignTechCode"] retain];
    assignTechName = [[decoder decodeObjectForKey:@"assignTechName"] retain];
    assignTime = [[decoder decodeObjectForKey:@"assignTime"] retain];
    ifMoneyRepair = [decoder decodeBoolForKey:@"ifMoneyRepair"];
    moneyRepair = [decoder decodeFloatForKey:@"moneyRepair"];
    repairBackMsg = [[decoder decodeObjectForKey:@"repairBackMsg"] retain];
    needMaterial = [[decoder decodeObjectForKey:@"needMaterial"] retain];
    ifCallBack = [decoder decodeBoolForKey:@"ifCallBack"];
    customFeelLevel = [[decoder decodeObjectForKey:@"customFeelLevel"] retain];
    customBackMsg = [[decoder decodeObjectForKey:@"customBackMsg"] retain];
    ifDelete = [decoder decodeBoolForKey:@"ifDelete"];

    return self;
}

#pragma mark - NSCopying
// 复制
-(id)copyWithZone:(NSZone *)zone
{
    RepairInfoModel *newItem = [[RepairInfoModel allocWithZone: zone] init];

    newItem.djLsh = self.djLsh;
    newItem.repairCode = self.repairCode;
    newItem.customKind = self.customKind;
    newItem.companyName = self.companyName;
    newItem.customName = self.customName;
    newItem.deviceName = self.deviceName;
    newItem.deviceMainTypeName = self.deviceMainTypeName;
    newItem.deviceSubTypeName = self.deviceSubTypeName;
    newItem.realName = self.realName;
    newItem.address = self.address;
    newItem.phoneNum = self.phoneNum;
    newItem.createTime = self.createTime;
    newItem.createUserName = self.createUserName;
    newItem.callTime = self.callTime;
    newItem.problemDesc = self.problemDesc;
    newItem.repairState = self.repairState;
    newItem.ifAssigned = self.ifAssigned;
    newItem.assignTechCode = self.assignTechCode;
    newItem.assignTechName = self.assignTechName;
    newItem.assignTime = self.assignTime;
    newItem.ifMoneyRepair = self.ifMoneyRepair;
    newItem.moneyRepair = self.moneyRepair;
    newItem.repairBackMsg = self.repairBackMsg;
    newItem.needMaterial = self.needMaterial;
    newItem.ifCallBack = self.ifCallBack;
    newItem.customFeelLevel = self.customFeelLevel;
    newItem.customBackMsg = self.customBackMsg;
    newItem.ifDelete = self.ifDelete;

	return newItem;
}

@end

