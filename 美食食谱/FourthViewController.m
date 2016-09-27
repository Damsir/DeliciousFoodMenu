//
//  FourthViewController.m
//  食客天下
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)Ppmodel *model;
@property (weak, nonatomic) IBOutlet UITableView *ppTableView;
@property (nonatomic,strong)NSMutableArray *cellArray;
@property(nonatomic,strong)UIImageView *tookOutImage;


@end

@implementation FourthViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=NO;
}
static int page=1;
- (void)viewDidLoad {
self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
    _cellArray =[NSMutableArray array];
    [super viewDidLoad];
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

-(void)loadDataByNet
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [self.view showJUHUAWithBool:YES];
    [manager GET:[NSString stringWithFormat:HTTP_PP,page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
        _model=[[Ppmodel alloc] mj_setKeyValues:operation.responseString];
        for (NSDictionary *dic in _model.brand_list)
        {
            [_cellArray addObject:dic];
        }
       
         [_ppTableView reloadData];
        [_ppTableView.header endRefreshing];
        [_ppTableView.footer endRefreshing];
        [self loadData];
        
        [self.view showJUHUAWithBool:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_ppTableView.header endRefreshing] ;
        [_ppTableView.footer endRefreshing];
    }];
}
-(void)loadData
{
    
    _ppTableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page=1;
        [_cellArray removeAllObjects];
        [self loadDataByNet];
    }];
    _ppTableView.footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page++;
        [self loadDataByNet];
    }];
    
    UINib *nib=[UINib nibWithNibName:@"PpTableViewCell" bundle:nil];
    [_ppTableView registerNib:nib forCellReuseIdentifier:@"PpTableViewCell"]; 
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PpDetailViewController *ppdetail=[[PpDetailViewController alloc] init];
    PpCellModel *cellm=_cellArray[indexPath.row];
    ppdetail.ppModel=cellm;
    [self.navigationController pushViewController:ppdetail animated:YES];
    ppdetail.tabBarController.tabBar.hidden=YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PpTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PpTableViewCell"];
    cell.backgroundColor=[UIColor colorWithWhite:0.900 alpha:1.000];
    if (_cellArray.count>0) {
        PpCellModel *cellm=_cellArray[indexPath.row];
        
        cell.model=cellm;
        [cell setUIwithModel:cell.model];
        UISwipeGestureRecognizer *swip=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDrag:)];
        swip.direction=UISwipeGestureRecognizerDirectionRight;
        [cell.coverImagev addGestureRecognizer:swip];
        cell.selectionStyle=  UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor redColor];

    }
    
    return cell;
}
-(void)swipeDrag:(UISwipeGestureRecognizer *)swip
{
    [UIView animateWithDuration:0.3 animations:^{
        swip.view.frame=CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 180);
    _tookOutImage.frame=CGRectMake(0, 0, SCREEN_WIDTH, 180);
    }];
    _tookOutImage=(UIImageView *)swip.view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000000001;
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
