//
//  NewsViewController.h
//  weiBo
//
//  Created by lixu on 15/1/7.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *talbleView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigation;

@end
