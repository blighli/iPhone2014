//
//  MyTableViewController.m
//  MyNotes
//
//  Created by 樊博超 on 14-11-21.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyViewController.h"
#import "NoteData.h"
#import "ThirdViewController.h"
@interface MyTableViewController ()

@end

@implementation MyTableViewController
NSMutableArray  *plist;
UITableView *view;

- (id)init
{
    // 调用超类的designated initializer
    self= [super initWithStyle: UITableViewStyleGrouped];
    if(self) {
        db = [[Database alloc] init];
        plist = [[NSMutableArray alloc] init];
        [plist addObject:@"test"];
        [plist addObject:@"11111"];
        [plist addObject:@"9999"];
        self.title = @"内容列表";
        
    }

    return self;
}
- (id)initWithStyle:(UITableViewStyle)style {
    return[self init];
}



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem* tbi = [self tabBarItem];
        [tbi setTitle:@"列表"];
        
        UIImage* image = [UIImage imageNamed:@"text.png"];
        
        [tbi setImage:image];
    }
    return self;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [plist count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    NoteData *item = [plist objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item.name];
    [[cell detailTextLabel] setText:item.type];
    
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    NSInteger row = [indexPath row];
    NoteData * data = [plist objectAtIndex:row];
    if ([data.type isEqualToString:@"text"]) {
        MyViewController *cc =[[MyViewController alloc] init];
        [cc setItem:data];
        [self.navigationController pushViewController:cc animated:YES];
        [cc setTitle:@"content"];
    }else if ([data.type isEqualToString:@"pic"]){
        ThirdViewController * nextController = [[ThirdViewController alloc] init];
        [nextController setItem:data];
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController setTitle:@"draw"];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [db openDatabase];
    [db createTable];
    plist = [db queryTable];
    [db closeDatabase];
    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
