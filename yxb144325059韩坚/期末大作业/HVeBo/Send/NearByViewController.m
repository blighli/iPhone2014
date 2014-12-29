//
//  nearByViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/18.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "nearByViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "HttpTool.h"

@interface NearByViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@property (nonatomic, strong)NSArray *data;
@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"删除位置" style:UIBarButtonItemStylePlain target:self action:@selector(deleLocation)];
    self.navigationItem.rightBarButtonItem = right;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
     [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];

}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"didChangeAuthorizationStatus---%u",status);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didChangeAuthorizationStatus----%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    if (self.data == nil) {
        float longitude = newLocation.coordinate.longitude;
        float latitude = newLocation.coordinate.latitude;
        NSString *longitudeString = [NSString stringWithFormat:@"%f",longitude];
        NSString *latitudeString = [NSString stringWithFormat:@"%f",latitude];
        //NSLog(@"%@   -   %@",longitudeString,latitudeString);
        NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithCapacity:3];
        [params setObject:longitudeString forKey:@"long"];
        [params setObject:latitudeString forKey:@"lat"];
        [HttpTool wbHttpRequest:@"place/nearby/pois.json" httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
            if (!error) {
                 _data = result[@"pois"];
               
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data? _data.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    NSDictionary *dic = _data[indexPath.row];
    NSString *title  = dic[@"title"];
    NSString *address = dic[@"address"];
    if ([address isKindOfClass:[NSNull class]]||address.length == 0) {
        address = dic[@"poi_street_address"];
    }
    NSString *icon = dic[@"icon"];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = address;
    [HttpTool dowloadImage:icon iamgeview:cell.imageView placeHolder:nil];
    if (_data == nil && indexPath.row == 0) {
        cell.textLabel.text = @"加载附近的地点中...";
        cell.detailTextLabel.text = @"说明：虚拟机可能无法完成此项功能";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectDownBlock != nil) {
        NSDictionary *dic = _data[indexPath.row];
        _selectDownBlock(dic);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)deleLocation
{
    _selectDownBlock(nil);
    [self dismissViewControllerAnimated:YES completion:nil];
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
