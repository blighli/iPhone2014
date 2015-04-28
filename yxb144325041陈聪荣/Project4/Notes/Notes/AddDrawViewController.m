//
//  AddDrawViewController.m
//  Notes
//
//  Created by 陈聪荣 on 14/12/6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "AddDrawViewController.h"

@interface AddDrawViewController ()

@end

@implementation AddDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _noteBiz = [[NoteBiz alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)returnOnclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveOnclick:(id)sender {
    
    NSString *drawPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"draw_note"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:drawPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss_SSSS"];
    NSDate* nowDate = [[NSDate alloc] init];
    NSString *drawFilePath = [drawPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate:nowDate], @"draw"];
    if([_drawView writeToFile:drawFilePath]) {
        Note* note = [[Note alloc] init];
        note.date = [[NSDate alloc]init];
        note.content = drawFilePath;
        note.type = 3;
        [_noteBiz createNote:note];
        NSLog(@"draw note write to file success, file path is %@", drawFilePath);
    }
    else {
        NSLog(@"draw note write to file failed, file path is %@", drawFilePath);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:nil userInfo:nil];
    [_drawView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
