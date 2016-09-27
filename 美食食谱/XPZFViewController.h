//
//  XPZFViewController.h
//  食客天下
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPpdetailModel.h"
@interface XPZFViewController : UIViewController
@property (nonatomic,strong)ScrollDetilModel *modeol;
@property (nonatomic,strong)NSMutableArray *cellArray;
@property (nonatomic,strong)goodsListModel *model;
@property(nonatomic,strong)NSArray *reciveArray;
@property(nonatomic,strong)listModel *listmodel;
@property(nonatomic,strong)MyPpdetailModel *mydetailModel;
@end
