//
//  ViewController.h
//  Notes
//
//  Created by 陈聪荣 on 14/11/17.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteBiz.h"
#import "DetailStringViewController.h"

@interface ViewController : UITableViewController <UITabBarControllerDelegate>

//保存数据列表
@property (nonatomic,strong) NSMutableDictionary* dicData;
@property (nonatomic,strong) NSMutableArray* listData;
//当前tab的listData按照时间进行分组
@property (nonatomic,strong) NSMutableDictionary* timeDicData;
@property (nonatomic,strong) NSMutableArray* timeListData;

//保存数据列表
@property (nonatomic,strong) NoteBiz* noteBiz;

@end

