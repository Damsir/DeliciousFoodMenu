//
//  listModel.m
//  食客天下
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "listModel.h"

@implementation listModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",@"goods_title":@"goods_name",@"list_url":@"list_pic"};
}
@end
