//
//  TextViewController.m
//  Project4-Note
//
//  Created by  ws on 11/21/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import "TextViewController.h"
#import "ViewController.h"
#import "Data.h"
@interface TextViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    ViewController *nodesListView = (ViewController *)self.delegate;
    //用这个方法也可以
    //_managedObjectContext=nodesListView.managedObjectContext;
    if (self.noteIndex != nil) {
       Data * note = [nodesListView.mynotes objectAtIndex:[self.noteIndex integerValue]];
        self.textView.text = note.attribute;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(UIBarButtonItem *)sender {
    Data* note;
    ViewController *notesListView = (ViewController *)self.delegate;
    if (self.noteIndex != nil) {
        note = [notesListView.mynotes objectAtIndex:[self.noteIndex integerValue]];
    } else {
        //创建一个新的Data类型note
       note= (Data *)[NSEntityDescription insertNewObjectForEntityForName:@"Data" inManagedObjectContext:self.managedObjectContext];
        [notesListView.mynotes insertObject:note atIndex:0];
    }
    note.type = Data.TEXT_TYPE;
    note.time = [NSDate new];
    note.attribute = self.textView.text;
    //将数据写入
    NSError *error = nil;
    if (![note.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self.navigationController popViewControllerAnimated:YES];

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
