//
//  main.m
//  calulator
//
//  Created by NimbleSong on 14/11/3.
//  Copyright (c) 2014年 宋宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "calulatorfounction.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        char chars[]="";
        
        calulator *calu=[[calulator alloc]init];
            scanf("%s",chars);
            NSString* numbers=[NSString stringWithFormat:@"%s",chars];
            numbers=[calu unperantheses:numbers];
            NSLog(@"%@",numbers);
//            numbers=[numbers substringToIndex:[numbers length]-1];
//        NSLog(@"%@",numbers);
//            NSRange remrang=[numbers rangeOfString:@"%" options:NSLiteralSearch];
//        if (remrang.length>0) {
//            NSLog(@"111111");
//        }else{
//            NSLog(@"22222");
//        }
        
        //NSString *emailRegex = @"(?!(.*\\)\\d.*))";
//            NSString *regexB=@"(^([\\*\\/\\)].*))|(.*\\)\\d.*)|(.*[\\+\\-\\*\\/\\.]{2,}.*)|(.*[\\*\\/][\\*\\/].*)|(.*\\.\\d\\..*)|(.*[\\d\\)]/0)|(.*\\([\\*\\/])|(.*[\\+\\-\\*\\/]\\).*)|(.*\\d\\(.*)|((.*[\\*\\+\\-\\/\\(])$)";
//        NSString *regexA=@"((?!.*\\)[\\+\\-\\*\\/]))";
        //NSString *regexB=@"(?!.*\\)\\d.*)";
//            NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexB];
//        NSPredicate *regexbtest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexA];
//        
//           BOOL isMatch = [emailTest evaluateWithObject:numbers];
//        BOOL isMatchA=[regexbtest evaluateWithObject:numbers];
//        if (isMatch) {
//            NSLog(@"Is Matched");
//        }else{
//            NSLog(@"Not Matched");
//        }
        
        /*NSString *replaced=[numbers stringByReplacingOccurrencesOfString:@"-" withString:@"!"];
        NSLog(@"%@",replaced);*/
//        NSRange leftperanthese=[numbers rangeOfString:@"(" options:NSBackwardsSearch];
//        NSRange rightperanthese=[numbers rangeOfString:@")"options:NSLiteralSearch range:NSMakeRange(leftperanthese.location, numbers.length-leftperanthese.location)];
//        NSString* left=[numbers substringWithRange:NSMakeRange(0, leftperanthese.location)];
//        NSString* middle=[numbers substringWithRange:NSMakeRange(leftperanthese.location+1, rightperanthese.location-leftperanthese.location-1)];
//        NSString *middle=[NSString stringWithFormat:@"%lu|%lu",leftperanthese.location+1,rightperanthese.location];
//        NSString* right=[NSString stringWithFormat:@"%lu",rightperanthese.location+1];
//        
//        NSLog(@"%@    %@   %@",left,middle,right);
        
        //printf("%s",a);
    }
    return 0;
}
