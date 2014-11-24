//
//  AlertUtilis.m
//  MyNotes
//
//  Created by tanglie on 14/11/23.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "AlertUtilis.h"

@implementation AlertUtilis

+ (void)alertWithTitle:(NSString *)alertTitle{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:@"添加成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
@end
