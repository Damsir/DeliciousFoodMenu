//
//  ViewController.m
//  美食食谱
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "MyPrefix.pch"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong)HeadModel *model;

@property (weak, nonatomic) IBOutlet UITableView *findTableView;
@property (nonatomic,strong)NSMutableArray *cellArray;
@property (nonatomic,strong)NSArray *headTitle;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong) UIScrollView * scrollv;
@property (nonatomic,strong)NSArray *contentModel;
@property (nonatomic,assign)NSInteger index;
@end

@implementation ViewController
static int page=1;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=NO;
    if (!_timer)
    {
        _timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_timer invalidate];
    _timer=nil;
}
- (void)viewDidLoad {
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
    self.tabBarController.tabBar.hidden=NO;
    _cellArray =[NSMutableArray array];
    NSString *str=@"1231";
    NSInteger a=[str integerValue];
    NSLog(@"%ld",a);
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
    [manager GET:[NSString stringWithFormat:HTTP_FIND,page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"%@",operation.responseString);
        _model=[[HeadModel alloc] mj_setKeyValues:operation.responseString];
        for (NSDictionary *dic in _model.data)
        {
            [_cellArray addObject:dic];
        }
        [_cellArray removeObjectAtIndex:0];
      
        [_findTableView reloadData];
     
        [_findTableView.header endRefreshing] ;
        [_findTableView.footer endRefreshing] ;
          [self loadData];
        [self.view showJUHUAWithBool:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_findTableView.header endRefreshing] ;
        [_findTableView.footer endRefreshing] ;
    }];
    
}
-(void)loadData
{
   _scrollv=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _scrollv.delegate=self;
    _scrollv.contentSize=CGSizeMake(SCREEN_WIDTH*_model.list.count, 0);

    for (int i=0;i<_model.list.count;i++)
    {
        
            Scrollmodel *scroll=_model.list[i];
            UIImageView *imagv=[[UIImageView alloc] initWithFrame:CGRectMake(0+i*self.view.bounds.size.width, 0, SCREEN_WIDTH, 200)];
            [imagv setImageWithURL:[NSURL URLWithString:scroll.img_url]];
            
            imagv.tag=i+100;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [imagv addGestureRecognizer:tap];
            [_scrollv addSubview:imagv];
            _scrollv.pagingEnabled=YES;
            _scrollv.showsHorizontalScrollIndicator=NO;
            imagv.userInteractionEnabled=YES;
            NSLog(@"%d",i);
            
 
    }
    _scrollv.contentOffset=CGPointMake(0, 0);
    _findTableView.tableHeaderView=_scrollv;

    _findTableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page=1;
        [_cellArray removeAllObjects];
        [self loadDataByNet];
    }];
    _findTableView.footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page++;
        [self loadDataByNet];
    }];

    UINib *nib=[UINib nibWithNibName:@"SyTableViewCell" bundle:nil];
    [_findTableView registerNib:nib forCellReuseIdentifier:@"SyTableViewCell"];
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    WebViewController *webc=[[WebViewController alloc] init];
    UIWebView *web=[[UIWebView alloc] initWithFrame:self.view.bounds];
    CellModel *model=_cellArray[indexPath.row];
    if ([model.cache_time isEqualToString:@"0"]) {
         NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:SY_CELL,model.link_url]];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [web loadRequest:request];
        [webc.view addSubview:web];
        [self.navigationController pushViewController:webc animated:YES];
    }
    
    else
    {
        NSURL *url=[NSURL URLWithString:model.link_url];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [web loadRequest:request];
        [webc.view addSubview:web];
        [self.navigationController pushViewController:webc animated:YES];
    }
   
    
 
    
}
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    WebViewController *webv=[[WebViewController alloc] init];
    UIWebView *web=[[UIWebView alloc] initWithFrame:self.view.bounds];
    
        Scrollmodel *model=_model.list[tap.view.tag-100];
   

  
    if ([model.type isEqualToString:@"6"])
    {
        
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:model.link_url]];
        NSLog(@"%@",model.link_url);
        [web loadRequest:request];
        [self.navigationController pushViewController:webv animated:YES];
        [webv.view addSubview:web];
    }
    else
    {
        ScrollViewController *scv=[[ScrollViewController alloc] init];
        scv.model=model;
        [self.navigationController pushViewController:scv animated:YES];
        
    }
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SyTableViewCell"];
    
    CellModel *cellm=_cellArray[indexPath.row];
    NSURL *urlstr=[NSURL URLWithString:cellm.img_url];
    NSDictionary *dic=@{@"url":urlstr};
    [cell setUIWithdic:dic];

    cell.selectionStyle=  UITableViewCellSelectionStyleNone;
    cell.Sytabcell.userInteractionEnabled=YES;
    cell.backgroundColor=[UIColor redColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240.0;
}
-(void)timerRun
{
    CGPoint point=_scrollv.contentOffset;
    CATransition *transition=[CATransition animation];
    transition.duration=4.9;
    transition.type=@"rippleEffect";
    transition.subtype=kCATransitionFromRight;
    [_scrollv.layer addAnimation:transition forKey:@"animation"];
    if (point.x==(_model.list.count -1)*SCREEN_WIDTH)
    {
        NSLog(@"12312");
        _scrollv.contentOffset=CGPointMake(-SCREEN_WIDTH, 0);
        point.x=_scrollv.contentOffset.x;
    }
    _scrollv.contentOffset=CGPointMake(point.x+SCREEN_WIDTH, 0);
  
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
