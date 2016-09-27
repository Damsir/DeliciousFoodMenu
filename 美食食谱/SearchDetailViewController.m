//
//  SearchDetailViewController.m
//  食客天下
//
//  Created by qianfeng on 15/12/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchDetailViewController.h"

@interface SearchDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>


@end

@implementation SearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
    _search=[[UISearchBar alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-50)/2, 7, 50, 30)];
    _search.delegate=self;
    self.navigationItem.titleView=_search;
    _search.showsCancelButton=YES;
    //    _search.showsBookmarkButton=YES;
    _search.searchBarStyle= UIBarStyleBlackOpaque;
    _search.returnKeyType = UIReturnKeySearch;
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _cellArray =[NSMutableArray array];
    _myCollectionView.backgroundColor=[UIColor grayColor];
    _myCollectionView.delegate=self;
    _myCollectionView.dataSource=self;
    [self loadData];
    [self loadDataByNet];
    _search.text=_searchText;
}
static int page=1;
-(void)loadDataByNet
{
    NSString *str=_searchText;
  
    str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [self.view showJUHUAWithBool:YES];
    [manager GET:[NSString stringWithFormat:Search,str,page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        
                [_myCollectionView.header endRefreshing] ;
                [_myCollectionView.footer endRefreshing] ;
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
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=nil;
    _searchText=nil;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _searchText=searchBar.text;
    _cellArray =[NSMutableArray array];
    [self loadDataByNet];
    
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
