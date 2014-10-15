//
//  CalendarController.m
//  MyCalendar
//
//  Created by cstlab on 14-10-11.
//  Copyright (c) 2014年 CSTTan. All rights reserved.
//

#import "CalendarController.h"
#import "ShowOnScreen.h"
#import "CalendarTitle.h"

@interface CalendarController()
@property (strong, nonatomic)NSCalendar *currentCal;
@property (strong, nonatomic)NSArray * leapYear;
@property (strong, nonatomic)NSArray * commonYear;
@end

@implementation CalendarController
@synthesize currentCal = _currentCal;

/*CalendarController类的初始化，对于命令参数数组的长度1-3判断在此方法完成，对符合cal命令参数个数的字符串数组具体的处理在内部方法里面分析和处理*/
-(instancetype )initWithCommandStr:(NSArray *)commands{
    self = [super init];
    if (self) {
       if (!commands) {
           NSLog(@"Command is Empty!");
           return nil;
       }
       if ([commands count] > 3) {
           NSLog(@"Command arguments count should be less than 3");
           return nil;
       }
       if (![[commands objectAtIndex:0] isEqualToString:@"cal"]) {
           NSLog(@"Command not found!Please make sure your command begin with cal");
           return nil;
       }
       self.commandArray = commands;
    }
    return self;
}

/*处理传入命令字符串数组的方法*/
-(int)dealWithCommandStr{
    NSInteger length = [self.commandArray count];
    
    switch (length) {
        case 1: [self dealWithOneCommandStr];
            break;
        case 2: [self dealWithTwoCommandStr];
            break;
        case 3: [self dealWithThreeCommandStr];
            break;
        default:
            break;
    }
    return 0;
}

/*处理1个命令参数的方法，即cal*/
-(void)dealWithOneCommandStr{
    NSDateComponents * dateComponents = [self firstDateComonents];
    NSDateComponents *nowComp = [self targetDateComponents:dateComponents];
    
    NSUInteger year = nowComp.year;
    NSUInteger month = nowComp.month;
    NSUInteger weekDay = nowComp.weekday;
    
    int monthdays;
    BOOL isLeap = [CalendarController isLeap:year];
    if (isLeap) {
        monthdays = [[self.leapYear objectAtIndex:month-1] intValue];
        
    }else{
        monthdays = [[self.commonYear objectAtIndex:month-1] intValue];
    }
    CalendarTitle * title = [[CalendarTitle alloc] initWithMonth:month WithYear:year];
    [title showTitle];
    
    [CalendarTitle showWeekdayName];
    
    ShowOnScreen * show = [[ShowOnScreen alloc] initforweekday:weekDay formonthdays:monthdays];
    [show ShowCalendar];
}

/*处理2个命令参数的方法，如cal 2014*/
-(void)dealWithTwoCommandStr{
    NSString *secondCommand = [self.commandArray objectAtIndex:1];
    if ([CalendarController isPureInt:secondCommand]) {
        NSUInteger year = [secondCommand intValue];
        if (year<1 || year>9999) {
            NSLog(@"%@ is neither a year number(1..9999) nor a name", secondCommand);
        }else{
            for (int i = 1; i<=12; i++) {
                [self dealWithCertainCal:i withYear:year];
            }
        }
    }else{
        NSLog(@"%@ is neither a year number(1..9999) nor a name", secondCommand);
    }
    
}
/*处理3个命令参数的方法,如cal 10 2014和cal -m 10等*/
-(void)dealWithThreeCommandStr{
    NSString * secondCommand = [self.commandArray objectAtIndex:1];
    NSString * thirdCommand = [self.commandArray objectAtIndex:2];
    NSUInteger month;
    
    if ([secondCommand isEqualToString:@"-m"]) {
        if ([CalendarController isPureInt:thirdCommand]) {
            NSUInteger month = [thirdCommand intValue];
            if (month < 1 || month > 12) {
                NSLog(@"%ld is neither a month number(1..12) nor a name", month);
            }else{
                [self dealWithCurrentYearMonthCal:month];
            }
        }else{
            NSLog(@"%@ is neither a month number(1..12) nor a name", thirdCommand);
        }
        
    }else if ([CalendarController isPureInt:secondCommand]){
        month = [secondCommand intValue];
        if (month < 1 || month >12) {
            NSLog(@"%ld is neither a month number(1..12) nor a name", month);
        }else{
            if ([CalendarController isPureInt:thirdCommand]) {
                NSUInteger year = [thirdCommand intValue];
                if (year < 1 || year > 9999) {
                    NSLog(@"%ld is neither a year number(1..9999) nor a name", year);
                }else{
                    [self dealWithCertainCal:month withYear:year];
                }
            }else{
                NSLog(@"%@ is neither a year number(1..9999) nor a name", thirdCommand);
            }
            
        }
        
    }else{
       NSLog(@"illegal option %@", secondCommand);
    }
}
/*判断字符串对象是否为纯数字*/
+(BOOL)isPureInt:(NSString *) sourceStr{
    NSScanner *scan = [NSScanner scannerWithString:sourceStr];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/*处理当年某月份的日期具体实现方法，即年份由终端系统决定，月份由用户指定*/
-(void)dealWithCurrentYearMonthCal:(NSUInteger) monthSet{
    NSDateComponents * dateComponents = [self firstDateComonents];
    
    [dateComponents setMonth:monthSet];
    
    NSDateComponents *nowComp = [self targetDateComponents:dateComponents];
    
    NSUInteger year = nowComp.year;
    NSUInteger weekDay = nowComp.weekday;
    NSUInteger monthdays;
    
    BOOL isLeap = [CalendarController isLeap:year];
    if (isLeap) {
        monthdays = [[self.leapYear objectAtIndex:monthSet-1] intValue];
        
    }else{
        monthdays = [[self.commonYear objectAtIndex:monthSet-1] intValue];
    }
    CalendarTitle * title = [[CalendarTitle alloc] initWithMonth:monthSet WithYear:year];
    [title showTitle];
    [CalendarTitle showWeekdayName];
    
    ShowOnScreen * show = [[ShowOnScreen alloc] initforweekday:weekDay formonthdays:monthdays];
    [show ShowCalendar];
}

/*处理某年某月的方法，即年份和月份都由用户决定*/
-(void)dealWithCertainCal:(NSUInteger) monthSet withYear:(NSUInteger) yearSet{
    NSDateComponents * dateComponents = [self firstDateComonents];
    
    [dateComponents setYear:yearSet];
    [dateComponents setMonth:monthSet];
    
    NSDateComponents *nowComp = [self targetDateComponents:dateComponents];
    
    NSUInteger year = nowComp.year;
    NSUInteger weekDay = nowComp.weekday;
    NSUInteger monthdays;
    
    BOOL isLeap = [CalendarController isLeap:year];
    if (isLeap) {
        monthdays = [[self.leapYear objectAtIndex:monthSet-1] intValue];
        
    }else{
        monthdays = [[self.commonYear objectAtIndex:monthSet-1] intValue];
    }
    
    CalendarTitle * title = [[CalendarTitle alloc] initWithMonth:monthSet WithYear:yearSet];
    [title showTitle];
    [CalendarTitle showWeekdayName];
    
    ShowOnScreen * show = [[ShowOnScreen alloc] initforweekday:weekDay formonthdays:monthdays];
    [show ShowCalendar];
}

/*返回与设定的月历关联的初始NSDateCalendar对象，根据api需要在初始对象里面讲day属性设定为1*/
-(NSDateComponents *)firstDateComonents{
    NSDate * date = [NSDate date];
    NSDateComponents * firstComponents = [self.currentCal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    [firstComponents setDay:1];
    return firstComponents;
}

/*通过cal命令参数对初始的NSDateCalendar设定目标年份和月份，再次关联月历对象，返回最终需要的目标NSDateCalendar对象*/
-(NSDateComponents *)targetDateComponents:(NSDateComponents *)dateComponents{
    NSDate * monthBegin = [self.currentCal dateFromComponents:dateComponents];
    NSDateComponents * target = [self.currentCal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:monthBegin];
    
    return target;
}

/*判断某年是否为闰年*/
+(BOOL)isLeap:(NSUInteger) year{
    if (year%4==0) {
        if (year%100==0 && year%400==0) {
            return YES;
        }else if(year%100==0 && year%400 !=0){
            return NO;
        }else
            return YES;
    }
    return NO;
}
/*currentCal的get方法*/
-(NSCalendar *)currentCal{
    if (!_currentCal) {
        _currentCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    return _currentCal;
}
/*闰年月份天数的数组*/
-(NSArray *)leapYear{
    if (!_leapYear) {
        _leapYear = @[@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    }
    return _leapYear;
}
/*平年月份天数的数组*/
-(NSArray *)commonYear{
    if (!_commonYear) {
        _commonYear = @[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    }
    return _commonYear;
}

@end
