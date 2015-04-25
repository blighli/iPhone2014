#import "MaterialInfoDAL.h"
#import "MaterialInfoModel.h"

#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"

@implementation MaterialInfoDAL

@synthesize delegate;

#pragma mark - lifeCycle
-(id)init
{
    self = [super init];
    if(self)
    {
        request = [[WcfRequest alloc] initWithUrlPara:@"MaterialService.svc"
                                              wcfName:@"IMaterialService"];
        request.delegate = self;
    }
    return self;
}

-(MaterialInfoDAL *)initWithDelegate:(id)de
{
    self = [super init];
    if(self)
    {
        request = [[WcfRequest alloc] initWithUrlPara:@"MaterialService.svc"
                                              wcfName:@"IMaterialService"];
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

// 取列表
-(BOOL)getList
{
    // 方法名称
    NSString *funcName = @"GetList";
    // 准备参数
    NSMutableString *funcPara = [NSMutableString stringWithString:@""];
    // 远程交互
    [request cancel];
    return [request requestWithPara:funcName :funcPara];
}

// 分页取列表
-(BOOL)getListWithPageOutCount:(int)nPageSize :(int)nPageIndex :(NSString *)keyWord
{
    // 方法名称
    NSString *funcName = @"GetListWithPageOutCount";
    // 准备参数
    NSMutableString *funcPara = [NSMutableString stringWithString:@""];
    [funcPara appendString:[NSString stringWithFormat:@"<%@>%i</%@>",@"nPageSize",nPageSize,@"nPageSize"]];
    [funcPara appendString:[NSString stringWithFormat:@"<%@>%i</%@>",@"nPageIndex",nPageIndex,@"nPageIndex"]];
    [funcPara appendString:[NSString stringWithFormat:@"<%@>%@</%@>",@"keyWord",keyWord,@"keyWord"]];
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
    if([funcName isEqualToString:@"GetItem"])
    {
        [delegate getMaterialInfoItemCallBack:nil];
    }
    else if([funcName isEqualToString:@"GetList"])
    {
        [delegate getMaterialInfoListCallBack:nil];
    }
    else if([funcName isEqualToString:@"GetListWithPageOutCount"])
    {
        [delegate getMaterialInfoPageListCallBack:nil
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
            MaterialInfoModel *item = [MaterialInfoModel itemWithDict:jsonDict]; // 正常返回
            [delegate getMaterialInfoItemCallBack:item];
        }
        else
        {
            [delegate getMaterialInfoItemCallBack:nil]; // 失败回调
        }
        return;
    }

    // 获取列表
    NSString *listResult = [xmlData objectForKey:@"GetListResult"];
    if (listResult == nil)
        listResult = [xmlData objectForKey:@"GetListBack"];
    if (listResult!= nil)
    {
        if(listResult.length > 0)
        {
            //  json反序列化
            CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
            NSError *error = nil;
            NSData* data = [listResult dataUsingEncoding: NSUTF8StringEncoding];
            NSDictionary *jsonDict = [jsonDeserializer deserializeAsDictionary:data error:&error];
            if (error)
            {
                NSLog(@"%@",error);
                [error release];
            }
            // 得到数据
            NSMutableArray *list = [jsonDict valueForKey:@"List"];
            if(list != nil && [list count] > 0)
            {
                NSMutableArray *currList = [NSMutableArray array];
                for(int i=0; i<[list count]; i++)
                {
                    NSDictionary *dictItem = [list objectAtIndex:i];
                    [currList addObject:[MaterialInfoModel itemWithDict:dictItem]];
                }
                [delegate getMaterialInfoListCallBack:currList]; // 正常回调
            }
            else
            {
                [delegate getMaterialInfoListCallBack:nil]; // 为空回调
            }
        }
        else
        {
            [delegate getMaterialInfoListCallBack:nil]; // 失败回调
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
                    [currList addObject:[MaterialInfoModel itemWithDict:dictItem]];
                }
                // 正常回调
                [delegate getMaterialInfoPageListCallBack:currList
                                                andRecordCount:recordCount
                                                  andPageCount:pageCount
                                                   andPageSize:pageSize
                                                  andPageIndex:pageIndex];
            }
            else
            {
                // 为空回调
                [delegate getMaterialInfoPageListCallBack:nil
                                        andRecordCount:0
                                          andPageCount:0
                                           andPageSize:0
                                          andPageIndex:0];
            }
        }
        else
        {
            // 失败回调
            [delegate getMaterialInfoPageListCallBack:nil
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

