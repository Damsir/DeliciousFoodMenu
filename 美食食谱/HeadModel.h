//
//  HeadModel.h
//  食客天下
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadModel : NSObject
@property (nonatomic,assign)NSInteger code;
@property (nonatomic,copy)NSString *message;
@property (nonatomic,strong)NSArray *data;
@property (nonatomic,strong)NSArray *list;

@end
