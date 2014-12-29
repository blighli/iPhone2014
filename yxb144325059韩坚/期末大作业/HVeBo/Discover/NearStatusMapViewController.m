//
//  NearStatusMapViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/23.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "NearStatusMapViewController.h"
#import "HttpTool.h"

@interface NearStatusMapViewController ()
{
    CLLocationManager *locationManager;
}
@end

@implementation NearStatusMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    [manager stopUpdatingLocation];
    if (_data == nil) {
        NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
        NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:5];
        [params setObject:lon forKey:@"long"];
        [params setObject:lat forKey:@"lat"];
        [HttpTool wbHttpRequest:@"place/nearby_timeline.json" httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
            if (!error) {
                NSLog(@"%@",result);
            }
        }];
    }
}

@end
