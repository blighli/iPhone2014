//
//  Calcu.m
//  Test
//
//  Created by 李丛笑 on 14/11/5.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calcu.h"
#import "TheStack.h"
@implementation Calcu

-(NSString *)getPostfix :(NSString *)ns
{
    TheStack *ts  = [[TheStack alloc] init];
    NSMutableString *re= [NSMutableString stringWithCapacity:50];
    char s[50] ;
    char *str;
    int top = 0;
    str = [ns UTF8String];
    
    for (int i = 0; str[i]!='\0'; i++) {
        if (str[i]=='(') {
            [ts Push:s Ch:str[i] Top:top];
            top++;
        }
        
        if (str[i]==')'){
            while (s[top-1]!='(') {
                [re appendString:[NSString stringWithFormat:@"%c", [ts Pop:s Top:top]]];
                top--;
            }
            [ts Pop:s Top:top];
            top--;
            [ts Pop:s Top:top];
            top--;
        }
        else {
            
            if ((str[i]>'9' || str[i]<'0')&&(str[i]!=' ') && (str[i]!='.'))
            {
                
                if (top==0)
                {[ts Push:s Ch:str[i] Top:top];
                    top++;
                }
                else{
                    
                    while ((top>0) && ([ts PriorityCompare:str[i] Str2:s[top-1]]==3) && s[top-1]!='(')
                    {
                        [re appendString:[NSString stringWithFormat:@"%c", [ts Pop:s Top:top]]];
                        top--;
                    }
                    [ts Push:s Ch:str[i] Top:top];
                    top++;
                }
                
            }
            else{
                [re appendString:[NSString stringWithFormat:@"%c",str[i]]];
            }
            
        }        }
    while (top>0) {
        [re appendString:[NSString stringWithFormat:@"%c",[ts Pop:s Top:top]]];
        top--;
    }
    
    return re;
    
}

-(NSString *) getResult : (NSString *)str
{
    NSString * result;
    NSMutableArray *s;
    s = [NSMutableArray array];
    char *ns;
    int top=0;
    ns = [str UTF8String];
    int i = 0;
    while (ns[i]!='\0') {
        if (ns[i]<='9' && ns[i]>='0') {
            int j = 0;
            while(ns[i+j]!=' ')
            {
                j++;
            }
            NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:[str substringWithRange:NSMakeRange(i, j)]];
            [s addObjectsFromArray:@[num]];
                      top++;
            i = j+i+1;
        }
        else{
            if (ns[i]=='+') {
                s[top-2]=[s[top-2] decimalNumberByAdding:s[top-1]];
            }
            if (ns[i]=='-'){
                s[top-2]=[s[top-2] decimalNumberBySubtracting:s[top-1]];
            }
            if(ns[i]=='*'){
                s[top-2]=[s[top-2] decimalNumberByMultiplyingBy:s[top-1]];
            }
            if(ns[i]=='/'){
                if ([[NSString stringWithFormat:@"%@", s[top-1]] isEqualToString:@"0"]) {
                    return @"error";
                }
                else s[top-2]=[s[top-2] decimalNumberByDividingBy:s[top-1]];
            }
            [s removeObjectAtIndex:top-1];
            top--;
            i++;
        }
    }
    result = [NSString stringWithFormat:@"%@", s[0]];
    return result;
}

    
@end

