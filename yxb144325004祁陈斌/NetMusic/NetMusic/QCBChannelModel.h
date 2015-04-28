//
//  QCBChannelModel.h
//  NetMusic
//
//  Created by xsdlr on 14/12/5.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "QCBBaseModel.h"

@interface QCBChannelModel : QCBBaseModel
/**
 *  频道英文名
 */
@property(strong,nonatomic) NSString *name_en;
/**
 *  频道序号
 */
@property(assign,nonatomic) NSInteger seq_id;
/**
 *  abbr_en
 */
@property(strong,nonatomic) NSString *abbr_en;
/**
 *  频道id
 */
@property(strong,nonatomic) NSString *channel_id;
/**
 *  频道名称
 */
@property(strong,nonatomic) NSString *name;
@end
