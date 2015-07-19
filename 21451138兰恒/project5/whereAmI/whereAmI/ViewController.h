//
//  ViewController.h
//  whereAmI
//
//  Created by lh on 14-12-29.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<MKMapViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *longtitudeText;
@property (weak, nonatomic) IBOutlet UITextField *latitudeText;
//@property (weak, nonatomic) IBOutlet UILabel *longtitudeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)annotationAction:(id)sender;
@end
