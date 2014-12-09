#import "CustomCompanyModel.h"

@implementation CustomCompanyModel

@synthesize djLsh;
@synthesize companyCode;
@synthesize companyName;
@synthesize peopleCount;
@synthesize beginTime;
@synthesize keepTime;
@synthesize endTime;
@synthesize insuranceTypeCode;
@synthesize insuranceNumber;
@synthesize contactName;
@synthesize address;
@synthesize phoneNum;
@synthesize email;
@synthesize dutyServer;
@synthesize createUserID;
@synthesize createTime;
@synthesize ifPerson;

-(void)dealloc
{
    self.companyCode = nil;
    self.companyName = nil;
    self.beginTime = nil;
    self.keepTime = nil;
    self.endTime = nil;
    self.insuranceTypeCode = nil;
    self.insuranceNumber = nil;
    self.contactName = nil;
    self.address = nil;
    self.phoneNum = nil;
    self.email = nil;
    self.dutyServer = nil;
    self.createTime = nil;
    [super dealloc];
}

+(CustomCompanyModel *)itemWithDict:(NSDictionary *)dict
{
    CustomCompanyModel *item = [[[CustomCompanyModel alloc] init] autorelease];
    item.djLsh = [[dict valueForKey:@"DjLsh"] intValue];
    item.companyCode = [dict valueForKey:@"CompanyCode"];
    item.companyName = [dict valueForKey:@"CompanyName"];
    item.peopleCount = [[dict valueForKey:@"PeopleCount"] intValue];
    item.beginTime = [dict valueForKey:@"BeginTime"];
    item.keepTime = [dict valueForKey:@"KeepTime"];
    item.endTime = [dict valueForKey:@"EndTime"];
    item.insuranceTypeCode = [dict valueForKey:@"InsuranceTypeCode"];
    item.insuranceNumber = [dict valueForKey:@"InsuranceNumber"];
    item.contactName = [dict valueForKey:@"ContactName"];
    item.address = [dict valueForKey:@"Address"];
    item.phoneNum = [dict valueForKey:@"PhoneNum"];
    item.email = [dict valueForKey:@"Email"];
    item.dutyServer = [dict valueForKey:@"DutyServer"];
    item.createUserID = [[dict valueForKey:@"CreateUserID"] intValue];
    item.createTime = [dict valueForKey:@"CreateTime"];
    item.ifPerson = [[[dict valueForKey:@"IfPerson"] lowercaseString] boolValue];
    return item;
}

-(void)exchangeNil
{
    if(companyCode == nil) companyCode = @"";
    if(companyName == nil) companyName = @"";
    if(beginTime == nil) beginTime = @"";
    if(keepTime == nil) keepTime = @"";
    if(endTime == nil) endTime = @"";
    if(insuranceTypeCode == nil) insuranceTypeCode = @"";
    if(insuranceNumber == nil) insuranceNumber = @"";
    if(contactName == nil) contactName = @"";
    if(address == nil) address = @"";
    if(phoneNum == nil) phoneNum = @"";
    if(email == nil) email = @"";
    if(dutyServer == nil) dutyServer = @"";
    if(createTime == nil) createTime = @"";
    [super dealloc];
}
-(NSMutableString *)getJsonValue
{
    [self exchangeNil];

    NSMutableString * jsonItem = [NSMutableString string];
    [jsonItem appendFormat:@"{"];
    [jsonItem appendFormat:@"\"DjLsh\":%i,", djLsh];
    [jsonItem appendFormat:@"\"CompanyCode\":\"%@\",", companyCode];
    [jsonItem appendFormat:@"\"CompanyName\":\"%@\",", companyName];
    [jsonItem appendFormat:@"\"PeopleCount\":%i,", peopleCount];
    [jsonItem appendFormat:@"\"BeginTime\":\"%@\",", beginTime];
    [jsonItem appendFormat:@"\"KeepTime\":\"%@\",", keepTime];
    [jsonItem appendFormat:@"\"EndTime\":\"%@\",", endTime];
    [jsonItem appendFormat:@"\"InsuranceTypeCode\":\"%@\",", insuranceTypeCode];
    [jsonItem appendFormat:@"\"InsuranceNumber\":\"%@\",", insuranceNumber];
    [jsonItem appendFormat:@"\"ContactName\":\"%@\",", contactName];
    [jsonItem appendFormat:@"\"Address\":\"%@\",", address];
    [jsonItem appendFormat:@"\"PhoneNum\":\"%@\",", phoneNum];
    [jsonItem appendFormat:@"\"Email\":\"%@\",", email];
    [jsonItem appendFormat:@"\"DutyServer\":\"%@\",", dutyServer];
    [jsonItem appendFormat:@"\"CreateUserID\":%i,", createUserID];
    [jsonItem appendFormat:@"\"CreateTime\":\"%@\",", createTime];
    [jsonItem appendFormat:@"\"IfPerson\":%i", ifPerson];
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
    [xmlItem appendFormat:@"<CompanyName>%@</CompanyName>",companyName];
    [xmlItem appendFormat:@"<PeopleCount>%i</PeopleCount>",peopleCount];
    [xmlItem appendFormat:@"<BeginTime>%@</BeginTime>",beginTime];
    [xmlItem appendFormat:@"<KeepTime>%@</KeepTime>",keepTime];
    [xmlItem appendFormat:@"<EndTime>%@</EndTime>",endTime];
    [xmlItem appendFormat:@"<InsuranceTypeCode>%@</InsuranceTypeCode>",insuranceTypeCode];
    [xmlItem appendFormat:@"<InsuranceNumber>%@</InsuranceNumber>",insuranceNumber];
    [xmlItem appendFormat:@"<ContactName>%@</ContactName>",contactName];
    [xmlItem appendFormat:@"<Address>%@</Address>",address];
    [xmlItem appendFormat:@"<PhoneNum>%@</PhoneNum>",phoneNum];
    [xmlItem appendFormat:@"<Email>%@</Email>",email];
    [xmlItem appendFormat:@"<DutyServer>%@</DutyServer>",dutyServer];
    [xmlItem appendFormat:@"<CreateUserID>%i</CreateUserID>",createUserID];
    [xmlItem appendFormat:@"<CreateTime>%@</CreateTime>",createTime];
    [xmlItem appendFormat:@"<IfPerson>%i</IfPerson>",ifPerson];
    [xmlItem appendFormat:@"</item>"];
    return xmlItem;
}

#pragma mark - NSCoding
-(void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeInt:djLsh forKey: @"djLsh"];
    [encoder encodeObject:companyCode forKey: @"companyCode"];
    [encoder encodeObject:companyName forKey: @"companyName"];
    [encoder encodeInt:peopleCount forKey: @"peopleCount"];
    [encoder encodeObject:beginTime forKey: @"beginTime"];
    [encoder encodeObject:keepTime forKey: @"keepTime"];
    [encoder encodeObject:endTime forKey: @"endTime"];
    [encoder encodeObject:insuranceTypeCode forKey: @"insuranceTypeCode"];
    [encoder encodeObject:insuranceNumber forKey: @"insuranceNumber"];
    [encoder encodeObject:contactName forKey: @"contactName"];
    [encoder encodeObject:address forKey: @"address"];
    [encoder encodeObject:phoneNum forKey: @"phoneNum"];
    [encoder encodeObject:email forKey: @"email"];
    [encoder encodeObject:dutyServer forKey: @"dutyServer"];
    [encoder encodeInt:createUserID forKey: @"createUserID"];
    [encoder encodeObject:createTime forKey: @"createTime"];
    [encoder encodeBool:ifPerson forKey: @"ifPerson"];
}
-(id) initWithCoder: (NSCoder *) decoder
{
    djLsh = [decoder decodeIntForKey:@"djLsh"];
    companyCode = [[decoder decodeObjectForKey:@"companyCode"] retain];
    companyName = [[decoder decodeObjectForKey:@"companyName"] retain];
    peopleCount = [decoder decodeIntForKey:@"peopleCount"];
    beginTime = [[decoder decodeObjectForKey:@"beginTime"] retain];
    keepTime = [[decoder decodeObjectForKey:@"keepTime"] retain];
    endTime = [[decoder decodeObjectForKey:@"endTime"] retain];
    insuranceTypeCode = [[decoder decodeObjectForKey:@"insuranceTypeCode"] retain];
    insuranceNumber = [[decoder decodeObjectForKey:@"insuranceNumber"] retain];
    contactName = [[decoder decodeObjectForKey:@"contactName"] retain];
    address = [[decoder decodeObjectForKey:@"address"] retain];
    phoneNum = [[decoder decodeObjectForKey:@"phoneNum"] retain];
    email = [[decoder decodeObjectForKey:@"email"] retain];
    dutyServer = [[decoder decodeObjectForKey:@"dutyServer"] retain];
    createUserID = [decoder decodeIntForKey:@"createUserID"];
    createTime = [[decoder decodeObjectForKey:@"createTime"] retain];
    ifPerson = [decoder decodeBoolForKey:@"ifPerson"];

    return self;
}

#pragma mark - NSCopying
// 复制
-(id)copyWithZone:(NSZone *)zone
{
    CustomCompanyModel *newItem = [[CustomCompanyModel allocWithZone: zone] init];

    newItem.djLsh = self.djLsh;
    newItem.companyCode = self.companyCode;
    newItem.companyName = self.companyName;
    newItem.peopleCount = self.peopleCount;
    newItem.beginTime = self.beginTime;
    newItem.keepTime = self.keepTime;
    newItem.endTime = self.endTime;
    newItem.insuranceTypeCode = self.insuranceTypeCode;
    newItem.insuranceNumber = self.insuranceNumber;
    newItem.contactName = self.contactName;
    newItem.address = self.address;
    newItem.phoneNum = self.phoneNum;
    newItem.email = self.email;
    newItem.dutyServer = self.dutyServer;
    newItem.createUserID = self.createUserID;
    newItem.createTime = self.createTime;
    newItem.ifPerson = self.ifPerson;

	return newItem;
}

@end

