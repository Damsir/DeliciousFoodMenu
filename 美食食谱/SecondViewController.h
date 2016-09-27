//
//  SecondViewController.h
//  食客天下
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BasicViewController.h"

@interface SecondViewController : BasicViewController

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic,strong)Xpmodel *model;
@property (nonatomic,strong)NSMutableArray *cellArray;
@property (nonatomic,strong)NSString *searchText;
@end
