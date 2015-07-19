//
//  LoginViewController.h
//  NetDemo
//
//  Created by ccr  on 14-12-6.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHttpHeaders.h"
#import "CJSONDeserializer.h"
#import "tooles.h"
@interface LoginViewController : UIViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *username;
    UITextField *password;

}
@property (nonatomic,retain) UITextField *username;
@property (nonatomic,retain) UITextField *password;

@end
