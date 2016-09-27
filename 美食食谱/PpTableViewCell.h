//
//  PpTableViewCell.h
//  食客天下
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverImageView.h"
@interface PpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Ppiv1;
@property (weak, nonatomic) IBOutlet UIImageView *Ppiv2;
@property (weak, nonatomic) IBOutlet UIImageView *Ppiv3;
@property (weak, nonatomic) IBOutlet UIImageView *Ppiv4;
@property (weak, nonatomic) IBOutlet UIImageView *logView;
@property (weak, nonatomic) IBOutlet UILabel *descripT;
@property (nonatomic,strong)CoverImageView *coverImagev;

@property (nonatomic,strong)id model;

- (void)setUIwithModel:(id)model;


@end
