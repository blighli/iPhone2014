//
//  ViewController.m
//  Project3
//
//  Created by xsdlr on 14/11/6.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableDictionary* dict;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self readFile:@"tasklist.plist"];
}

- (void) readFile:(NSString*)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];

    dict = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
    if (!dict) {
        dict = [NSMutableDictionary new];
        self.tasks = [NSMutableArray new];
    } else {
        self.tasks = [dict objectForKey:@"task"];
    }
}

- (void) saveFile:(NSString*)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    [dict setObject:self.tasks forKey:@"task"];
    [dict writeToFile:fileName atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    cell.textLabel.text = self.tasks[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"taskSegue" sender:[NSNumber numberWithInteger:indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destination = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"taskSegue"]) {
        destination = [segue.destinationViewController topViewController];
        [destination setValue:sender forKeyPath:@"taskIndex"];
    } else {
        destination = [segue.destinationViewController topViewController];
    }
    [destination setValue:self forKeyPath:@"delegate"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        [self saveFile:@"tasklist.plist"];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

@end
