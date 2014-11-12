//
//  ViewController.h
//  HomeWork_TaskList
//
//  Created by turbobhh on 11/9/14.
//  Copyright (c) 2014 org.bhh.homework. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

+(NSArray*)getTasks;
+(void)setTasks:(NSArray*)tasks;
@end

