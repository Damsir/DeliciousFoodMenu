//
//  XPxqmodel.m
//  食客天下
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XPxqmodel.h"
#import "goodsListModel.h"
@implementation XPxqmodel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    goodsListModel *model=[[goodsListModel alloc] init];
    NSString *data1=[NSString stringWithFormat:@"data.%@",model.goods_id];
    
    return @{@"coler":data1};
}
@end
