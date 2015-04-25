#import "TechGroupModel.h"

@implementation TechGroupModel

@synthesize djLsh;
@synthesize groupCode;
@synthesize groupName;

-(void)dealloc
{
    self.groupCode = nil;
    self.groupName = nil;
    [super dealloc];
}

+(TechGroupModel *)itemWithDict:(NSDictionary *)dict
{
    TechGroupModel *item = [[[TechGroupModel alloc] init] autorelease];
    item.djLsh = [[dict valueForKey:@"DjLsh"] intValue];
    item.groupCode = [dict valueForKey:@"GroupCode"];
    item.groupName = [dict valueForKey:@"GroupName"];
    return item;
}
-(void)exchangeNil
{
    if(groupCode == nil) groupCode = @"";
    if(groupName == nil) groupName = @"";
    [super dealloc];
}
//Json
-(NSMutableString *)getJsonValue
{
    [self exchangeNil];

    NSMutableString * jsonItem = [NSMutableString string];
    [jsonItem appendFormat:@"{"];
    [jsonItem appendFormat:@"\"DjLsh\":%i,", djLsh];
    [jsonItem appendFormat:@"\"GroupCode\":\"%@\",", groupCode];
    [jsonItem appendFormat:@"\"GroupName\":\"%@\"", groupName];
    [jsonItem appendFormat:@"}"];
    return jsonItem;
}
//xml
-(NSMutableString *)getXmlValue
{
    [self exchangeNil];

    NSMutableString *xmlItem = [NSMutableString string];
    [xmlItem appendFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"];
    [xmlItem appendFormat:@"<item>"];
    [xmlItem appendFormat:@"<DjLsh>%i</DjLsh>",djLsh];
    [xmlItem appendFormat:@"<GroupCode>%@</GroupCode>",groupCode];
    [xmlItem appendFormat:@"<GroupName>%@</GroupName>",groupName];
    [xmlItem appendFormat:@"</item>"];
    return xmlItem;
}

#pragma mark - NSCoding
//归档
-(void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeInt:djLsh forKey: @"djLsh"];
    [encoder encodeObject:groupCode forKey: @"groupCode"];
    [encoder encodeObject:groupName forKey: @"groupName"];
}
//解档
-(id) initWithCoder: (NSCoder *) decoder
{
    djLsh = [decoder decodeIntForKey:@"djLsh"];
    groupCode = [[decoder decodeObjectForKey:@"groupCode"] retain];
    groupName = [[decoder decodeObjectForKey:@"groupName"] retain];
    return self;
}

#pragma mark - NSCopying
// 复制
-(id)copyWithZone:(NSZone *)zone
{
    TechGroupModel *newItem = [[TechGroupModel allocWithZone: zone] init];

    newItem.djLsh = self.djLsh;
    newItem.groupCode = self.groupCode;
    newItem.groupName = self.groupName;

	return newItem;
}

@end

