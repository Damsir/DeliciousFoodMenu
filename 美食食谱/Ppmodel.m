//
//  Ppmodel.m
//  食客天下
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Ppmodel.h"

@implementation Ppmodel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"brand_list":@"data.brand_list"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"brand_list":@"PpCellModel"};
}
@end
