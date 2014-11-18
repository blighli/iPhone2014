//
//  NoteTableViewCell.h
//  AnyNote
//
//  Created by 黄盼青 on 14/11/18.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *type;
@property (strong,nonatomic) IBOutlet UILabel *date;
@property (strong,nonatomic) IBOutlet UIImageView *cellImg;

@end
