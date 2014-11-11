//
//  ListItem.h
//  listdemo
//
//  Created by rth on 14/11/9.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListItem : NSObject

@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)BOOL checked;

-(void)toggleChecked;

@end
