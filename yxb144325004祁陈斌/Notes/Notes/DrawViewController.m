//
//  DrawViewController.m
//  Notes
//
//  Created by xsdlr on 14/11/18.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "DrawViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "ViewController.h"
#import "Note.h"
#import "InfColorPickerController.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

Note* note = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _drawView.color = self.color = [UIColor blackColor];
    ViewController *nodesListView = (ViewController *)self.delegate;
    if (self.noteIndex) {
        note = [nodesListView.notes objectAtIndex:[self.noteIndex integerValue]];
//        UIImage* image = [[UIImage alloc]initWithContentsOfFile: note.message];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(UIBarButtonItem *)sender {
    NSString* imageDirPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString: @"/images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:imageDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMddHHmmss"];
    
    NSDate* nowDate = [NSDate new];
    NSString *imageFilePath = [imageDirPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate: nowDate], @"png"];
    
    if ([_drawView saveToPNGFile:imageFilePath]) {
        if (!_noteIndex) {
            note = [Note MR_createEntity];
            ViewController *notesListView = (ViewController *)self.delegate;
            [notesListView.notes insertObject:note atIndex:0];
        }
        note.message = imageFilePath;
        note.time = [NSDate new];
        note.type = Note.DRAW_TYPE;
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"图片保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pickFontColor:(UIBarButtonItem *)sender {
    InfColorPickerController* picker = [ InfColorPickerController colorPickerViewController ];
    picker.title = @"颜色";
    picker.sourceColor = self.color;
    picker.delegate = self;
    
    [ picker presentModallyOverViewController: self ];
}

- (void) colorPickerControllerDidFinish: (InfColorPickerController*) picker{
    _drawView.color = self.color = picker.resultColor;
    [ self dismissModalViewControllerAnimated: YES ];
}

- (IBAction)fontSizeChange:(UISlider *)sender {
    _drawView.width = sender.value;
}
@end
