//
//  SettingTableViewController.m
//  justread
//
//  Created by Van on 14/12/8.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults boolForKey:@"night"]) {
        [self.nightSwitch setOn:YES];
    }else{
        [self.nightSwitch  setOn:NO];
    }
    if ([userDefaults boolForKey:@"downloadImage"]) {
        [self.downloadImageSwitch setOn:YES];
    }else{
        [self.downloadImageSwitch setOn:NO];
    }
    [self switchMode];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

- (IBAction)nightClick:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([sender isOn]){
        NSLog(@"Switch is ON");
        [userDefaults setBool:YES forKey:@"night"];
    } else{
        [userDefaults setBool:NO forKey:@"night"];
    }
    [userDefaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refrash" object:self];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"refrashFav" object:self];
    [self switchMode];
}

- (IBAction)imageClick:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([sender isOn]){
        NSLog(@"Switch is ON");
        [userDefaults setBool:YES forKey:@"downloadImage"];
    } else{
        [userDefaults setBool:NO forKey:@"downloadImage"];
    }
    [userDefaults synchronize];
}
- (IBAction)infoClick:(id)sender {
    
}

- (UIColor *) stringToColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

- (void) switchMode{
    if (self.nightSwitch.isOn) {
        [self.view setBackgroundColor:[self  stringToColor:@"#343434"]];
        self.cellOne.backgroundColor = [UIColor darkGrayColor];
        self.cellTwo.backgroundColor = [UIColor darkGrayColor];
        self.cellThree.backgroundColor = [UIColor darkGrayColor];
        self.cellFour.backgroundColor = [UIColor darkGrayColor];
        self.nightLabel.textColor = [UIColor whiteColor];
        self.downloadLabel.textColor = [UIColor whiteColor];
        self.useLabel.textColor = [UIColor whiteColor];
        self.versionLabel.textColor = [UIColor whiteColor];
        self.infoBtn.tintColor = [UIColor whiteColor];
    }else{
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.cellOne.backgroundColor = [UIColor whiteColor];
        self.cellTwo.backgroundColor = [UIColor whiteColor];
        self.cellThree.backgroundColor = [UIColor whiteColor];
        self.cellFour.backgroundColor = [UIColor whiteColor];
        self.nightLabel.textColor = [UIColor blackColor];
        self.downloadLabel.textColor = [UIColor blackColor];
        self.useLabel.textColor = [UIColor blackColor];
        self.versionLabel.textColor = [UIColor blackColor];
        self.infoBtn.tintColor = nil;
    }
}
@end
