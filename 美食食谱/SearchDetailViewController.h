//
//  SearchDetailViewController.h
//  食客天下
//
//  Created by qianfeng on 15/12/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchDetailViewController : UIViewController
@property (nonatomic,strong)NSString *searchText;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic,strong)Xpmodel *model;
@property (nonatomic,strong)NSMutableArray *cellArray;
@property (nonatomic,strong)UISearchBar *search;
@end
