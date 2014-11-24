//
//  PictureViewController.m
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "PictureViewController.h"

@interface PictureViewController ()

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithNote:(Note *)note{
    self = [super init];
    if (self) {
        self.note = note;
    }
    return self;
}

- (IBAction)savePicture:(UIBarButtonItem *)sender {
    NSString *drawPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"picture"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:drawPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss"];
    NSDate* nowDate = [[NSDate alloc] init];
    NSString *drawFilePath = [drawPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate:nowDate], @"picture"];
    if([self.picture writeToFile:drawFilePath]) {
//        NoteEntity* note = [[NoteEntity alloc] initWithType:DrawNote andContent:drawFilePath];
//        [_noteDAO insertNote:note];
        NSLog(@"draw note write to file success, file path is %@", drawFilePath);
    }
    else {
        NSLog(@"draw note write to file failed, file path is %@", drawFilePath);
    }
    self.note.picture = drawFilePath;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
