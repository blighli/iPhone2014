#import "CustomUserModel.h"

@implementation CustomUserModel

@synthesize djLsh;
@synthesize companyCode;
@synthesize regionID;
@synthesize regionName;
@synthesize customCode;
@synthesize customName;
@synthesize homeAddress;
@synthesize homePhone;
@synthesize workPhone;
@synthesize faxNumber;
@synthesize mobilePhone;
@synthesize insuranceTypeName;
@synthesize insuranceNumber;
@synthesize beginTime;
@synthesize keepTime;
@synthesize endTime;

-(void)dealloc
{
    self.companyCode = nil;
    self.regionName = nil;
    self.customCode = nil;
    self.customName = nil;
    self.homeAddress = nil;
    self.homePhone = nil;
    self.workPhone = nil;
    self.faxNumber = nil;
    self.mobilePhone = nil;
    self.insuranceTypeName = nil;
    self.insuranceNumber = nil;
    self.beginTime = nil;
    self.keepTime = nil;
    self.endTime = nil;
    [super dealloc];
}

+(CustomUserModel *)itemWithDict:(NSDictionary *)dict
{
    CustomUserModel *item = [[[CustomUserModel alloc] init] autorelease];
    item.djLsh = [[dict valueForKey:@"DjLsh"] intValue];
    item.companyCode = [dict valueForKey:@"CompanyCode"];
    item.regionID = [[dict valueForKey:@"RegionID"] intValue];
    item.regionName = [dict valueForKey:@"RegionName"];
    item.customCode = [dict valueForKey:@"CustomCode"];
    item.homeAddress = [dict valueForKey:@"HomeAddress"];
    item.homePhone = [dict valueForKey:@"HomePhone"];
    item.workPhone = [dict valueForKey:@"WorkPhone"];
    item.faxNumber = [dict valueForKey:@"FaxNumber"];
    item.mobilePhone = [dict valueForKey:@"MobilePhone"];
    item.insuranceTypeName = [dict valueForKey:@"InsuranceTypeName"];
    item.insuranceNumber = [dict valueForKey:@"InsuranceNumber"];
    item.beginTime = [dict valueForKey:@"BeginTime"];
    item.keepTime = [dict valueForKey:@"KeepTime"];
    item.endTime = [dict valueForKey:@"EndTime"];
    return item;
}

-(void)exchangeNil
{
    if(companyCode == nil) companyCode = @"";
    if(regionName == nil) regionName = @"";
    if(customCode == nil) customCode = @"";
    if(customName == nil) customName = @"";
    if(homeAddress == nil) homeAddress = @"";
    if(homePhone == nil) homePhone = @"";
    if(workPhone == nil) workPhone = @"";
    if(faxNumber == nil) faxNumber = @"";
    if(mobilePhone == nil) mobilePhone = @"";
    if(insuranceTypeName == nil) insuranceTypeName = @"";
    if(insuranceNumber == nil) insuranceNumber = @"";
    if(beginTime == nil) beginTime = @"";
    if(keepTime == nil) keepTime = @"";
    if(endTime == nil) endTime = @"";
    [super dealloc];
}
-(NSMutableString *)getJsonValue
{
    [self exchangeNil];

    NSMutableString * jsonItem = [NSMutableString string];
    [jsonItem appendFormat:@"{"];
    [jsonItem appendFormat:@"\"DjLsh\":%i,", djLsh];
    [jsonItem appendFormat:@"\"CompanyCode\":\"%@\",", companyCode];
    [jsonItem appendFormat:@"\"RegionID\":%i,", regionID];
    [jsonItem appendFormat:@"\"RegionName\":%@,", regionName];
    [jsonItem appendFormat:@"\"CustomCode\":\"%@\",", customCode];
    [jsonItem appendFormat:@"\"CustomName\":\"%@\",", customName];
    [jsonItem appendFormat:@"\"HomeAddress\":\"%@\",", homeAddress];
    [jsonItem appendFormat:@"\"HomePhone\":\"%@\",", homePhone];
    [jsonItem appendFormat:@"\"WorkPhone\":\"%@\",", workPhone];
    [jsonItem appendFormat:@"\"FaxNumber\":\"%@\",", faxNumber];
    [jsonItem appendFormat:@"\"MobilePhone\":\"%@\",", mobilePhone];
    [jsonItem appendFormat:@"\"InsuranceTypeName\":\"%@\",", insuranceTypeName];
    [jsonItem appendFormat:@"\"InsuranceNumber\":\"%@\",", insuranceNumber];
    [jsonItem appendFormat:@"\"BeginTime\":\"%@\",", beginTime];
    [jsonItem appendFormat:@"\"KeepTime\":\"%@\",", keepTime];
    [jsonItem appendFormat:@"\"EndTime\":\"%@\"", endTime];
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
    [xmlItem appendFormat:@"<CompanyCode>%@</CompanyCode>",companyCode];
    [xmlItem appendFormat:@"<RegionID>%i</RegionID>",regionID];
    [xmlItem appendFormat:@"<RegionName>%@</RegionName>",regionName];
    [xmlItem appendFormat:@"<CustomCode>%@</CustomCode>",customCode];
    [xmlItem appendFormat:@"<CustomName>%@</CustomName>",customName];
    [xmlItem appendFormat:@"<HomeAddress>%@</HomeAddress>",homeAddress];
    [xmlItem appendFormat:@"<HomePhone>%@</HomePhone>",homePhone];
    [xmlItem appendFormat:@"<WorkPhone>%@</WorkPhone>",workPhone];
    [xmlItem appendFormat:@"<FaxNumber>%@</FaxNumber>",faxNumber];
    [xmlItem appendFormat:@"<MobilePhone>%@</MobilePhone>",mobilePhone];
    [xmlItem appendFormat:@"<InsuranceTypeName>%@</InsuranceTypeName>",insuranceTypeName];
    [xmlItem appendFormat:@"<InsuranceNumber>%@</InsuranceNumber>",insuranceNumber];
    [xmlItem appendFormat:@"<BeginTime>%@</BeginTime>",beginTime];
    [xmlItem appendFormat:@"<KeepTime>%@</KeepTime>",keepTime];
    [xmlItem appendFormat:@"<EndTime>%@</EndTime>",endTime];
    [xmlItem appendFormat:@"</item>"];
    return xmlItem;
}

#pragma mark - NSCoding
-(void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeInt:djLsh forKey: @"djLsh"];
    [encoder encodeObject:companyCode forKey: @"companyCode"];
    [encoder encodeInt:regionID forKey: @"regionID"];
    [encoder encodeObject:regionName forKey: @"regionName"];
    [encoder encodeObject:customCode forKey: @"customCode"];
    [encoder encodeObject:customName forKey: @"customName"];
    [encoder encodeObject:homeAddress forKey: @"homeAddress"];
    [encoder encodeObject:homePhone forKey: @"homePhone"];
    [encoder encodeObject:workPhone forKey: @"workPhone"];
    [encoder encodeObject:faxNumber forKey: @"faxNumber"];
    [encoder encodeObject:mobilePhone forKey: @"mobilePhone"];
    [encoder encodeObject:insuranceTypeName forKey: @"insuranceTypeName"];
    [encoder encodeObject:insuranceNumber forKey: @"insuranceNumber"];
    [encoder encodeObject:beginTime forKey: @"beginTime"];
    [encoder encodeObject:keepTime forKey: @"keepTime"];
    [encoder encodeObject:endTime forKey: @"endTime"];
}
-(id) initWithCoder: (NSCoder *) decoder
{
    djLsh = [decoder decodeIntForKey:@"djLsh"];
    companyCode = [[decoder decodeObjectForKey:@"companyCode"] retain];
    regionID = [decoder decodeIntForKey:@"regionID"];
    regionName = [[decoder decodeObjectForKey:@"regionName"] retain];
    customCode = [[decoder decodeObjectForKey:@"customCode"] retain];
    customName = [[decoder decodeObjectForKey:@"customName"] retain];
    homeAddress = [[decoder decodeObjectForKey:@"homeAddress"] retain];
    homePhone = [[decoder decodeObjectForKey:@"homePhone"] retain];
    workPhone = [[decoder decodeObjectForKey:@"workPhone"] retain];
    faxNumber = [[decoder decodeObjectForKey:@"faxNumber"] retain];
    mobilePhone = [[decoder decodeObjectForKey:@"mobilePhone"] retain];
    insuranceTypeName = [[decoder decodeObjectForKey:@"insuranceTypeName"] retain];
    insuranceNumber = [[decoder decodeObjectForKey:@"insuranceNumber"] retain];
    beginTime = [[decoder decodeObjectForKey:@"beginTime"] retain];
    keepTime = [[decoder decodeObjectForKey:@"keepTime"] retain];
    endTime = [[decoder decodeObjectForKey:@"endTime"] retain];

    return self;
}

#pragma mark - NSCopying
// 复制
-(id)copyWithZone:(NSZone *)zone
{
    CustomUserModel *newItem = [[CustomUserModel allocWithZone: zone] init];

    newItem.djLsh = self.djLsh;
    newItem.companyCode = self.companyCode;
    newItem.regionID = self.regionID;
    newItem.regionName = self.regionName;
    newItem.customCode = self.customCode;
    newItem.customName = self.customName;
    newItem.homeAddress = self.homeAddress;
    newItem.homePhone = self.homePhone;
    newItem.workPhone = self.workPhone;
    newItem.faxNumber = self.faxNumber;
    newItem.mobilePhone = self.mobilePhone;
    newItem.insuranceTypeName = self.insuranceTypeName;
    newItem.insuranceNumber = self.insuranceNumber;
    newItem.beginTime = self.beginTime;
    newItem.keepTime = self.keepTime;
    newItem.endTime = self.endTime;

	return newItem;
}

@end

