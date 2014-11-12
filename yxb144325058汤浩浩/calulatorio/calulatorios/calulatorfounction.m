//
//  calulatorfounction.m
//  calulator
//
//  Created by C.C.R on 14/11/3.
//  Copyright (c) 2014年 TOM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "calulatorfounction.h"

@implementation calulator

-(id)init{
    if (self=[super init]) {
        _prenumber=0;
        _memory=0;
    }
    return self;
}

-(void) addNumber:(double) number{
    _prenumber=number;
}

-(void) memoryclear{
    _memory=0;
}

-(void) memoryaddition:(double)plusnumber{
    _memory=_memory+plusnumber;
}

-(void) memorysubtraction:(double)subnumber{
    _memory=_memory-subnumber;
}

-(NSString*) addition:(NSString*) plusnumber1 andPlusNumber: (NSString*) plusnumber2{
    if ([plusnumber1 isEqualToString:@"Wrong Enter!"]||[plusnumber2 isEqualToString:@"Wrong Enter!"]) {
        return @"Wrong Enter!";
    }
    float result=[plusnumber1 floatValue]+[plusnumber2 floatValue];
    return [NSString stringWithFormat:@"%.2f",result];
}

-(NSString*) subtaction:(NSString*) subnumber1 andSubNumber: (NSString*) subnumber2{
    if ([subnumber1 isEqualToString:@"Wrong Enter!" ]||[subnumber2 isEqualToString:@"Wrong Enter!"]) {
        return @"Wrong Enter!";
    }
        float result=[subnumber1 floatValue]+(-[subnumber2 floatValue]);
        return [NSString stringWithFormat:@"%.2f",result];
}

-(NSString*) multiplication:(NSString*) multinumber1 andMultiNumber: (NSString*) multinumber2{
    if ([multinumber1 isEqualToString:@"Wrong Enter!"]||[multinumber2 isEqualToString:@"Wrong Enter!"]) {
        return @"Wrong Enter!";
    }
    float result=[multinumber1 floatValue]*[multinumber2 floatValue];
    return [NSString stringWithFormat:@"%.2f",result];

}

-(NSString*) remainderation:(NSString *)remnumber1 andRemNumber:(NSString *)remnumber2{
    if ([remnumber1 isEqualToString:@"Wrong Enter!"]||[remnumber2 isEqualToString:@"Wrong Enter!"]) {
        return @"Wrong Enter!";
    }
    int result=[remnumber1 intValue]%[remnumber2 intValue];
    return [NSString stringWithFormat:@"%d",result];
}

-(NSString*) division:(NSString*) divnumber1 andDivNumber: (NSString*) divnumber2{
    if ([divnumber1 isEqualToString:@"Wrong Enter!"]||[divnumber2 isEqualToString:@"Wrong Enter!"]) {
        return @"Wrong Enter!";
    }
    float result=[divnumber1 floatValue]/[divnumber2 floatValue];
    return [NSString stringWithFormat:@"%.2f",result];
}

-(NSString*) analysic:(NSString*) beforeanalysic{
    NSRange addrang=[beforeanalysic rangeOfString:@"+" options:NSLiteralSearch];
    NSRange subrang=[beforeanalysic rangeOfString:@"-" options:NSLiteralSearch];
    NSRange multirang=[beforeanalysic rangeOfString:@"*" options:NSLiteralSearch];
    NSRange divrang=[beforeanalysic rangeOfString:@"/" options:NSBackwardsSearch];
    NSRange remrang=[beforeanalysic rangeOfString:@"%" options:NSBackwardsSearch];
    if (addrang.length>0) {
        
        if (subrang.length>0 && subrang.location<addrang.location) {
            NSString* left=[beforeanalysic substringWithRange:NSMakeRange(0, subrang.location)];
            NSString* right=[beforeanalysic substringFromIndex:subrang.location+1];
            right=[right stringByReplacingOccurrencesOfString:@"-" withString:@"!"];
            right=[right stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
            right=[right stringByReplacingOccurrencesOfString:@"!" withString:@"+"];
            return [self subtaction:[self analysic:left] andSubNumber:[self analysic:right]];
        }else{
            NSString* left=[beforeanalysic substringWithRange:NSMakeRange(0, addrang.location)];
            NSString* right=[beforeanalysic substringFromIndex:addrang.location+1];
            return [self addition:[self analysic:left] andPlusNumber:[self analysic:right]];
        }
        
    }else if(subrang.length>0){
        
        if (addrang.length>0 && addrang.location<subrang.location) {
            NSString* left=[beforeanalysic substringWithRange:NSMakeRange(0, addrang.location)];
            NSString* right=[beforeanalysic substringFromIndex:addrang.location+1];
            return [self addition:[self analysic:left] andPlusNumber:[self analysic:right]];
        }else{
            NSString* left=[beforeanalysic substringWithRange:NSMakeRange(0, subrang.location)];
            NSString* right=[beforeanalysic substringFromIndex:subrang.location+1];
            right=[right stringByReplacingOccurrencesOfString:@"-" withString:@"!"];
            right=[right stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
            right=[right stringByReplacingOccurrencesOfString:@"!" withString:@"+"];
            return [self subtaction:[self analysic:left] andSubNumber:[self analysic:right]];
        }
       
    }
    
    else if (multirang.length>0){
        NSString* left=[beforeanalysic substringWithRange:NSMakeRange(0, multirang.location)];
        NSString* right=[beforeanalysic substringFromIndex:multirang.location+1];
        return [self multiplication:[self analysic:left] andMultiNumber:[self analysic:right]];
        
    }else if (divrang.length>0){
        if (remrang.length>0&&remrang.location>divrang.location) {
            NSString* left=[beforeanalysic substringWithRange:NSMakeRange(0, remrang.location)];
            NSString* right=[beforeanalysic substringFromIndex:remrang.location+1];
            if ([right isEqual:@""] || [right isEqual:@"0.00"]||[right isEqual:@"0"]) {
                return @"Wrong Enter!";
            }
            return [self remainderation:[self analysic:left] andRemNumber:[self analysic:right]];

        }else{
            NSString* left=[beforeanalysic substringWithRange:NSMakeRange(0, divrang.location)];
            NSString* right=[beforeanalysic substringFromIndex:divrang.location+1];
            if ([right isEqual:@""] || [right isEqual:@"0.00"]) {
                return @"Wrong Enter!";
            }
            return [self division:[self analysic:left] andDivNumber:[self analysic:right]];
        }
        
        
    }
    else if (remrang.length>0){
        if (divrang.length>0&&divrang.location>remrang.location) {
            NSString* left=[beforeanalysic substringWithRange:NSMakeRange(0, divrang.location)];
            NSString* right=[beforeanalysic substringFromIndex:divrang.location+1];
            if ([right isEqual:@""] || [right isEqual:@"0.00"]) {
                return @"Wrong Enter!";
            }
            return [self division:[self analysic:left] andDivNumber:[self analysic:right]];
        }else{
            NSString* left=[beforeanalysic substringWithRange:NSMakeRange(0, remrang.location)];
            NSString* right=[beforeanalysic substringFromIndex:remrang.location+1];
            if ([right isEqual:@""] || [right isEqual:@"0.00"]||[right isEqual:@"0"]) {
                return @"Wrong Enter!";
            }
            return [self remainderation:[self analysic:left] andRemNumber:[self analysic:right]];
        }
        
    }
    else{
        return beforeanalysic;
    }
}
-(Boolean) checkperantheses:(NSString*) unCheckString{
    NSArray *arrayleft=[unCheckString componentsSeparatedByString:@"("];
    NSArray *arrayright=[unCheckString componentsSeparatedByString:@")"];
    if (arrayleft.count==arrayright.count) {
        NSString *regex=@"(^([\\*\\/\\)\\%].*))|(.*\\)\\d.*)|(.*[\\+\\-\\*\\/\\.\\%]{2,}.*)|(.*[\\*\\/\\%][\\*\\/\\%].*)|(.*\\.\\d\\..*)|(.*[\\d\\)]/0)|(.*\\([\\*\\/\\%])|(.*[\\+\\-\\*\\/\\%]\\).*)|(.*\\d\\(.*)|((.*[\\*\\+\\-\\/\\(\\%])$)";
        NSPredicate *calulatortest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        BOOL isMatch = [calulatortest evaluateWithObject:unCheckString];
        if (isMatch) {
            return false;
        }else{
            return true;
        }
        
    }else{
        return false;
    }
}

-(NSString*) unperantheses:(NSString*) perantheses{
    if ([self checkperantheses:perantheses]) {
        NSRange leftperanthese=[perantheses rangeOfString:@"(" options:NSBackwardsSearch];

        if (leftperanthese.length>0) {
            NSRange rightperanthese=[perantheses rangeOfString:@")"options:NSLiteralSearch range:NSMakeRange(leftperanthese.location, perantheses.length-leftperanthese.location)];
            if (rightperanthese.location<NSNotFound) {
                NSString* left=[perantheses substringWithRange:NSMakeRange(0, leftperanthese.location)];
                NSString* middle=[perantheses substringWithRange:NSMakeRange(leftperanthese.location+1, rightperanthese.location-leftperanthese.location-1)];
                NSString* right=[perantheses substringFromIndex:rightperanthese.location+1];
                
                return [self unperantheses:[NSString stringWithFormat:@"%@%@%@",left,[self unperantheses:middle],right]];
            }else{
                return @"Wrong Enter!";
            }
        }else{
            return [self analysic:perantheses];
        }
    }else{
        return @"Wrong Enter!";
    }
}


@end
