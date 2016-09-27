//
//  SyTableViewCell.m
//  食客天下
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SyTableViewCell.h"
@interface SyTableViewCell ()


@end
@implementation SyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setUIWithdic:(NSDictionary *)dic
{

    [self.Sytabcell setImageWithURL:dic[@"url"] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
