//
//  MapViewController.m
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/13.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    // Convert address to coordinate and annotate it on map
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder geocodeAddressString:self.restaurant.location
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     if (error != nil) {
                         NSLog(error);
                         return ;
                     }
                     
                     if (placemarks != nil && placemarks.count > 0) {
                         CLPlacemark *placemark = [placemarks objectAtIndex:0];
                         MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
                         [annotation setTitle:self.restaurant.name];
                         [annotation setSubtitle:self.restaurant.type];
                         [annotation setCoordinate:placemark.location.coordinate];
                         
                         [self.mapView showAnnotations:[NSArray arrayWithObject:annotation] animated:true];
                         [self.mapView selectAnnotation:annotation animated:true];
                     }
                 }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
   
    NSString *identifier = @"MyPin";
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = true;
    }
    
    UIImageView *leftIconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 53, 53)];
    leftIconView.image = [UIImage imageWithData:self.restaurant.image];
    annotationView.leftCalloutAccessoryView = leftIconView;

    return annotationView;
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
