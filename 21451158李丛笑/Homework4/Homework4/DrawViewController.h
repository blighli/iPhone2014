//
//  DrawViewController.h
//  Homework4
//
//  Created by 李丛笑 on 14/12/22.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"

@interface DrawViewController : UIViewController
{
    int colorcount;
    int widthcount;
}

- (IBAction)Color:(id)sender;
- (IBAction)Width:(id)sender;
- (IBAction)Clear:(id)sender;
- (IBAction)Save:(id)sender;



@end
