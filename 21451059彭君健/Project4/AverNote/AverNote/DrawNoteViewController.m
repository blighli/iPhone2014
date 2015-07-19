//
//  DrawNoteViewController.m
//  AverNote
//
//  Created by Mz on 14-11-21.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "DrawNoteViewController.h"
#import "CanvasView.h"
#import "Util.h"
#import "Note.h"
#import "ViewController.h"

@interface DrawNoteViewController ()
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *penSizeTitle;
@property (weak, nonatomic) IBOutlet UIStepper *penSizeStepper;

@property (nonatomic) CanvasView *canvas;
@end

@implementation DrawNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat toolBarHeight = self.toolBar.frame.size.height;
    frame.origin.x += 10;
    frame.origin.y += 10 + navBarHeight;
    frame.size.width -= 20;
    frame.size.height -= 20 + navBarHeight + toolBarHeight;
    self.canvas = [[CanvasView alloc] initWithFrame:frame];
    [self.view addSubview:self.canvas];
    
    self.penSizeStepper.value = 3;
    self.penSizeStepper.minimumValue = 3;
    self.penSizeStepper.maximumValue = 10;
    self.penSizeStepper.stepValue = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveDrawNote:(id)sender {
    NSLog(@"Saving Drawing Note...");
    [Util writeImageToFile:[self.canvas getImage] withCompletion:^(BOOL didSuccess, NSString *imagePath) {
        if (didSuccess) {
            Note *note = [Note MR_createEntity];
            note.date = [NSDate date];
            note.content = imagePath;
            note.type = [NSNumber numberWithInt:NoteTypeDarwing];
            [self.mainView.notes insertObject:note atIndex:0];
            [self.mainView.noteTable reloadData];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)clearCanvas:(id)sender {
    [self.canvas clearCanvas];
}

- (IBAction)blackColorSelected:(id)sender {
    self.canvas.lineColor = [UIColor blackColor];
}

- (IBAction)redColorSelected:(id)sender {
    self.canvas.lineColor = [UIColor redColor];
}

- (IBAction)penSizeChanged:(id)sender {
    self.canvas.lineWidth = self.penSizeStepper.value;
    self.penSizeTitle.title = [NSString stringWithFormat:@"画笔大小:%d", (int)self.penSizeStepper.value];
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
