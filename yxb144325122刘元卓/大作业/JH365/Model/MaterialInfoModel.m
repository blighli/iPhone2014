#import "MaterialInfoModel.h"

@implementation MaterialInfoModel

@synthesize djLsh;
@synthesize materialCode;
@synthesize materialName;
@synthesize materialSize;
@synthesize materialUnit;

-(void)dealloc
{
    self.materialCode = nil;
    self.materialName = nil;
    self.materialSize = nil;
    self.materialUnit = nil;
    [super dealloc];
}

+(MaterialInfoModel *)itemWithDict:(NSDictionary *)dict
{
    MaterialInfoModel *item = [[[MaterialInfoModel alloc] init] autorelease];
    item.djLsh = [[dict valueForKey:@"DjLsh"] intValue];
    item.materialCode = [dict valueForKey:@"MaterialCode"];
    item.materialName = [dict valueForKey:@"MaterialName"];
    item.materialSize = [dict valueForKey:@"MaterialSize"];
    item.materialUnit = [dict valueForKey:@"MaterialUnit"];
    return item;
}

-(void)exchangeNil
{
    if(materialCode == nil) materialCode = @"";
    if(materialName == nil) materialName = @"";
    if(materialSize == nil) materialSize = @"";
    if(materialUnit == nil) materialUnit = @"";
    [super dealloc];
}
-(NSMutableString *)getJsonValue
{
    [self exchangeNil];

    NSMutableString * jsonItem = [NSMutableString string];
    [jsonItem appendFormat:@"{"];
    [jsonItem appendFormat:@"\"DjLsh\":%i,", djLsh];
    [jsonItem appendFormat:@"\"MaterialCode\":\"%@\",", materialCode];
    [jsonItem appendFormat:@"\"MaterialName\":\"%@\",", materialName];
    [jsonItem appendFormat:@"\"MaterialSize\":\"%@\",", materialSize];
    [jsonItem appendFormat:@"\"MaterialUnit\":\"%@\"", materialUnit];
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
    [xmlItem appendFormat:@"<MaterialCode>%@</MaterialCode>",materialCode];
    [xmlItem appendFormat:@"<MaterialName>%@</MaterialName>",materialName];
    [xmlItem appendFormat:@"<MaterialSize>%@</MaterialSize>",materialSize];
    [xmlItem appendFormat:@"<MaterialUnit>%@</MaterialUnit>",materialUnit];
    [xmlItem appendFormat:@"</item>"];
    return xmlItem;
}

#pragma mark - NSCoding
-(void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeInt:djLsh forKey: @"djLsh"];
    [encoder encodeObject:materialCode forKey: @"materialCode"];
    [encoder encodeObject:materialName forKey: @"materialName"];
    [encoder encodeObject:materialSize forKey: @"materialSize"];
    [encoder encodeObject:materialUnit forKey: @"materialUnit"];
}
-(id) initWithCoder: (NSCoder *) decoder
{
    djLsh = [decoder decodeIntForKey:@"djLsh"];
    materialCode = [[decoder decodeObjectForKey:@"materialCode"] retain];
    materialName = [[decoder decodeObjectForKey:@"materialName"] retain];
    materialSize = [[decoder decodeObjectForKey:@"materialSize"] retain];
    materialUnit = [[decoder decodeObjectForKey:@"materialUnit"] retain];

    return self;
}

#pragma mark - NSCopying
// 复制
-(id)copyWithZone:(NSZone *)zone
{
    MaterialInfoModel *newItem = [[MaterialInfoModel allocWithZone: zone] init];

    newItem.djLsh = self.djLsh;
    newItem.materialCode = self.materialCode;
    newItem.materialName = self.materialName;
    newItem.materialSize = self.materialSize;
    newItem.materialUnit = self.materialUnit;

	return newItem;
}

@end

