//
//  DetailViewController.m
//  TodoList
//
//  Created by 周舟 on 6/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "DetailViewController.h"
#import "NewTaskViewController.h"

#define HomePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
@interface DetailViewController ()


@property (weak, nonatomic) IBOutlet UITextView *taskContentText;

@end

@implementation DetailViewController

- (void)setTaskName:(NSString *)taskName
{
    _taskName = taskName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.nameLabel.text = self.taskName;
    self.navigationItem.title = self.taskName;
    
    [self loadTaskContent];
    
    
}

- (void)loadTaskContent
{
    NSString *fileName = [self.taskName stringByAppendingPathExtension:@"txt"];
    NSString *filePath = [HomePath stringByAppendingPathComponent:fileName];
    NSLog(@"%@",filePath);
    NSError *error = nil;
    NSString *contentStr = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"%@",contentStr);
    self.taskContentText.text = contentStr;
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"edit"]) {
        
        [segue.destinationViewController setName:self.taskName];
        
        [segue.destinationViewController setContent:self.taskContentText.text];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
