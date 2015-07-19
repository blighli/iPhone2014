//
//  ViewController.m
//  whereAmI
//
//  Created by lh on 14-12-29.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import "ViewController.h"
//#import "MyPoint.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    //[self.longtitudeText setDelegate:self];
    //[self.latitudeText setDelegate:self];
    [self.mapView setDelegate:self];
    //注释自省位置
    [self.mapView setShowsUserLocation:YES];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView*)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc =[userLocation coordinate];
    //self.longtitudeLabel.text = [NSString stringWithFormat:@"%f",loc.longitude];
    //self.latitudeLabel.text = [NSString stringWithFormat:@"%f",loc.latitude];
    //放大地图到自身的经纬度位置
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc,250,250);
    [self.mapView setRegion:region animated:YES];
}

/*- (IBAction)annotationAction:(id)sender
{
    //创建CLLocation 设置经纬度
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:[[self.latitudeText text] floatValue] longitude:[[self.longtitudeText text] floatValue]];
    CLLocationCoordinate2D coord = [loc coordinate];
    //创建标题
    NSString *titile = [NSString stringWithFormat:@"%f,%f",coord.latitude,coord.longitude];
    MyPoint *myPoint = [[MyPoint alloc] initWithCoordinate:coord andTitle:titile];
    //添加标注
    [self.mapView addAnnotation:myPoint];
    
    //放大到标注的位置
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [self.mapView setRegion:region animated:YES];
}
*/
@end
