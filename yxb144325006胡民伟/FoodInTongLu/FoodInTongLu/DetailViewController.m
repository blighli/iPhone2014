//
//  DetailViewController.m
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/4.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "MapViewController.h"

@interface DetailViewController ()

@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.restaurantImage.image = [UIImage imageWithData:self.restaurant.image];
    self.tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.2];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tableView.separatorColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.8];
    self.title = self.restaurant.name;
    
    self.tableView.estimatedRowHeight = 36.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.hidesBarsOnSwipe = false;
    [self.navigationController setNavigationBarHidden:false animated:true];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailTableViewCell *cell = (DetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"
                                                                                      forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.mapButton.hidden = true;
    switch (indexPath.row) {
        case 0:
            cell.fieldLabel.text = @"Name";
            cell.valueLabel.text = self.restaurant.name;
            break;
        case 1:
            cell.fieldLabel.text = @"Type";
            cell.valueLabel.text = self.restaurant.type;
            break;
        case 2:
            cell.fieldLabel.text = @"Location";
            cell.valueLabel.text = self.restaurant.location;
            cell.mapButton.hidden = false;
            break;
        case 3:
            cell.fieldLabel.text = @"Been here";
            if (self.restaurant.isVisited.boolValue == true) {
                cell.valueLabel.text = @"Yes, I’ve been here before";
            }else{
                cell.valueLabel.text = @"No";
            }
            break;
        default:
            cell.fieldLabel.text = @"";
            cell.valueLabel.text = @"";
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(IBAction) close:(UIStoryboardSegue *) segue{

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 
    if ([segue.identifier isEqualToString:@"showMap"]){
        MapViewController *destinationController = segue.destinationViewController;
        destinationController.restaurant = self.restaurant;
    }

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
