//
//  ViewController.h
//  CounterApp
//
//  Created by  sephiroth on 14/11/6.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Count.h"

@interface ViewController : UIViewController
{
    Count * countor;
}
@property (weak, nonatomic) IBOutlet UITextField *show;
- (IBAction)push:(UIButton *)sender;


@end

