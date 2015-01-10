//
//  CitySelect.m
//  WeatherBroadcast
//
//  Created by 樊博超 on 14-12-22.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "CitySelect.h"
#import "TabWeatherShow.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface CitySelect ()
@property (weak, nonatomic) IBOutlet UITableView *cityView;


@property (strong, nonatomic) IBOutlet UILabel *longitude;
@property (strong, nonatomic) IBOutlet UILabel *latitude;

@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation CitySelect



- (id)initWithStyle:(UITableViewStyle)style {
    return[self init];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    cityList = [[NSMutableArray alloc] init];
    cityCode = [[NSMutableDictionary alloc] init];

    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    NSLog(@"jjjjj");
    [self.locationManager startUpdatingLocation];
    
    
    [cityCode setObject:@"101010100" forKey:@"北京"];
    [cityCode setObject:@"101020100" forKey:@"上海"];
    [cityCode setObject:@"101280101" forKey:@"广州"];
    [cityCode setObject:@"101280601" forKey:@"深圳"];
    [cityCode setObject:@"101110101" forKey:@"西安"];
    [cityCode setObject:@"101210101" forKey:@"杭州"];
    [cityCode setObject:@"101210401" forKey:@"宁波"];
    
    [cityList addObject:@"北京"];
    [cityList addObject:@"上海"];
    [cityList addObject:@"广州"];
    [cityList addObject:@"深圳"];
    [cityList addObject:@"西安"];
    [cityList addObject:@"杭州"];
    [cityList addObject:@"宁波"];
    
    [_cityView setDelegate:self];
    [_cityView setDataSource:self];
    self.title = @"内容列表";

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [cityList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    [[cell textLabel] setText:[cityList objectAtIndex:[indexPath row]]];
    [[cell detailTextLabel] setText:@"lllllll"];
    
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    NSInteger row = [indexPath row];
    NSString *cityName = [cityList objectAtIndex:row];
    
    NSString *myCode = [cityCode objectForKey:cityName];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    tab = [storyBoard instantiateViewControllerWithIdentifier:@"tab"];
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    
    [mySettingData setObject:cityName forKey:@"cityCode"];
    [mySettingData synchronize];
    
    
    [self.navigationController pushViewController:tab animated:YES];
//    if ([data.type isEqualToString:@"text"]) {
//        MyViewController *cc =[[MyViewController alloc] init];
//        [cc setItem:data];
//        [self.navigationController pushViewController:cc animated:YES];
//        [cc setTitle:@"content"];
//    }else if ([data.type isEqualToString:@"pic"]){
//        ThirdViewController * nextController = [[ThirdViewController alloc] init];
//        [nextController setItem:data];
//        [self.navigationController pushViewController:nextController animated:YES];
//        [nextController setTitle:@"draw"];
//    }
    
}



- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"hhhhhh");
    //将经度显示到label上
    self.longitude.text = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    //将纬度现实到label上
    self.latitude.text = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    
    NSLog([NSString stringWithFormat:@"longitude  ==  %lf", newLocation.coordinate.longitude]);
    NSLog([NSString stringWithFormat:@"latitude  ==  %lf", newLocation.coordinate.latitude]);
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             //将获得的所有信息显示到label上
             self.location.text = placemark.name;
             NSLog(placemark.name);
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             NSLog(@"city = %@", city);
             
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
