//
//  DrawBoardViewController.m
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import "NewDrawNoteViewController.h"
#import "NoteEntity.h"
#import "NoteDAO.h"

@interface NewDrawNoteViewController ()

@end

@implementation NewDrawNoteViewController
{
    NoteDAO* _noteDAO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _noteDAO = [NoteDAO new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveDrawNote:(id)sender {
    NSString *drawPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"draw_note"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:drawPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss_SSSS"];
    NSDate* nowDate = [[NSDate alloc] init];
    NSString *drawFilePath = [drawPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate:nowDate], @"draw"];
    if([self.drawBoardView writeToFile:drawFilePath]) {
        NoteEntity* note = [[NoteEntity alloc] initWithType:DrawNote andContent:drawFilePath];
        [_noteDAO insertNote:note];
        NSLog(@"draw note write to file success, file path is %@", drawFilePath);
    }
    else {
        NSLog(@"draw note write to file failed, file path is %@", drawFilePath);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
