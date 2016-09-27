//
//  PpgoodsListModel.m
//  食客天下
//
//  Created by qianfeng on 15/12/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PpgoodsListModel.h"

@implementation PpgoodsListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"goods_list":@"data.goods_list"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"goods_list":@"MyPpdetailModel"};
}
@end
