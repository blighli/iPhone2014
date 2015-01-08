//
//  SetButton.m
//  FinalProject
//
//  Created by 李丛笑 on 15/1/4.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetButton.h"
#import "DBHelper.h"
#import "CourseData.h"
@interface SetButton()

@end

@implementation SetButton

-(NSArray *)getTableArray
{
    DBHelper *db = [[DBHelper alloc]init];
    CourseData *coursedata = [[CourseData alloc]init];
    [db CreateDB];
    NSArray *datas = [db QueryDB:@" " IfByClassid:NO];
    NSMutableArray *tablearray = [[NSMutableArray alloc]init];
    for (int i = 0; i<[datas count]; i++) {
        coursedata = [datas objectAtIndex:i];
        NSString *cid = coursedata.classid;
        NSArray *ids = [cid componentsSeparatedByString:@" "];
        if (![tablearray containsObject:[ids objectAtIndex:0]]) {
            [tablearray addObject:[ids objectAtIndex:0]];
        }
    }
    return tablearray;
    
}

-(int)getButtonCount:(int)tableid
{
    int count = 0;
    DBHelper *db = [[DBHelper alloc]init];
    CourseData *coursedata = [[CourseData alloc]init];
    [db CreateDB];
    NSArray *datas = [db QueryDB:@" " IfByClassid:NO];
    for (int i = 0; i<[datas count]; i++) {
        coursedata = [datas objectAtIndex:i];
        NSString *cid = coursedata.classid;
        if ([cid hasPrefix:[NSString stringWithFormat:@"%d",tableid]]) {
            if ([[cid substringFromIndex:[cid length]-1] intValue]>count) {
                count = [[cid substringFromIndex:[cid length]-1] intValue];
            }
            
        }
    }
    
    return count;
}

-(NSString *)getButtonText:(int)tableid Classid:(int)classid
{
    NSMutableArray * result = [[NSMutableArray alloc]initWithCapacity:7];
     for(int i = 0;i<7;i++)
    [result addObject:@" "];
    
    DBHelper *db = [[DBHelper alloc]init];
    CourseData *coursedata = [[CourseData alloc]init];
    [db CreateDB];
    NSArray *datas = [db QueryDB:@" " IfByClassid:NO];
    for (int i = 0; i<[datas count]; i++) {
        coursedata = [datas objectAtIndex:i];
        NSString *cid = coursedata.classid;
        int dayid = [[cid substringWithRange:NSMakeRange(2, 2)] intValue];
        if ([cid hasPrefix:[NSString stringWithFormat:@"%d",tableid]]) {
            if ( [cid hasSuffix:[NSString stringWithFormat:@"%d",classid]])
                [result replaceObjectAtIndex:dayid-1 withObject:coursedata.classname];
        }
       
    }

    return result;
}
-(NSString *)getButtonInfo:(int)tag Tableid:(int)tableid
{
    NSMutableString *result = [[NSMutableString alloc]init];
    DBHelper *db = [[DBHelper alloc]init];
    CourseData *coursedata = [[CourseData alloc]init];
    [db CreateDB];
    NSArray *datas = [db QueryDB:@" " IfByClassid:NO];
    for (int i = 0; i<[datas count]; i++) {
        coursedata = [datas objectAtIndex:i];
        NSString *classid = coursedata.classid;
        int tid = [[classid substringToIndex:1] intValue];
        int did = [[classid substringWithRange:NSMakeRange(2, 2) ]intValue];
        int cid = [[classid substringFromIndex:[classid length]-1] intValue];
        if (tid == tableid && did == tag/10 && cid == tag-did*10) {
            [result appendString:coursedata.classname];
            [result appendString:@" "];
            [result appendString:coursedata.classtime];
            return result;
        }
    }
    
    return result;
}

@end
