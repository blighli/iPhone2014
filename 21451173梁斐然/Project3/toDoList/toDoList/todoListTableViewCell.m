//
//  todoListTableViewCell.m
//  toDoList
//
//  Created by LFR on 14/11/11.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import "todoListTableViewCell.h"

@implementation todoListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    Model *model = [Model sharedInstance];
    model.listArray[self.indexPath.row] = textView.text;
    return YES;
}


@end
