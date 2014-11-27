//
//  TextNoteController.m
//  MyNotes
//
//  Created by 焦守杰 on 14/11/14.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "TextNoteController.h"
#import "ModifyTextNoteViewController.h"
@interface TextNoteController ()

@end

@implementation TextNoteController

- (void)viewDidLoad {
    [super viewDidLoad];
     tv=(UITableView*)[[self view] viewWithTag:1];
    _dbu=[[DatabaseUtil alloc]init];
    [self loadData];
    [tv setDataSource:self];
    [tv setDelegate:self];
  
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
    [tv reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData{
    showData=[_dbu NoteDataWithType:@"0"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  //  NSLog(@"%d",showData.count);
    return showData.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSArray *sections = [SvTableViewDataModal sections];
 //   SvSectionModal *sectionModal = [sections objectAtIndex:indexPath.section];
    NoteData *data=showData[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"TextCell"];
    }
 //   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.editingAccessoryType=UITableViewCellEditingStyleDelete;
    cell.showsReorderControl = YES;
    cell.textLabel.text=[data note];
    cell.detailTextLabel.text=[data time];
//    NSLog(@"-=-=-=-=-=-=-=-=-=--");
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
   //     NSLog(@"DELETE  %d",indexPath.row);
        NoteData *td=showData[indexPath.row];
        NSLog(@"%d ",td.id );
        [showData removeObject:td];
        [tableView reloadData];
        [_dbu deleteNoteWithId:td.id];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
//    ModifyTextNoteViewController *mtv=[[ModifyTextNoteViewController alloc]initWithTextViewContent:[showData[indexPath.row] note]];
        ModifyTextNoteViewController *mtv=[self.storyboard instantiateViewControllerWithIdentifier:@"modifyView"];
        mtv.textNoteData=showData[indexPath.row];
        mtv.modalPresentationStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:mtv animated:YES completion:nil];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
}
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"pushToModifyTextNote"]) {
//        NSIndexPath *indexPath = [tv indexPathForSelectedRow];
//        NoteData *nd = [showData objectAtIndex:[indexPath row]];
//        ModifyTextNoteViewController  *destViewController = segue.destinationViewController;
//        destViewController.textNoteData=nd;
//    }
//}




@end
