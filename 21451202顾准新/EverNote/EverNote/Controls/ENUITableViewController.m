//
//  ENUITableViewController.m
//  EverNote
//
//  Created by 顾准新 on 14-12-6.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "ENUITableViewController.h"
#import "ENTabBarControll.h"
#import "ENTableViewCell.h"
#import "AppDelegate.h"
@interface ENUITableViewController(){
    NSMutableArray *noteArray;
    NSInteger index;
    
   AppDelegate *delegate;
}

@property (strong,nonatomic) ENTabBarControll *envc;
@end

@implementation ENUITableViewController



-(void)viewDidLoad{
    [self loadNoteData];
    delegate = [UIApplication sharedApplication].delegate;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadNoteData];
    [self.tableView reloadData];
    
}

-(void)loadNoteData{
    [noteArray removeAllObjects];
    noteArray = [[NSMutableArray alloc] init];
    for(int i = 0; i<6; i++){
        Note *note = [[Note alloc] init];
        note.noteTitle = [NSString stringWithFormat: @"note%d",i];
       
        [noteArray addObject:note];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [noteArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *identifier = @"noteCell";
    
    ENTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell){
        cell = [[ENTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.noteTitle.text = [[noteArray objectAtIndex:indexPath.row] noteTitle];
    
    return cell;

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   // NSLog(@"segue");
    if([segue.destinationViewController isKindOfClass:[ENTabBarControll class]]){
    
        if([segue.identifier isEqualToString:@"readNote"]){
            _envc = (ENTabBarControll *)segue.destinationViewController;
            //vc.note = [noteArray objectAtIndex:index];
          
            //NSLog(@"%@",vc.note.noteTitle);
            
        }else if([segue.identifier isEqualToString:@"writeNote"]){
            ENTabBarControll *vc = (ENTabBarControll *)segue.destinationViewController;
            vc.note = nil;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ENTabBarControll *vc = [[ENTabBarControll alloc] init];
//    vc.note = [noteArray objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:vc animated:NO];
    _envc.note = [noteArray objectAtIndex:indexPath.row];
    NSLog(@"1%@",_envc.note.noteTitle);
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    
}


@end
