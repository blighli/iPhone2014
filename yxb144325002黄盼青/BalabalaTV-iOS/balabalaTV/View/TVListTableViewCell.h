//
//  TVListTableViewCell.h
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/5.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVListTableViewCell : UITableViewCell

/**
 *  设置电视台台标
 *
 *  @param image 电视台logo
 */
-(void)setLogoImage:(UIImage *)image;
/**
 *  设置电视台名称
 *
 *  @param name 电视台名称
 */
-(void)setTVName:(NSString *)name;
/**
 *  设置视频播放源数量
 *
 *  @param count 播放源数量
 */
-(void)setSourceCount:(NSInteger)count;

/**
 *  设置数据所在数组位置
 *
 *  @param pathRow 数据在数组中的位置
 */
-(void)setPathRow:(NSInteger)pathRow;
/**
 *  设置播放按钮点击事件
 *
 *  @param btnTarget 目标
 *  @param selector  选择器(必须一个参数，且为NSNumber)
 */
-(void)setBtnTarget:(id)btnTarget andSelector:(SEL)selector;
@end
