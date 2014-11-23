//
//  CanvasViewController.m
//  Project4-Note
//
//  Created by  ws on 11/20/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import "CanvasViewController.h"
#import "ViewController.h"
#import "Data.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController
Data* note=nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _drawView.color = self.color = [UIColor blackColor];
    ViewController *nodesListView = (ViewController *)self.delegate;
    if (self.noteIndex) {
        note = [nodesListView.mynotes objectAtIndex:[self.noteIndex integerValue]];
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
            //声明一个新的note
            note= (Data *)[NSEntityDescription insertNewObjectForEntityForName:@"Data" inManagedObjectContext:self.managedObjectContext];
            ViewController *notesListView = (ViewController *)self.delegate;
            [notesListView.mynotes insertObject:note atIndex:0];
        }
        note.attribute = imageFilePath;
        note.time = [NSDate new];
        note.type = Data.DRAW_TYPE;
        NSError *error = nil;
        if (![note.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"图片保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
