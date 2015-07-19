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
    if (self.note == nil) {
        self.note = [[Note alloc]init];
    }
    else{
        [self.picture readFromFile:self.note.picture];
    }
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
    if (self.note.picture == nil) {
        NSString *picturePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"picture"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:picturePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yy_MM_dd_HH_mm_ss"];
        NSDate* nowDate = [[NSDate alloc] init];
        NSString *drawFilePath = [picturePath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate:nowDate], @"picture"];
        self.note.picture = drawFilePath;
    }
    if([self.picture writeToFile:self.note.picture]) {
        NSLog(@"picture write success,path:%@", self.note.picture);
    }
    else {
        NSLog(@"picture write failed,path:%@", self.note.picture);
    }
}

- (IBAction)clearPicture:(UIBarButtonItem *)sender {
    [self.picture.lineArray removeAllObjects];
    [self.picture.pointArray removeAllObjects];
    [self.picture setNeedsDisplay];
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
