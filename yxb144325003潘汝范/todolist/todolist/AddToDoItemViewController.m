//
//  AddToDoItemViewController.m
//  todolist
//
//  Created by Van on 14/11/6.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "AddToDoItemViewController.h"

@interface AddToDoItemViewController ()

@end

@implementation AddToDoItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    if (self.item!=nil) {
        self.textfiled.text = self.item.item;
        self.isEdit = YES;
    }else{
        self.isEdit = NO;
    }
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
    if (sender != self.doneButton) return;
    if (self.isEdit) {
        [AddToDoItemViewController editCell:self.item :self.managedObjectContext :self.textfiled.text];
    }else{
        if (self.textfiled.text.length > 0) {
            if(self.managedObjectContext != nil){
                TodoItem *item = (TodoItem *)[NSEntityDescription insertNewObjectForEntityForName:@"TodoItem" inManagedObjectContext:self.managedObjectContext];
                [item setItem:self.textfiled.text];
                NSManagedObjectID *moID = [item objectID];
                NSString *identifier=[moID.URIRepresentation absoluteString];
                [item setId:identifier];
                NSError *error;
                //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
                BOOL isSaveSuccess = [self.managedObjectContext save:&error];
                if (!isSaveSuccess) {
//                    NSLog(@"Error: %@,%@",error,[error userInfo]);
                }else {
//                    NSLog(@"Save successful!");
                }
            }else{
                NSLog(@"空指针");
            }
        }

    }
   }
+(void) editCell:(TodoItem *)item :(NSManagedObjectContext *)managedObjectContext :(NSString *)textfield
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"TodoItem"inManagedObjectContext:managedObjectContext]];
    
    //删除谁的条件在这里配置；
    NSString *id = item.id;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id==%@", id]];
    NSError* error = nil;
    NSArray* results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([results count] > 0) {
        if ([textfield length]>0) {
            for (TodoItem *item in results) {
                item.item = textfield;
                NSLog(@"更新数据");
            }
        }else{
            [managedObjectContext deleteObject:[results objectAtIndex:0]];
            NSLog(@"删除的数据 %@",[results objectAtIndex:0]);
        }

        
    }
    [managedObjectContext save:&error];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveChange" object:self];
}

@end
