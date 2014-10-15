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
@property (strong, nonatomic)NSCalendar *currentCal;;
@property (strong, nonatomic)NSArray * leapYear;
@property (strong, nonatomic)NSArray * commonYear;
@end

@implementation CalendarController
@synthesize currentCal = _currentCal;

-(CalendarController *)initWithCommandStr:(NSArray *)commands{
    if (!commands) {
        [self errorInformationLog:@"Command is Empty!"];
        return nil;
    }
    if ([commands count] > 3) {
        [self errorInformationLog:@"Command arguments count should be less than 3"];
        return nil;
    }
    if (![[commands objectAtIndex:0] isEqualToString:@"cal"]) {
        [self errorInformationLog:@"Command not found!Please make sure your command begin with cal"];
        return nil;
    }
    self.commandArray = commands;
    return self;
}

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
    NSDate * date ;
    NSDateComponents * dateComponents;
    date = [NSDate date];
    dateComponents =[self.currentCal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    [dateComponents setDay:1];
    NSDate * monthBegin = [self.currentCal dateFromComponents:dateComponents];
    NSDateComponents *nowComp = [self.currentCal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:monthBegin];
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
    
    printf("日   一  二  三   四  五  六\n");
    
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

+(BOOL)isPureInt:(NSString *) sourceStr{
    NSScanner *scan = [NSScanner scannerWithString:sourceStr];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

-(void)dealWithCurrentYearMonthCal:(NSUInteger) monthSet{
    NSDate * date ;
    NSDateComponents * dateComponents;
    date = [NSDate date];
    dateComponents =[self.currentCal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    [dateComponents setMonth:monthSet];
    [dateComponents setDay:1];
    NSDate * monthBegin = [self.currentCal dateFromComponents:dateComponents];
    NSDateComponents *nowComp = [self.currentCal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:monthBegin];
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
    printf("日   一  二  三   四  五  六\n");
    
    ShowOnScreen * show = [[ShowOnScreen alloc] initforweekday:weekDay formonthdays:monthdays];
    [show ShowCalendar];
}

-(void)dealWithCertainCal:(NSUInteger) monthSet withYear:(NSUInteger) yearSet{
    NSDate * date ;
    NSDateComponents * dateComponents;
    date = [NSDate date];
    dateComponents =[self.currentCal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    [dateComponents setYear:yearSet];
    [dateComponents setMonth:monthSet];
    [dateComponents setDay:1];
    NSDate * monthBegin = [self.currentCal dateFromComponents:dateComponents];
    NSDateComponents *nowComp = [self.currentCal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:monthBegin];
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
    printf("日   一  二  三   四  五  六\n");
    
    ShowOnScreen * show = [[ShowOnScreen alloc] initforweekday:weekDay formonthdays:monthdays];
    [show ShowCalendar];
}


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

-(NSCalendar *)currentCal{
    if (!_currentCal) {
        _currentCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    return _currentCal;
}
-(NSArray *)leapYear{
    if (!_leapYear) {
        _leapYear = @[@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    }
    return _leapYear;
}
-(NSArray *)commonYear{
    if (!_commonYear) {
        _commonYear = @[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    }
    return _commonYear;
}

-(void) errorInformationLog:(NSString*)log{
    NSLog(@"%@",log);
}
@end
