//
//  noteViewController.m
//  evernote
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "noteViewController.h"
#import "testTransitionController.h"

@interface noteViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation noteViewController

@synthesize table;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title=@"note";
    contentList=[[NSMutableArray alloc]init];
       appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //查询
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
        for (NSManagedObject *info in fetchedObjects) {
      
        NSLog(@"Name: %@", [info valueForKey:@"name"]);
        [contentList addObject:[info valueForKey:@"name"]];
    }

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"reload");
    //查询
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];

    [table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [contentList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[table dequeueReusableCellWithIdentifier:@"cellfornote"];
//    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellfornote"];
    cell.textLabel.text=[contentList objectAtIndex:indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    [contentList removeObjectAtIndex:indexPath.row];//去掉此下标的数据，并且数据往前移
    
    
    
    
//    NSPredicate * predicate;
//    predicate = [NSPredicate predicateWithFormat:@"name==%@", [contentList objectAtIndex:indexPath.row]];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"User" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    [fetchRequest setPredicate: predicate];
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
//    for (NSManagedObject *info in fetchedObjects) {
//      
    
    [context deleteObject:[fetchedObjects objectAtIndex:indexPath.row]];
        
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@,",error);
        abort();
    }
//    }
   [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationTop];
    NSLog(@"delete success");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    testTransitionController *edittext=[[testTransitionController alloc]init];
    NSLog(@"%ld",indexPath.row);
   x=indexPath.row;
//   [self.navigationController pushViewController:edittext animated:NO];
//    [self presentViewController:edittext animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)edit:(id)sender {
    
    [self performSegueWithIdentifier:@"toaddnote" sender:nil];

}
@end
