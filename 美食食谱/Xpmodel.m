//
//  Xpmodel.m
//  食客天下
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Xpmodel.h"

@implementation Xpmodel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"goods_list":@"data.goods_list"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"goods_list":@"goodsListModel"};
}
@end
