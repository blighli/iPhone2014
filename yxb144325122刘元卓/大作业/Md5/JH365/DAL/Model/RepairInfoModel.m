#import "RepairInfoModel.h"

@implementation RepairInfoModel

@synthesize djLsh;
@synthesize repairCode;
@synthesize regionID;
@synthesize customKind;
@synthesize companyCode;
@synthesize companyName;
@synthesize customCode;
@synthesize customName;
@synthesize deviceName;
@synthesize deviceMainTypeCode;
@synthesize deviceMainTypeName;
@synthesize deviceSubTypeCode;
@synthesize deviceSubTypeName;
@synthesize realName;
@synthesize address;
@synthesize phoneNum;
@synthesize createTime;
@synthesize createUserID;
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
@synthesize callInID;
@synthesize callBackID;
@synthesize ifCallBack;
@synthesize customFeelLevel;
@synthesize customBackMsg;
@synthesize ifDelete;

-(void)dealloc
{
    self.repairCode = nil;
    self.customKind = nil;
    self.companyCode = nil;
    self.companyName = nil;
    self.customCode = nil;
    self.customName = nil;
    self.deviceName = nil;
    self.deviceMainTypeCode = nil;
    self.deviceMainTypeName = nil;
    self.deviceSubTypeCode = nil;
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
    item.regionID = [[dict valueForKey:@"RegionID"] intValue];
    item.customKind = [dict valueForKey:@"CustomKind"];
    item.companyCode = [dict valueForKey:@"CompanyCode"];
    item.companyName = [dict valueForKey:@"CompanyName"];
    item.customCode = [dict valueForKey:@"CustomCode"];
    item.customName = [dict valueForKey:@"CustomName"];
    item.deviceName = [dict valueForKey:@"DeviceName"];
    item.deviceMainTypeCode = [dict valueForKey:@"DeviceMainTypeCode"];
    item.deviceMainTypeName = [dict valueForKey:@"DeviceMainTypeName"];
    item.deviceSubTypeCode = [dict valueForKey:@"DeviceSubTypeCode"];
    item.deviceSubTypeName = [dict valueForKey:@"DeviceSubTypeName"];
    item.realName = [dict valueForKey:@"RealName"];
    item.address = [dict valueForKey:@"Address"];
    item.phoneNum = [dict valueForKey:@"PhoneNum"];
    item.createTime = [dict valueForKey:@"CreateTime"];
    item.createUserID = [[dict valueForKey:@"CreateUserID"] intValue];
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
    item.callInID = [[dict valueForKey:@"CallInID"] intValue];
    item.callBackID = [[dict valueForKey:@"CallBackID"] intValue];
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
    if(companyCode == nil) companyCode = @"";
    if(companyName == nil) companyName = @"";
    if(customCode == nil) customCode = @"";
    if(customName == nil) customName = @"";
    if(deviceName == nil) deviceName = @"";
    if(deviceMainTypeCode == nil) deviceMainTypeCode = @"";
    if(deviceMainTypeName == nil) deviceMainTypeName = @"";
    if(deviceSubTypeCode == nil) deviceSubTypeCode = @"";
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
    [jsonItem appendFormat:@"\"RegionID\":%i,", regionID];
    [jsonItem appendFormat:@"\"CustomKind\":\"%@\",", customKind];
    [jsonItem appendFormat:@"\"CompanyCode\":\"%@\",", companyCode];
    [jsonItem appendFormat:@"\"CompanyName\":\"%@\",", companyName];
    [jsonItem appendFormat:@"\"CustomCode\":\"%@\",", customCode];
    [jsonItem appendFormat:@"\"CustomName\":\"%@\",", customName];
    [jsonItem appendFormat:@"\"DeviceName\":\"%@\",", deviceName];
    [jsonItem appendFormat:@"\"DeviceMainTypeCode\":\"%@\",", deviceMainTypeCode];
    [jsonItem appendFormat:@"\"DeviceMainTypeName\":\"%@\",", deviceMainTypeName];
    [jsonItem appendFormat:@"\"DeviceSubTypeCode\":\"%@\",", deviceSubTypeCode];
    [jsonItem appendFormat:@"\"DeviceSubTypeName\":\"%@\",", deviceSubTypeName];
    [jsonItem appendFormat:@"\"RealName\":\"%@\",", realName];
    [jsonItem appendFormat:@"\"Address\":\"%@\",", address];
    [jsonItem appendFormat:@"\"PhoneNum\":\"%@\",", phoneNum];
    [jsonItem appendFormat:@"\"CreateTime\":\"%@\",", createTime];
    [jsonItem appendFormat:@"\"CreateUserID\":%i,", createUserID];
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
    [jsonItem appendFormat:@"\"CallInID\":%i,", callInID];
    [jsonItem appendFormat:@"\"CallBackID\":%i,", callBackID];
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
    [xmlItem appendFormat:@"<RegionID>%i</RegionID>",regionID];
    [xmlItem appendFormat:@"<CustomKind>%@</CustomKind>",customKind];
    [xmlItem appendFormat:@"<CompanyCode>%@</CompanyCode>",companyCode];
    [xmlItem appendFormat:@"<CompanyName>%@</CompanyName>",companyName];
    [xmlItem appendFormat:@"<CustomCode>%@</CustomCode>",customCode];
    [xmlItem appendFormat:@"<CustomName>%@</CustomName>",customName];
    [xmlItem appendFormat:@"<DeviceName>%@</DeviceName>",deviceName];
    [xmlItem appendFormat:@"<DeviceMainTypeCode>%@</DeviceMainTypeCode>",deviceMainTypeCode];
    [xmlItem appendFormat:@"<DeviceMainTypeName>%@</DeviceMainTypeName>",deviceMainTypeName];
    [xmlItem appendFormat:@"<DeviceSubTypeCode>%@</DeviceSubTypeCode>",deviceSubTypeCode];
    [xmlItem appendFormat:@"<DeviceSubTypeName>%@</DeviceSubTypeName>",deviceSubTypeName];
    [xmlItem appendFormat:@"<RealName>%@</RealName>",realName];
    [xmlItem appendFormat:@"<Address>%@</Address>",address];
    [xmlItem appendFormat:@"<PhoneNum>%@</PhoneNum>",phoneNum];
    [xmlItem appendFormat:@"<CreateTime>%@</CreateTime>",createTime];
    [xmlItem appendFormat:@"<CreateUserID>%i</CreateUserID>",createUserID];
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
    [xmlItem appendFormat:@"<CallInID>%i</CallInID>",callInID];
    [xmlItem appendFormat:@"<CallBackID>%i</CallBackID>",callBackID];
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
    [encoder encodeInt:regionID forKey: @"regionID"];
    [encoder encodeObject:customKind forKey: @"customKind"];
    [encoder encodeObject:companyCode forKey: @"companyCode"];
    [encoder encodeObject:companyName forKey: @"companyName"];
    [encoder encodeObject:customCode forKey: @"customCode"];
    [encoder encodeObject:customName forKey: @"customName"];
    [encoder encodeObject:deviceName forKey: @"deviceName"];
    [encoder encodeObject:deviceMainTypeCode forKey: @"deviceMainTypeCode"];
    [encoder encodeObject:deviceMainTypeName forKey: @"deviceMainTypeName"];
    [encoder encodeObject:deviceSubTypeCode forKey: @"deviceSubTypeCode"];
    [encoder encodeObject:deviceSubTypeName forKey: @"deviceSubTypeName"];
    [encoder encodeObject:realName forKey: @"realName"];
    [encoder encodeObject:address forKey: @"address"];
    [encoder encodeObject:phoneNum forKey: @"phoneNum"];
    [encoder encodeObject:createTime forKey: @"createTime"];
    [encoder encodeInt:createUserID forKey: @"createUserID"];
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
    [encoder encodeInt:callInID forKey: @"callInID"];
    [encoder encodeInt:callBackID forKey: @"callBackID"];
    [encoder encodeBool:ifCallBack forKey: @"ifCallBack"];
    [encoder encodeObject:customFeelLevel forKey: @"customFeelLevel"];
    [encoder encodeObject:customBackMsg forKey: @"customBackMsg"];
    [encoder encodeBool:ifDelete forKey: @"ifDelete"];
}
-(id) initWithCoder: (NSCoder *) decoder
{
    djLsh = [decoder decodeIntForKey:@"djLsh"];
    repairCode = [[decoder decodeObjectForKey:@"repairCode"] retain];
    regionID = [decoder decodeIntForKey:@"regionID"];
    customKind = [[decoder decodeObjectForKey:@"customKind"] retain];
    companyCode = [[decoder decodeObjectForKey:@"companyCode"] retain];
    companyName = [[decoder decodeObjectForKey:@"companyName"] retain];
    customCode = [[decoder decodeObjectForKey:@"customCode"] retain];
    customName = [[decoder decodeObjectForKey:@"customName"] retain];
    deviceName = [[decoder decodeObjectForKey:@"deviceName"] retain];
    deviceMainTypeCode = [[decoder decodeObjectForKey:@"deviceMainTypeCode"] retain];
    deviceMainTypeName = [[decoder decodeObjectForKey:@"deviceMainTypeName"] retain];
    deviceSubTypeCode = [[decoder decodeObjectForKey:@"deviceSubTypeCode"] retain];
    deviceSubTypeName = [[decoder decodeObjectForKey:@"deviceSubTypeName"] retain];
    realName = [[decoder decodeObjectForKey:@"realName"] retain];
    address = [[decoder decodeObjectForKey:@"address"] retain];
    phoneNum = [[decoder decodeObjectForKey:@"phoneNum"] retain];
    createTime = [[decoder decodeObjectForKey:@"createTime"] retain];
    createUserID = [decoder decodeIntForKey:@"createUserID"];
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
    callInID = [decoder decodeIntForKey:@"callInID"];
    callBackID = [decoder decodeIntForKey:@"callBackID"];
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
    newItem.regionID = self.regionID;
    newItem.customKind = self.customKind;
    newItem.companyCode = self.companyCode;
    newItem.companyName = self.companyName;
    newItem.customCode = self.customCode;
    newItem.customName = self.customName;
    newItem.deviceName = self.deviceName;
    newItem.deviceMainTypeCode = self.deviceMainTypeCode;
    newItem.deviceMainTypeName = self.deviceMainTypeName;
    newItem.deviceSubTypeCode = self.deviceSubTypeCode;
    newItem.deviceSubTypeName = self.deviceSubTypeName;
    newItem.realName = self.realName;
    newItem.address = self.address;
    newItem.phoneNum = self.phoneNum;
    newItem.createTime = self.createTime;
    newItem.createUserID = self.createUserID;
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
    newItem.callInID = self.callInID;
    newItem.callBackID = self.callBackID;
    newItem.ifCallBack = self.ifCallBack;
    newItem.customFeelLevel = self.customFeelLevel;
    newItem.customBackMsg = self.customBackMsg;
    newItem.ifDelete = self.ifDelete;

	return newItem;
}

@end

