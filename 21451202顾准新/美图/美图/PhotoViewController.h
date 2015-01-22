//
//  PhotoViewController.h
//  美图
//
//  Created by 顾准新 on 14-12-18.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageWaterView.h"
#import "JSONKit.h"


#import "ASIHTTPRequest.h"

#import "MJRefresh.h"     //刷新

#import "TGRImageViewController.h"      //图片浏览
#import "TGRImageZoomAnimationController.h"

#import "DXAlertView.h"   //AlertView



#import "SidebarViewController.h"

@interface PhotoViewController : UIViewController<MJRefreshBaseViewDelegate, UIViewControllerTransitioningDelegate,SidebarDelegate>


@property (nonatomic,strong) NSString *tag1;
@property (nonatomic,strong) NSString *tag2;
@property (nonatomic,strong) NSString *index1;
@property (nonatomic,strong) NSString *index2;

@property (nonatomic,weak) NSDictionary *urlTag1;

@property (nonatomic,weak) NSDictionary *urlttag2;

@property (nonatomic,strong)ImageWaterView *waterView;
@property (nonatomic,strong) ASIHTTPRequest *testRequest;

@end
