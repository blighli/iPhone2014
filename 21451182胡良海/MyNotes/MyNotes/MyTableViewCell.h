//
//  MyTableViewCell.h
//  MyNotes
//
//  Created by hu on 14/11/14.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *cellTitle;


@property (strong, nonatomic) IBOutlet UILabel *cellSubTitle;

@property (strong, nonatomic) IBOutlet UIImageView *cellImage;



@end
