//
//  EnterViewController.h
//  食客天下
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BasicViewController.h"

@interface EnterViewController : BasicViewController
@property (nonatomic,copy)void (^backBlock)(NSDictionary *dic);
@end
