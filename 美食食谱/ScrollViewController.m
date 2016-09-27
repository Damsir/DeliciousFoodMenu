//
//  ScrollViewController.m
//  食客天下
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *mycllectionv;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonBack2_Normal"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    _cellArray=[NSMutableArray array];
    _mycllectionv.delegate=self;
    _mycllectionv.dataSource=self;
    self.tabBarController.tabBar.hidden=YES;
     [self loadData];
    [self loadDataByNet];
   
}
-(void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
//    self.tabBarController.tabBar.hidden=NO;
}
-(void)loadDataByNet
{
    [self.view showJUHUAWithBool:YES];
//    __weak typeof (*&self) weakself=self;
  
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
     self.navigationItem.title=_model.Description;
    [manager GET:[NSString stringWithFormat:SCROLL_VI,_model.ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"%@",operation.responseString);
        
        _modeol=[[ScrollDetilModel alloc] mj_setKeyValues:operation.responseString];
       
        for (NSDictionary *dic in self.modeol.list)
        {
            [self.cellArray addObject:dic];
        }

        [self.mycllectionv.header endRefreshing] ;
        [self.mycllectionv.footer endRefreshing] ;
        [_mycllectionv reloadData];
        [self.view showJUHUAWithBool:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.mycllectionv.header endRefreshing] ;
        [self.mycllectionv.footer endRefreshing] ;
    }];
    
    
}
-(void)loadData
{
    _mycllectionv.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_cellArray removeAllObjects];
        [self loadDataByNet];
    }];
    _mycllectionv.footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [self loadDataByNet];
    }];
    UINib *nib=[UINib nibWithNibName:@"XpCollectionViewCell" bundle:nil];
   [_mycllectionv registerNib:nib forCellWithReuseIdentifier:@"XpCollectionViewCell"];
}
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _cellArray.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XPZFViewController *viewc=[[XPZFViewController alloc] init];
   listModel *model=_cellArray[indexPath.row];
 
    viewc.listmodel=model;
    [self.navigationController pushViewController:viewc animated:YES];
    
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XpCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"XpCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor whiteColor];
    listModel *model=_cellArray[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.list_url] placeholderImage:[UIImage imageNamed:@"area_default_pic"]];
    NSLog(@"xsxxsxsxs%@",model.list_url);
    cell.titleLable.text=[NSString stringWithFormat:@"[%@/%@]%@",model.brand_name,model.site_url,model.goods_title];
    cell.priceLable.text=[NSString stringWithFormat:@"￥%@",model.shop_price];
    cell.priceLable.textColor=[UIColor redColor];
    [cell.addLoveImage setImage:[UIImage imageNamed:@"icon_favorite"]];
    cell.numOfLove.text=[NSString stringWithFormat:@"%@",model.praise];
    return cell;
}
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 240);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 15, 10, 15);
    
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
