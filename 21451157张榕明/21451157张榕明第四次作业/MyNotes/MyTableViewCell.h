//
//  MyTableViewCell.h
//  MyNotes
//
//  Created by 张榕明 on 14/11/22.
//  Copyright (c) 2014年 张榕明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *cellTitle;


@property (strong, nonatomic) IBOutlet UILabel *cellSubTitle;

@property (strong, nonatomic) IBOutlet UIImageView *cellImage;



@end
