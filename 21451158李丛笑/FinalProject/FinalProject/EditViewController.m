//
//  EditViewController.m
//  FinalProject
//
//  Created by 李丛笑 on 15/1/5.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import "EditViewController.h"
#import "DBHelper.h"
#import "CourseData.h"

@interface EditViewController ()

@end

@implementation EditViewController
@synthesize ttagforedit;
@synthesize btag;
@synthesize hourPicker;
@synthesize nameBox;
NSString *hour = @"00";
NSString *minute = @"00";
NSMutableString *timeresult;
NSString *did;
NSString *cid;
NSMutableString *classid;

- (void)viewDidLoad {
    [super viewDidLoad];
    hourarray = [[NSMutableArray alloc]initWithCapacity:24];
        for (int i = 0; i<24; i++) {
        NSMutableString *addhour = [[NSMutableString alloc]init];
        if (i<10) {
            [addhour appendString:@"0"];
            [addhour appendString:[NSString stringWithFormat:@"%d",i]];
        }
        else
            [addhour appendString:[NSString stringWithFormat:@"%d",i]];
        [hourarray addObject:addhour];
    }
    minutearray = [[NSMutableArray alloc]initWithCapacity:60];
    for (int i = 0; i<60; i++) {
        NSMutableString *addminute = [[NSMutableString alloc]init];
        if (i<10) {
            [addminute appendString:@"0"];
            [addminute appendString:[NSString stringWithFormat:@"%d",i]];
        }
        else
            [addminute appendString:[NSString stringWithFormat:@"%d",i]];
        [minutearray addObject:addminute];
    }
    hourPicker.delegate = self;
    hourPicker.dataSource = self;
    DBHelper *db = [[DBHelper alloc]init];
    classid = [[NSMutableString alloc]init];
    int classno = [btag intValue];
    did = [NSString stringWithFormat:@"%d",classno/10];
    cid = [NSString stringWithFormat:@"%d",classno-(classno/10)*10];
    [classid appendString:ttagforedit];
    [classid appendString:@" "];
    [classid appendString:did];
    [classid appendString:@" "];
    [classid appendString:cid];
    [db CreateDB];
    NSArray *data = [db QueryDB:classid IfByClassid:NO];
    for (int i = 0; i<[data count]; i++) {
        CourseData *coursedata = [data objectAtIndex:i];
        if ([classid isEqualToString:coursedata.classid]) {
            nameBox.text = coursedata.classname;
            hour = [coursedata.classtime substringToIndex:2];
            minute = [coursedata.classtime substringFromIndex:3];
            //NSLog(cls);
            break;
        }
    }
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
/*return row number*/
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        return [hourarray count];
    
        return [minutearray count];
}

/*return component row str*/
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
        
        return [hourarray objectAtIndex:row];
   
        return [minutearray objectAtIndex:row];

}

/*choose com is component,row's function*/
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray* tmp;
    timeresult = [[NSMutableString alloc]init];
    if (component == 0){
        tmp = hourarray;
        hour = [tmp objectAtIndex:row];
    }
    else {
        tmp = minutearray;
        minute = [tmp objectAtIndex:row];
    }
    [timeresult appendString:hour];
    [timeresult appendString:@":"];
    [timeresult appendString:minute];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveBtn:(id)sender {
    DBHelper *db = [[DBHelper alloc]init];
    NSString *classname = nameBox.text;
    [db CreateDB];
    [db InsertDB:classid Classname:classname Classtime:timeresult];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    NSDateComponents *pushcomps = [[NSDateComponents alloc] init];
    [pushcomps setWeekday:[did intValue]];
    [pushcomps setHour:[hour intValue]];
    [pushcomps setMinute:[minute intValue]];
    [pushcomps setSecond:0];
    if (notification != nil) {
        notification.fireDate = [calendar dateFromComponents:pushcomps];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.repeatInterval = kCFCalendarUnitDay;
        notification.soundName = UILocalNotificationDefaultSoundName;
        NSMutableString *alertcontent = [[NSMutableString alloc] init];
        [alertcontent appendString:@"上课啦~   课程："];
        [alertcontent appendString:classname];
        notification.alertBody = alertcontent;
        notification.alertAction = @"确定";
        notification.applicationIconBadgeNumber = 1;
        NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
        notification.userInfo = info;
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
