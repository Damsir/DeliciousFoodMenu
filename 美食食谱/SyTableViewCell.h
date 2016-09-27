//
//  SyTableViewCell.h
//  食客天下
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Sytabcell;
-(void)setUIWithdic:(NSDictionary *)dic;
@end
