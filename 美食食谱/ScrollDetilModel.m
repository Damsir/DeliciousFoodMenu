//
//  ScrollDetilModel.m
//  食客天下
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ScrollDetilModel.h"

@implementation ScrollDetilModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"list":@"result.list.list"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"list":@"listModel"};
}
@end
