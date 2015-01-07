//
//  AlertUtilis.m
//  MyNotes
//
//  Created by 王威 on 14/11/16.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "AlertUtilis.h"


#define ADD_SUCCESSFULLY NSLocalizedStringFromTable(@"ADD_SUCCESSFULLY", @"AlertUtilis", @"add content successfully")

#define ADD_OK NSLocalizedStringFromTable(@"ADD_OK", @"AlertUtilis", @"add ok")
@implementation AlertUtilis

+ (void)alertWithTitle:(NSString *)alertTitle{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:ADD_SUCCESSFULLY delegate:nil cancelButtonTitle:ADD_OK otherButtonTitles: nil];
    [alert show];
}
@end
