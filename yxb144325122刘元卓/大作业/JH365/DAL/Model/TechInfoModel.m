#import "TechInfoModel.h"

@implementation TechInfoModel

@synthesize djLsh;
@synthesize regionID;
@synthesize groupCode;
@synthesize techCode;
@synthesize passWord;
@synthesize techName;
@synthesize pYJM;
@synthesize techSex;
@synthesize homeAddress;
@synthesize homePhone;
@synthesize faxNumber;
@synthesize mobilePhone;
@synthesize createTime;

-(void)dealloc
{
    self.groupCode = nil;
    self.techCode = nil;
    self.passWord = nil;
    self.techName = nil;
    self.pYJM = nil;
    self.techSex = nil;
    self.homeAddress = nil;
    self.homePhone = nil;
    self.faxNumber = nil;
    self.mobilePhone = nil;
    self.createTime = nil;
    [super dealloc];
}

+(TechInfoModel *)itemWithDict:(NSDictionary *)dict
{
    TechInfoModel *item = [[[TechInfoModel alloc] init] autorelease];
    item.djLsh = [[dict valueForKey:@"DjLsh"] intValue];
    item.regionID = [[dict valueForKey:@"RegionID"] intValue];
    item.groupCode = [dict valueForKey:@"GroupCode"];
    item.techCode = [dict valueForKey:@"TechCode"];
    item.passWord = [dict valueForKey:@"PassWord"];
    item.techName = [dict valueForKey:@"TechName"];
    item.pYJM = [dict valueForKey:@"PYJM"];
    item.techSex = [dict valueForKey:@"TechSex"];
    item.homeAddress = [dict valueForKey:@"HomeAddress"];
    item.homePhone = [dict valueForKey:@"HomePhone"];
    item.faxNumber = [dict valueForKey:@"FaxNumber"];
    item.mobilePhone = [dict valueForKey:@"MobilePhone"];
    item.createTime = [dict valueForKey:@"CreateTime"];
    return item;
}

-(void)exchangeNil
{
    if(groupCode == nil) groupCode = @"";
    if(techCode == nil) techCode = @"";
    if(passWord == nil) passWord = @"";
    if(techName == nil) techName = @"";
    if(pYJM == nil) pYJM = @"";
    if(techSex == nil) techSex = @"";
    if(homeAddress == nil) homeAddress = @"";
    if(homePhone == nil) homePhone = @"";
    if(faxNumber == nil) faxNumber = @"";
    if(mobilePhone == nil) mobilePhone = @"";
    if(createTime == nil) createTime = @"";
    [super dealloc];
}
-(NSMutableString *)getJsonValue
{
    [self exchangeNil];

    NSMutableString * jsonItem = [NSMutableString string];
    [jsonItem appendFormat:@"{"];
    [jsonItem appendFormat:@"\"DjLsh\":%i,", djLsh];
    [jsonItem appendFormat:@"\"RegionID\":%i,", regionID];
    [jsonItem appendFormat:@"\"GroupCode\":\"%@\",", groupCode];
    [jsonItem appendFormat:@"\"TechCode\":\"%@\",", techCode];
    [jsonItem appendFormat:@"\"PassWord\":\"%@\",", passWord];
    [jsonItem appendFormat:@"\"TechName\":\"%@\",", techName];
    [jsonItem appendFormat:@"\"PYJM\":\"%@\",", pYJM];
    [jsonItem appendFormat:@"\"TechSex\":\"%@\",", techSex];
    [jsonItem appendFormat:@"\"HomeAddress\":\"%@\",", homeAddress];
    [jsonItem appendFormat:@"\"HomePhone\":\"%@\",", homePhone];
    [jsonItem appendFormat:@"\"FaxNumber\":\"%@\",", faxNumber];
    [jsonItem appendFormat:@"\"MobilePhone\":\"%@\",", mobilePhone];
    [jsonItem appendFormat:@"\"CreateTime\":\"%@\"", createTime];
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
    [xmlItem appendFormat:@"<GroupCode>%@</GroupCode>",groupCode];
    [xmlItem appendFormat:@"<TechCode>%@</TechCode>",techCode];
    [xmlItem appendFormat:@"<PassWord>%@</PassWord>",passWord];
    [xmlItem appendFormat:@"<TechName>%@</TechName>",techName];
    [xmlItem appendFormat:@"<PYJM>%@</PYJM>",pYJM];
    [xmlItem appendFormat:@"<TechSex>%@</TechSex>",techSex];
    [xmlItem appendFormat:@"<HomeAddress>%@</HomeAddress>",homeAddress];
    [xmlItem appendFormat:@"<HomePhone>%@</HomePhone>",homePhone];
    [xmlItem appendFormat:@"<FaxNumber>%@</FaxNumber>",faxNumber];
    [xmlItem appendFormat:@"<MobilePhone>%@</MobilePhone>",mobilePhone];
    [xmlItem appendFormat:@"<CreateTime>%@</CreateTime>",createTime];
    [xmlItem appendFormat:@"</item>"];
    return xmlItem;
}

#pragma mark - NSCoding
-(void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeInt:djLsh forKey: @"djLsh"];
    [encoder encodeInt:regionID forKey: @"regionID"];
    [encoder encodeObject:groupCode forKey: @"groupCode"];
    [encoder encodeObject:techCode forKey: @"techCode"];
    [encoder encodeObject:passWord forKey: @"passWord"];
    [encoder encodeObject:techName forKey: @"techName"];
    [encoder encodeObject:pYJM forKey: @"pYJM"];
    [encoder encodeObject:techSex forKey: @"techSex"];
    [encoder encodeObject:homeAddress forKey: @"homeAddress"];
    [encoder encodeObject:homePhone forKey: @"homePhone"];
    [encoder encodeObject:faxNumber forKey: @"faxNumber"];
    [encoder encodeObject:mobilePhone forKey: @"mobilePhone"];
    [encoder encodeObject:createTime forKey: @"createTime"];
}
-(id) initWithCoder: (NSCoder *) decoder
{
    djLsh = [decoder decodeIntForKey:@"djLsh"];
    regionID = [decoder decodeIntForKey:@"regionID"];
    groupCode = [[decoder decodeObjectForKey:@"groupCode"] retain];
    techCode = [[decoder decodeObjectForKey:@"techCode"] retain];
    passWord = [[decoder decodeObjectForKey:@"passWord"] retain];
    techName = [[decoder decodeObjectForKey:@"techName"] retain];
    pYJM = [[decoder decodeObjectForKey:@"pYJM"] retain];
    techSex = [[decoder decodeObjectForKey:@"techSex"] retain];
    homeAddress = [[decoder decodeObjectForKey:@"homeAddress"] retain];
    homePhone = [[decoder decodeObjectForKey:@"homePhone"] retain];
    faxNumber = [[decoder decodeObjectForKey:@"faxNumber"] retain];
    mobilePhone = [[decoder decodeObjectForKey:@"mobilePhone"] retain];
    createTime = [[decoder decodeObjectForKey:@"createTime"] retain];

    return self;
}

#pragma mark - NSCopying
// 复制
-(id)copyWithZone:(NSZone *)zone
{
    TechInfoModel *newItem = [[TechInfoModel allocWithZone: zone] init];

    newItem.djLsh = self.djLsh;
    newItem.regionID = self.regionID;
    newItem.groupCode = self.groupCode;
    newItem.techCode = self.techCode;
    newItem.passWord = self.passWord;
    newItem.techName = self.techName;
    newItem.pYJM = self.pYJM;
    newItem.techSex = self.techSex;
    newItem.homeAddress = self.homeAddress;
    newItem.homePhone = self.homePhone;
    newItem.faxNumber = self.faxNumber;
    newItem.mobilePhone = self.mobilePhone;
    newItem.createTime = self.createTime;

	return newItem;
}

@end

