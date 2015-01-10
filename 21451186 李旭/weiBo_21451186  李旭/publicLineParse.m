//
//  publicLineParse.m
//  weiBo
//
//  Created by lixu on 15/1/3.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import "publicLineParse.h"
#import "PublicLIneModel.h"
@implementation publicLineParse

+(id) publicLineFromData:(NSData *)data{
    if (data) {
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array=[[NSArray alloc] init];
        array=[dictionary objectForKey:@"statuses"];
        NSMutableArray *mutableArray=[[NSMutableArray alloc] init];
        for (NSDictionary *dic in array) {
            PublicLIneModel *model=[[PublicLIneModel alloc] init];
            model.created_at=[dic objectForKey:@"created_at"];
            model.idstr=[dic objectForKey:@"idstr"];
            model.source=[dic objectForKey:@"source"];
            model.text=[dic objectForKey:@"text"];
            model.thumbnall_pic=[dic objectForKey:@"thumbnall_pic"];
            model.bmiddle_pic=[dic objectForKey:@"bmiddle_pic"];
            model.original_pic=[dic objectForKey:@"original_pic"];
            model.userModel.name=[[dic objectForKey:@"user"] objectForKey:@"screen_name"];
            model.userModel.location=[[dic objectForKey:@"user"] objectForKey:@"location"];
            model.userModel.udescription=[[dic objectForKey: @"user"] objectForKey:@"description"];
            model.userModel.profile_image_url=[[dic objectForKey:@"user"] objectForKey:@"profile_image_url"];
            model.userModel.gender=[[dic objectForKey:@"user"] objectForKey:@"gender"];
            [mutableArray addObject:model];
        }
        //    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        //
        //
        //    }];//或者用block在遍历的时候进行操作。
        array=[NSArray arrayWithArray:mutableArray];
        return array;
    }else{
        NSLog(@"data is null");
        return nil;
    }
}

@end

