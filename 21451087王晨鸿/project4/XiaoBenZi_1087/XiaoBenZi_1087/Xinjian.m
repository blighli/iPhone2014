//
//  Xinjian.m
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-23.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Xinjian.h"
#import "Constants.h"
#import "ChakanShouxie.h"

@implementation Xinjian

-(IBAction)newWZ
{
    [Constants setWhoPastit:1];
}
-(IBAction)newZP
{
    [Constants setWhoPastit:1];
}
-(IBAction)newSX
{
    [Constants setWhoPastit:1];
    
    //从storyboard中找到界面
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle] ];
    //找到view
    ChakanShouxie *vC= [ story instantiateViewControllerWithIdentifier:@"ChakanShouxie"];
    
    //进入下一页
    [[self navigationController] pushViewController:vC animated:YES];

}

@end
