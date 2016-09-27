//
//  SecondViewController.m
//  食客天下
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.

#import "SecondViewController.h"

@interface SecondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation SecondViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    _cellArray =[NSMutableArray array];
     _myCollectionView.backgroundColor=[UIColor grayColor];
      [self loadData];
    [self loadDataByNet];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithImage:[UIImage resizableImage:@"icon_good_car1"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMygoodsCar)];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bbs_ask_search"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoSearch)];
    self.navigationItem.rightBarButtonItems=@[item1,item2];
}
-(void)gotoMygoodsCar
{
    ShoppingViewController *shopping=[[ShoppingViewController alloc] init];
    [self.navigationController pushViewController:shopping animated:YES];
}
-(void)gotoSearch
{
    SearchViewController *searchV=[[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchV animated:YES];
    
}

static int page=1;
-(void)loadDataByNet
{
  
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [self.view showJUHUAWithBool:YES];
    [manager GET:[NSString stringWithFormat:HTTP_NEW,page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"%@",operation.responseString);
        _model=[[Xpmodel alloc] mj_setKeyValues:operation.responseString];

        for (NSDictionary *dic in _model.goods_list)
        {
           
        [_cellArray addObject:dic];
        }
      
        [_myCollectionView.header endRefreshing] ;
        [_myCollectionView.footer endRefreshing] ;
        [_myCollectionView reloadData];
        [self.view showJUHUAWithBool:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
  
//        [_myCollectionView.header endRefreshing] ;
//        [_myCollectionView.footer endRefreshing] ;
    }];
    
    
}
-(void)loadData
{
    
    _myCollectionView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page=1;
        [_cellArray removeAllObjects];
        [self loadDataByNet];
    }];
    _myCollectionView.footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page++;
        [self loadDataByNet];
    }];
    UINib *nib=[UINib nibWithNibName:@"XpCollectionViewCell" bundle:nil];
    [_myCollectionView registerNib:nib forCellWithReuseIdentifier:@"XpCollectionViewCell"];
}
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cellArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XpCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"XpCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
   goodsListModel *model=_cellArray[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.list_url] placeholderImage:[UIImage imageNamed:@"area_default_pic"]];
    cell.titleLable.text=[NSString stringWithFormat:@"[%@/%@]%@",model.brand_name,model.site_url,model.goods_title];
    cell.priceLable.text=[NSString stringWithFormat:@"￥%@",model.shop_price];
    cell.priceLable.textColor=[UIColor redColor];
    [cell.addLoveImage setImage:[UIImage imageNamed:@"icon_favorite"]];
    cell.numOfLove.text=[NSString stringWithFormat:@"%@",model.praise];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XPZFViewController *xpzf=[[XPZFViewController alloc] init];
    goodsListModel *model=_cellArray[indexPath.row];
    xpzf.model=model;
    
    [self.navigationController pushViewController:xpzf animated:YES];
    
}
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2-10, 240);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
