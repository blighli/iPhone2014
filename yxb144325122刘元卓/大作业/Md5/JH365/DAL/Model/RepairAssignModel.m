#import "RepairAssignModel.h"

@implementation RepairAssignModel

@synthesize djLsh;
@synthesize regionID;
@synthesize assignCode;
@synthesize repairCode;
@synthesize techCode;
@synthesize assignTime;
@synthesize doneState;
@synthesize doneTime;
@synthesize ifMoneyRepair;
@synthesize moneyCount;

-(void)dealloc
{
    self.assignCode = nil;
    self.repairCode = nil;
    self.techCode = nil;
    self.assignTime = nil;
    self.doneTime = nil;
    [super dealloc];
}

+(RepairAssignModel *)itemWithDict:(NSDictionary *)dict
{
    RepairAssignModel *item = [[[RepairAssignModel alloc] init] autorelease];
    item.djLsh = [[dict valueForKey:@"DjLsh"] intValue];
    item.regionID = [[dict valueForKey:@"RegionID"] intValue];
    item.assignCode = [dict valueForKey:@"AssignCode"];
    item.repairCode = [dict valueForKey:@"RepairCode"];
    item.techCode = [dict valueForKey:@"TechCode"];
    item.assignTime = [dict valueForKey:@"AssignTime"];
    item.doneState = [[dict valueForKey:@"DoneState"] intValue];
    item.doneTime = [dict valueForKey:@"DoneTime"];
    item.ifMoneyRepair = [[[dict valueForKey:@"IfMoneyRepair"] lowercaseString] boolValue];
    item.moneyCount = [[dict valueForKey:@"MoneyCount"] floatValue];
    return item;
}

-(void)exchangeNil
{
    if(assignCode == nil) assignCode = @"";
    if(repairCode == nil) repairCode = @"";
    if(techCode == nil) techCode = @"";
    if(assignTime == nil) assignTime = @"";
    if(doneTime == nil) doneTime = @"";
    [super dealloc];
}
-(NSMutableString *)getJsonValue
{
    [self exchangeNil];

    NSMutableString * jsonItem = [NSMutableString string];
    [jsonItem appendFormat:@"{"];
    [jsonItem appendFormat:@"\"DjLsh\":%i,", djLsh];
    [jsonItem appendFormat:@"\"RegionID\":%i,", regionID];
    [jsonItem appendFormat:@"\"AssignCode\":\"%@\",", assignCode];
    [jsonItem appendFormat:@"\"RepairCode\":\"%@\",", repairCode];
    [jsonItem appendFormat:@"\"TechCode\":\"%@\",", techCode];
    [jsonItem appendFormat:@"\"AssignTime\":\"%@\",", assignTime];
    [jsonItem appendFormat:@"\"DoneState\":%i,", doneState];
    [jsonItem appendFormat:@"\"DoneTime\":\"%@\",", doneTime];
    [jsonItem appendFormat:@"\"IfMoneyRepair\":%i,", ifMoneyRepair];
    [jsonItem appendFormat:@"\"MoneyCount\":%f", moneyCount];
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
    [xmlItem appendFormat:@"<RegionID>%i</RegionID>",regionID];
    [xmlItem appendFormat:@"<AssignCode>%@</AssignCode>",assignCode];
    [xmlItem appendFormat:@"<RepairCode>%@</RepairCode>",repairCode];
    [xmlItem appendFormat:@"<TechCode>%@</TechCode>",techCode];
    [xmlItem appendFormat:@"<AssignTime>%@</AssignTime>",assignTime];
    [xmlItem appendFormat:@"<DoneState>%i</DoneState>",doneState];
    [xmlItem appendFormat:@"<DoneTime>%@</DoneTime>",doneTime];
    [xmlItem appendFormat:@"<IfMoneyRepair>%i</IfMoneyRepair>",ifMoneyRepair];
    [xmlItem appendFormat:@"<MoneyCount>%f</MoneyCount>",moneyCount];
    [xmlItem appendFormat:@"</item>"];
    return xmlItem;
}

#pragma mark - NSCoding
-(void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeInt:djLsh forKey: @"djLsh"];
    [encoder encodeInt:regionID forKey: @"regionID"];
    [encoder encodeObject:assignCode forKey: @"assignCode"];
    [encoder encodeObject:repairCode forKey: @"repairCode"];
    [encoder encodeObject:techCode forKey: @"techCode"];
    [encoder encodeObject:assignTime forKey: @"assignTime"];
    [encoder encodeInt:doneState forKey: @"doneState"];
    [encoder encodeObject:doneTime forKey: @"doneTime"];
    [encoder encodeBool:ifMoneyRepair forKey: @"ifMoneyRepair"];
    [encoder encodeFloat:moneyCount forKey: @"moneyCount"];
}
-(id) initWithCoder: (NSCoder *) decoder
{
    djLsh = [decoder decodeIntForKey:@"djLsh"];
    regionID = [decoder decodeIntForKey:@"regionID"];
    assignCode = [[decoder decodeObjectForKey:@"assignCode"] retain];
    repairCode = [[decoder decodeObjectForKey:@"repairCode"] retain];
    techCode = [[decoder decodeObjectForKey:@"techCode"] retain];
    assignTime = [[decoder decodeObjectForKey:@"assignTime"] retain];
    doneState = [decoder decodeIntForKey:@"doneState"];
    doneTime = [[decoder decodeObjectForKey:@"doneTime"] retain];
    ifMoneyRepair = [decoder decodeBoolForKey:@"ifMoneyRepair"];
    moneyCount = [decoder decodeFloatForKey:@"moneyCount"];

    return self;
}

#pragma mark - NSCopying
// 复制
-(id)copyWithZone:(NSZone *)zone
{
    RepairAssignModel *newItem = [[RepairAssignModel allocWithZone: zone] init];

    newItem.djLsh = self.djLsh;
    newItem.regionID = self.regionID;
    newItem.assignCode = self.assignCode;
    newItem.repairCode = self.repairCode;
    newItem.techCode = self.techCode;
    newItem.assignTime = self.assignTime;
    newItem.doneState = self.doneState;
    newItem.doneTime = self.doneTime;
    newItem.ifMoneyRepair = self.ifMoneyRepair;
    newItem.moneyCount = self.moneyCount;

	return newItem;
}

@end

