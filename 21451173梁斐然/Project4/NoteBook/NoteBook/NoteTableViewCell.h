//
//  NoteTableViewCell.h
//  NoteBook
//
//  Created by LFR on 14/11/16.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteEntity.h"

@interface NoteTableViewCell : UITableViewCell

@property (strong, nonatomic) NoteEntity *noteEntity;

@end
