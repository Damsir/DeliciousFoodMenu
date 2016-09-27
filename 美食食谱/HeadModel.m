//
//  HeadModel.m
//  食客天下
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HeadModel.h"

@implementation HeadModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"list":@"data[0].list"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"list":@"Scrollmodel",@"data":@"CellModel"};
}
@end
