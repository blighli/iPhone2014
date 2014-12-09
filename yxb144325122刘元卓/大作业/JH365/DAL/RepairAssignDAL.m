#import "RepairAssignDAL.h"
#import "RepairAssignModel.h"

#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"

@implementation RepairAssignDAL

@synthesize delegate;

#pragma mark - lifeCycle
-(id)init
{
    self = [super init];
    if(self)
    {
        request = [[WcfRequest alloc] initWithUrlPara:@"RepairAssignService.svc"
                                              wcfName:@"IRepairAssignService"];
        request.delegate = self;
    }
    return self;
}

-(RepairAssignDAL *)initWithDelegate:(id)de
{
    self = [super init];
    if(self)
    {
        request = [[WcfRequest alloc] initWithUrlPara:@"RepairAssignService.svc"
                                              wcfName:@"IRepairAssignService"];
        request.delegate = self;
        delegate = de;
    }
    return self;
}
-(void)dealloc
{
    request.delegate = nil;
    [request cancel];
    [request release],request = nil;
    [super dealloc];
}

// 更新
-(BOOL)updateItem:(RepairAssignModel *)item
{
    // 方法名称
    NSString *funcName = @"UpdateItem";
    // 准备参数
    NSMutableString *funcPara = [NSMutableString stringWithString:@""];
    [funcPara appendString:[NSString stringWithFormat:@"<%@>",@"jsonItem"]];
    [funcPara appendString:[item getJsonValue]];
    [funcPara appendString:[NSString stringWithFormat:@"</%@>",@"jsonItem"]];
    // 远程交互
    [request cancel];
    return [request requestWithPara:funcName :funcPara];
}

// 根据djlsh取单条
-(BOOL)getItem:(int)djLsh
{
    // 方法名称
    NSString *funcName = @"GetItem";
    // 准备参数
    NSMutableString *funcPara = [NSMutableString stringWithString:@""];
    [funcPara appendString:[NSString stringWithFormat:@"<%@>%i</%@>",@"djLsh",djLsh,@"djLsh"]];
    // 远程交互
    [request cancel];
    return [request requestWithPara:funcName :funcPara];
}

// 分页取列表
-(BOOL)getListWithPageOutCount:(int)nPageSize
                              :(int)nPageIndex
                              :(NSString *)techCode
                              :(int)doneState
{
    // 方法名称
    NSString *funcName = @"GetListWithPageOutCount";
    // 准备参数
    NSMutableString *funcPara = [NSMutableString stringWithString:@""];
    [funcPara appendString:[NSString stringWithFormat:@"<%@>%i</%@>",@"nPageSize",nPageSize,@"nPageSize"]];
    [funcPara appendString:[NSString stringWithFormat:@"<%@>%i</%@>",@"nPageIndex",nPageIndex,@"nPageIndex"]];
    [funcPara appendString:[NSString stringWithFormat:@"<%@>%@</%@>",@"techCode",techCode,@"techCode"]];
    [funcPara appendString:[NSString stringWithFormat:@"<%@>%i</%@>",@"doneState",doneState,@"doneState"]];
    // 远程交互
    [request cancel];
    return [request requestWithPara:funcName :funcPara];
}

#pragma mark - WcfRequestDelegate
// 成功返回
-(void)requestCallBack:(NSMutableData *)webData
{
    if(IfDebugDAL)
        NSLog(@"%@",[[[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding] autorelease]);

    [webData retain];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:webData];
    [parser setDelegate:self];
    [parser parse];
    [parser release], parser= nil;
    [webData release];
}
// 失败返回
-(void)requestErrorCallBack:(NSString *)funcName
{
    if([funcName isEqualToString:@"UpdateItem"])
    {
        [delegate updateRepairAssignCallBack:false];
    }
    else if([funcName isEqualToString:@"GetItem"])
    {
        [delegate getRepairAssignItemCallBack:nil];
    }
    else if([funcName isEqualToString:@"GetListWithPageOutCount"])
    {
        [delegate getRepairAssignPageListCallBack:nil
                                   andRecordCount:0
                                     andPageCount:0
                                      andPageSize:0
                                     andPageIndex:0];
    }
}

#pragma mark - NSXMLParserDelegate
// 开始遍例xml的节点
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    [xmlData release], xmlData = nil;
    xmlData = [[NSMutableDictionary alloc] init];
}
// 纪录元素开始标签，并出始化临时数组，
// 遍例xml的节点,发现元素开始符的处理函数（即报告元素的开始以及元素的属性）
// 获得节点头的值
-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;
    [currentData release],currentData = nil; // 不能释放
    currentData = [[NSMutableString alloc] init];
}
// 提取XML标签中的元素，反复取多次，
// 当xml节点有值时,则进入此句,处理标签包含内容字符 （报告元素的所有或部分内容）
// 节点之间的内容
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentData appendString:string]; // 续读数据
}
// 纪录元素结尾标签，并把临时数组中的元素存到字符串数组中，
// 当遇到结束标记时，进入此句, 发现元素结束符的处理函数，保存元素各项目数据（即报告元素的结束标记）
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // 对象添加到字典里，它的引用次数并没有发生变化
    [xmlData setObject:currentData forKey:currentElement];
    //[currentElement release];
    //[currentData release];
}

// 结束分析，调用显示函数,报告解析的结束
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    // 更新数据
    NSString *updateResult = [xmlData objectForKey:@"UpdateItemResult"];
    if (updateResult == nil)
        updateResult = [xmlData objectForKey:@"UpdateItemBack"];
    if (updateResult != nil)
    {
        if(updateResult.length > 0)
        {
            [delegate updateRepairAssignCallBack:[[updateResult lowercaseString] boolValue]]; // 正常返回
        }
        else
        {
            [delegate updateRepairAssignCallBack:FALSE]; // 失败回调
        }
        return;
    }

    // 取单条
    NSString *itemResult = [xmlData objectForKey:@"GetItemResult"];
    if (itemResult == nil)
        itemResult = [xmlData objectForKey:@"GetItemBack"];
    if (itemResult!= nil)
    {
        if(itemResult.length > 0)
        {
            //  json反序列化
            CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
            NSError *error = nil;
            NSData* data = [itemResult dataUsingEncoding: NSUTF8StringEncoding];
            NSDictionary *jsonDict = [jsonDeserializer deserializeAsDictionary:data error:&error];
            if (error)
            {
                NSLog(@"%@",error);
                [error release];
            }
            // 得到数据
            RepairAssignModel *item = [RepairAssignModel itemWithDict:jsonDict]; // 正常返回
            [delegate getRepairAssignItemCallBack:item];
        }
        else
        {
            [delegate getRepairAssignItemCallBack:nil]; // 失败回调
        }
        return;
    }

    // 分页读取列表
    NSString *pageListResult = [xmlData objectForKey:@"GetListWithPageOutCountResult"];
    if (pageListResult == nil)
        pageListResult = [xmlData objectForKey:@"GetListWithPageOutCountBack"];
    if (pageListResult != nil)
    {
        if(pageListResult.length > 0)
        {
            // json反序列化
            CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
            NSError *error = nil;
            NSData* data = [pageListResult dataUsingEncoding: NSUTF8StringEncoding];
            NSDictionary *jsonDict = [jsonDeserializer deserializeAsDictionary:data error:&error];
            if (error) {
                NSLog(@"%@",error);
                [error release];
            }
            // 得到数据
            int recordCount = [[jsonDict valueForKey:@"RecordCount"] intValue];
            int pageCount = [[jsonDict valueForKey:@"PageCount"] intValue];
            int pageSize = [[jsonDict valueForKey:@"PageSize"] intValue];
            int pageIndex = [[jsonDict valueForKey:@"PageIndex"] intValue];
            NSMutableArray *list = [jsonDict valueForKey:@"List"];
            if(list != nil && [list count] > 0)
            {
                NSMutableArray *currList = [NSMutableArray array];
                for(int i=0; i<[list count]; i++)
                {
                    NSDictionary *dictItem = [list objectAtIndex:i];
                    [currList addObject:[RepairAssignModel itemWithDict:dictItem]];
                }
                // 正常回调
                [delegate getRepairAssignPageListCallBack:currList
                                                andRecordCount:recordCount
                                                  andPageCount:pageCount
                                                   andPageSize:pageSize
                                                  andPageIndex:pageIndex];
            }
            else
            {
                // 为空回调
                [delegate getRepairAssignPageListCallBack:nil
                                        andRecordCount:0
                                          andPageCount:0
                                           andPageSize:0
                                          andPageIndex:0];
            }
        }
        else
        {
            // 失败回调
            [delegate getRepairAssignPageListCallBack:nil
                                        andRecordCount:0
                                          andPageCount:0
                                           andPageSize:0
                                          andPageIndex:0];
        }
        return;
    }
}
// 报告不可恢复的解析错误
-(void)paser:parserErrorOccured{}

@end

