//
//  BBWebService.m
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/5.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "BBWebService.h"
#import <AFNetworking.h>
#import "BBFileManager.h"

//服务器地址
static NSString *BASE_URL = @"http://tv.askeasy.cn/";

@implementation BBWebService

+(void)connectToServer:(responseTVListModelArray) callbackData requestFailed:(failReason) failed
{
    NSString *_url = [[NSString stringWithFormat:@"%@tvlist.json",BASE_URL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        BOOL flag = [[dic objectForKey:@"flag"] boolValue];

        
        if(flag)
        {
            NSMutableArray *listArray = [[NSMutableArray alloc]init];
            NSArray *_array = [dic objectForKey:@"list"];
            
            for(NSDictionary *modelDic in _array)
            {
                BBTVListModel *model = [[BBTVListModel alloc]init];
                [model setValuesForKeysWithDictionary:modelDic];
                [listArray addObject:model];
            }
            
            //block返回BBTVListModel数组
            callbackData([listArray copy]);
            
        }
        else
        {
            //返回失败原因
            NSString *reason = [dic valueForKey:@"reason"];
            failed(reason);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failed(@"无法连接服务器!");
        
    }];
}


+(void)downloadTVLogo:(NSArray *)tvlistArray withUpdate:(BOOL)isUpdate{
    
    for(BBTVListModel *model in tvlistArray)
    {
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",model.tvID];
        BOOL isExisted = [BBFileManager isFileExisted:fileName withPathDirectory:NSCachesDirectory];
        
        //如果不存在或强制更新，则从服务器拉去LOGO
        if(!isExisted || isUpdate)
        {
            //下载Logo图片
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.logo]];
            [BBFileManager writeDataToFile:fileName withData:data withPathDirectory:NSCachesDirectory];
        }
    }
    
}

@end
