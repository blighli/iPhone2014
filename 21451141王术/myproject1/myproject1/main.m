//
//  main.m
//  myproject1
//
//  Created by  ws on 14-10-1.
//  Copyright (c) 2014年  ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mycal.h"
//去除NSLog时间戳
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc==1){//cal 输出当月月历
            //获得当前日期
            NSDate *date = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *comps;
            //本年
            comps = [calendar components:(NSYearCalendarUnit) fromDate:date];
            NSInteger year = [comps year];
            //本月
            comps = [calendar components:(NSMonthCalendarUnit) fromDate:date];
            NSInteger month = [comps month];
            //本月第一天是星期几
            mycal *cal=[[mycal alloc] init];
            [cal firstWeekDay:month theYear:year];
            //该月共多少天
            [cal theMaxDay:month theYear:year];
            //输出日历
            [cal print];
            
        }
        else if(argc==3){//“cal 月 年“与”cal -m 月“的处理
            NSString *a=[[NSString alloc] initWithCString:(const char*)argv[2] encoding:NSASCIIStringEncoding];
            NSString *b=[[NSString alloc] initWithCString:(const char*)argv[1] encoding:NSASCIIStringEncoding];
            NSInteger year=[a integerValue];
            NSInteger month=[b integerValue];
            //年份异常处理
            if (year<=0||year>9999) {
                NSLog(@"mycal: year %ld not in range 1..9999",year);
                return 0;
            }
            //月异常处理
            if (month<0||month>12) {
                NSLog(@"mycal: %ld is neither a month number (1..12) nor a name",month);
                return 0;
            }
            //cal -m 的处理
            if (month==0) {
                NSString *c=@"-m";
                if([b isEqualToString:c]){
                    month=year;
                    year=2014;
                }
                else{
                    NSLog(@"mycal: %ld is neither a month number (1..12) nor a name",month);
                    return 0;
                }
            }
            //本月第一天是星期几
            mycal *cal=[[mycal alloc] init];
            [cal firstWeekDay:month theYear:year];
            //该月共多少天
            [cal theMaxDay:month theYear:year];
            //输出日历
            [cal print];
            
        }
        else if(argc==2){
            NSString *aa=[[NSString alloc] initWithCString:(const char*)argv[1] encoding:NSASCIIStringEncoding];
            NSInteger year=[aa integerValue];
            if (year<=0||year>9999) {
                NSLog(@"mycal: year %ld not in range 1..9999",year);
                return 0;
            }
            mycal *cal=[[mycal alloc] init];
            //首先输入该年份
            //输出整年的月历
            NSLog(@"                              %li",(long)year);
            NSLog(@"");
            NSLog(@"        一月                  二月                 三月");
            NSLog(@"日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六");
            NSMutableString *a=[NSMutableString stringWithCapacity:0];
            NSMutableString *b=[NSMutableString stringWithCapacity:0];
            NSMutableString *c=[NSMutableString stringWithCapacity:0];
            NSMutableString *d=[NSMutableString stringWithCapacity:0];
            NSMutableString *e=[NSMutableString stringWithCapacity:0];
            NSMutableString *f=[NSMutableString stringWithCapacity:0];
            NSMutableArray *days=[[NSMutableArray alloc] initWithObjects:a,b,c,d,e,f,nil];
            int hang;
            for(int i=1;i<=3;i++){
                NSInteger firstWeekDay=[cal firstWeekDay:i theYear:year];
                //该月共多少天
                NSInteger theMaxDay=[cal theMaxDay:i theYear:year];
                for(int j=1;j<firstWeekDay;j++){
                    [a appendFormat:@"   "];
                }
                NSInteger k=firstWeekDay-1;
                //记录行
                hang=1;
                for(int j=1;j<=theMaxDay;j++){
                    NSMutableString *thedays=[days objectAtIndex:hang-1];
                    [thedays appendFormat:@"%2i ",j];
                    [days replaceObjectAtIndex:hang-1 withObject:thedays];
                    k++;
                    if(j==theMaxDay&&k!=7){
                        for(int l=k+1;l<=7;l++){
                            [thedays appendFormat:@"   "];
                        }
                        [thedays appendFormat:@" "];
                        [days replaceObjectAtIndex:hang-1 withObject:thedays];
                        
                    }

                    if(k==7){
                        [thedays appendFormat:@" "];
                        [days replaceObjectAtIndex:hang-1 withObject:thedays];
                        hang++;
                        k=0;
                    }
                    
                    
                }
                if (hang==5) {
                    NSMutableString *thedays=[days objectAtIndex:5];
                    [thedays appendFormat:@"                      "];
                    [days replaceObjectAtIndex:5 withObject:thedays];
                }
            }
            for(int i=1;i<=hang;i++){
                NSString *dd=[days objectAtIndex:i-1];
            NSLog(@"%@",dd);
            }
            [a setString:@""];
            [b setString:@""];
            [c setString:@""];
            [d setString:@""];
            [e setString:@""];
            [f setString:@""];
            days=[[NSMutableArray alloc] initWithObjects:a,b,c,d,e,f,nil];
            
            NSLog(@"        四月                  五月                 六月");
            NSLog(@"日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六");
            for(int i=4;i<=6;i++){
                NSInteger firstWeekDay=[cal firstWeekDay:i theYear:year];
                //该月共多少天
                NSInteger theMaxDay=[cal theMaxDay:i theYear:year];
                for(int j=1;j<firstWeekDay;j++){
                    [a appendFormat:@"   "];
                }
                NSInteger k=firstWeekDay-1;
                //记录行
                hang=1;
                for(int j=1;j<=theMaxDay;j++){
                    NSMutableString *thedays=[days objectAtIndex:hang-1];
                    [thedays appendFormat:@"%2i ",j];
                    [days replaceObjectAtIndex:hang-1 withObject:thedays];
                    k++;
                    if(j==theMaxDay&&k!=7){
                        for(int l=k+1;l<=7;l++){
                            [thedays appendFormat:@"   "];
                        }
                        [thedays appendFormat:@" "];
                        [days replaceObjectAtIndex:hang-1 withObject:thedays];
                        
                    }

                    if(k==7){
                        [thedays appendFormat:@" "];
                        [days replaceObjectAtIndex:hang-1 withObject:thedays];
                        hang++;
                        k=0;
                    }
                    
                    
                }
                if (hang==5) {
                    NSMutableString *thedays=[days objectAtIndex:5];
                    [thedays appendFormat:@"                      "];
                    [days replaceObjectAtIndex:5 withObject:thedays];
                }
            }
            for(int i=1;i<=6;i++){
                NSString *dd=[days objectAtIndex:i-1];
                NSLog(@"%@",dd);
            }
            [a setString:@""];
            [b setString:@""];
            [c setString:@""];
            [d setString:@""];
            [e setString:@""];
            [f setString:@""];
            days=[[NSMutableArray alloc] initWithObjects:a,b,c,d,e,f,nil];
            
            NSLog(@"        七月                  八月                 九月");
            NSLog(@"日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六");
            for(int i=7;i<=9;i++){
                NSInteger firstWeekDay=[cal firstWeekDay:i theYear:year];
                //该月共多少天
                NSInteger theMaxDay=[cal theMaxDay:i theYear:year];
                for(int j=1;j<firstWeekDay;j++){
                    [a appendFormat:@"   "];
                }
                NSInteger k=firstWeekDay-1;
                //记录行
                hang=1;
                for(int j=1;j<=theMaxDay;j++){
                    NSMutableString *thedays=[days objectAtIndex:hang-1];
                    [thedays appendFormat:@"%2i ",j];
                    [days replaceObjectAtIndex:hang-1 withObject:thedays];
                    k++;
                    if(j==theMaxDay&&k!=7){
                        for(int l=k+1;l<=7;l++){
                            [thedays appendFormat:@"   "];
                        }
                        [thedays appendFormat:@" "];
                        [days replaceObjectAtIndex:hang-1 withObject:thedays];
                        
                    }

                    if(k==7){
                        [thedays appendFormat:@" "];
                        [days replaceObjectAtIndex:hang-1 withObject:thedays];
                        hang++;
                        k=0;
                    }
                    
                    
                }
                if (hang==5) {
                    NSMutableString *thedays=[days objectAtIndex:5];
                    [thedays appendFormat:@"                      "];
                    [days replaceObjectAtIndex:5 withObject:thedays];
                }
            }
            for(int i=1;i<=6;i++){
                NSString *dd=[days objectAtIndex:i-1];
                NSLog(@"%@",dd);
            }
            [a setString:@""];
            [b setString:@""];
            [c setString:@""];
            [d setString:@""];
            [e setString:@""];
            [f setString:@""];
            days=[[NSMutableArray alloc] initWithObjects:a,b,c,d,e,f,nil];
            
            NSLog(@"        十月                 十一月                十二月");
            NSLog(@"日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六");
            
            for(int i=10;i<=12;i++){
                NSInteger firstWeekDay=[cal firstWeekDay:i theYear:year];
                //该月共多少天
                NSInteger theMaxDay=[cal theMaxDay:i theYear:year];
                for(int j=1;j<firstWeekDay;j++){
                    [a appendFormat:@"   "];
                }
                NSInteger k=firstWeekDay-1;
                //记录行
                hang=1;
                for(int j=1;j<=theMaxDay;j++){
                    NSMutableString *thedays=[days objectAtIndex:hang-1];
                    [thedays appendFormat:@"%2i ",j];
                    [days replaceObjectAtIndex:hang-1 withObject:thedays];
                    k++;
                    if(j==theMaxDay&&k!=7){
                        for(int l=k+1;l<=7;l++){
                            [thedays appendFormat:@"   "];
                        }
                        [thedays appendFormat:@" "];
                        [days replaceObjectAtIndex:hang-1 withObject:thedays];
                        
                    }

                    if(k==7){
                        [thedays appendFormat:@" "];
                        [days replaceObjectAtIndex:hang-1 withObject:thedays];
                        hang++;
                        k=0;
                    }
                    
                    
                }
                if (hang==5) {
                    NSMutableString *thedays=[days objectAtIndex:5];
                    [thedays appendFormat:@"                      "];
                    [days replaceObjectAtIndex:5 withObject:thedays];
                }
            }
            for(int i=1;i<=6;i++){
                NSString *dd=[days objectAtIndex:i-1];
                NSLog(@"%@",dd);
            }
        }
        else{
            NSLog(@"usage: cal [[month] year] cal [-m month] [year]");
        }
    }
    
    return 0;
}
