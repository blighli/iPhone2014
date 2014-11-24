//
//  PaintViewController.h
//  Evernote
//
//  Created by JANESTAR on 14-11-22.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Picture.h"
@interface PaintViewController : UIViewController
@property(nonatomic)NSUInteger row;
@property(nonatomic)BOOL flag;
@property(nonatomic,strong)Picture* pic;
@property(nonatomic)BOOL mark;

@end
