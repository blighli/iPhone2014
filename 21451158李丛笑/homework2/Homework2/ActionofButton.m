//
//  ActionofButton.m
//  Homework2
//
//  Created by 李丛笑 on 14/11/11.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionofButton.h"

@implementation ActionofButton

-(NSMutableString *)ActtoNum:(NSString *)num Text:(NSMutableString *)textstr Num:(NSMutableString *)numstr Is:(NSMutableString *)ifresult
{

    if ([textstr length]==0||[@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
        if ([ifresult isEqualToString:@"y"]) {
            [textstr setString:@""];
            [numstr setString:@""];
            [ifresult setString:@"n"];
        }
        
        if ([num isEqualToString:@"("] && ([textstr length]==0 || [@"0123456789" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)) {
            [numstr appendString:num];
            [textstr appendString:num];
            return textstr;
        }
        
        if ([num isEqualToString:@"."]) {
            if ([textstr length]==0 || [@"0123456789." rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
            {
                [numstr appendString:@"0."];
                [textstr appendString:@"0."];
                return textstr;
            }
            if ([[textstr substringFromIndex:[textstr length]-1]isEqualToString:@"."]) {
                return textstr;
            }

        }
        [numstr appendString:num];
        [textstr appendString:num];
    }
    return textstr;

}

-(NSMutableString *) ActtoSym: (NSString *)sym Text:(NSMutableString *)textstr Num:(NSMutableString *)numstr Is:(NSMutableString *)ifresult;
{
    if ([textstr length]!=0 && [[textstr substringFromIndex:[textstr length]-1] isEqualToString:@"."]) {
        [textstr appendString:@"0"];
        [numstr appendString:@"0"];
    }
    if ([sym isEqualToString:@"-"] && ([textstr length]==0 || [[textstr substringFromIndex:[textstr length]-1] isEqualToString:@"("])) {
        [textstr appendString:@"-"];
        [numstr appendString:@"0 -"];
    }
    else if ([textstr length]!=0 && [@"+-*/(m" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
        if([@"0123456789" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound)
            [numstr appendString:@" "];
        if ([sym isEqualToString:@"%"]) {
            [numstr appendString:@"/100 "];
        }
        else [numstr appendString:sym];
        if ([sym isEqualToString:@"*"])
            [textstr appendString:@"×"];
        else if([sym isEqualToString:@"/"])
            [textstr appendString:@"÷"];
        else [textstr appendString:sym];
        [ifresult setString:@"n"];
        
    }
    return textstr;

}
@end