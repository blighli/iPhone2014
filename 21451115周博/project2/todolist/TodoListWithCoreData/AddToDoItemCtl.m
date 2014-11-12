//
//  AddToDoItemCtl.m
//  todolist
//
//  Created by zhou on 14/11/6.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "AddToDoItemCtl.h"
#import "AppDelegate.h"
#import "Item+Create.h"


@interface AddToDoItemCtl ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBtn;

@end

@implementation AddToDoItemCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender != self.doneBtn) {
        return;
        
    }
    
    if (self.textField.text.length>0) {
        self.todoItem  = [Item CreateItemWithName:self.textField.text inManagedObjectContext:self.managedObjectContext];
        
    }
    
    
}


@end
