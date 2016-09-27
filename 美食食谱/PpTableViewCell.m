//
//  PpTableViewCell.m
//  食客天下
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PpTableViewCell.h"

@implementation PpTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setUIwithModel:(id)model
{
    if ([[self.contentView.subviews.lastObject class] isSubclassOfClass:[UIImageView class]]) {
        UIImageView *imageview=self.contentView.subviews.lastObject;
        NSLog(@"%@",[self.contentView.subviews.lastObject class]);
        [imageview removeFromSuperview];
    }
     PpCellModel *cellm=model;
    _coverImagev =[[[NSBundle mainBundle] loadNibNamed:@"CoverImageView" owner:nil options:nil] firstObject];
    _coverImagev.frame=CGRectMake(0, 0, SCREEN_WIDTH, 180);
    [_coverImagev setImageWithURL:[NSURL URLWithString:cellm.brand_figure_image] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
    
    _coverImagev.name.text=cellm.brand_name;
    _coverImagev.name.textColor=[UIColor orangeColor];
    _coverImagev.name.font=[UIFont boldSystemFontOfSize:20];
    _coverImagev.descrip.text=cellm.cate;
    _coverImagev.descrip.textColor=[UIColor orangeColor];
    [_coverImagev.location setImage:[UIImage imageNamed:@"dtz2"]];
    _coverImagev.country.text=cellm.site_url2;
    _coverImagev.country.textColor=[UIColor orangeColor];
    [_Ppiv1 setImageWithURL:[NSURL URLWithString:cellm.app_show_img_1] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
    [_Ppiv2 setImageWithURL:[NSURL URLWithString:cellm.app_show_img_2] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
    
    [_Ppiv3 setImageWithURL:[NSURL URLWithString:cellm.app_show_img_3] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
    
    [_Ppiv4 setImageWithURL:[NSURL URLWithString:cellm.app_show_img_4] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
    
    [_logView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:LOGOIN_URLSTR,cellm.brand_logo]] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
    _logView.layer.cornerRadius=30;
    _logView.layer.masksToBounds=YES;
    NSLog(@"%@",[NSString stringWithFormat:LOGOIN_URLSTR,cellm.brand_logo]);
    _descripT.text=cellm.cate;
    for (int i=0;i<cellm.brand_style.count;i++)
    {
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(82+i*80,140 , 70, 20)];
        lab.backgroundColor=[UIColor redColor];
        lab.textColor=[UIColor whiteColor];
        lab.font=[UIFont systemFontOfSize:15];
        lab.text=cellm.brand_style[i];
        lab.layer.cornerRadius=5;
        lab.layer.masksToBounds=YES;
        lab.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:lab];
    }
    [self.contentView addSubview:_coverImagev];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
