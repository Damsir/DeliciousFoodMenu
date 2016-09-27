//
//  ScrollViewController.h
//  食客天下
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollDetilModel.h"
@interface ScrollViewController : UIViewController
@property (nonatomic,strong)ScrollDetilModel *modeol;
@property (nonatomic,strong)NSMutableArray *cellArray;
@property (nonatomic,strong)Scrollmodel *model;
@end
