//
//  PpDetailViewController.m
//  食客天下
//
//  Created by qianfeng on 15/11/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
//数据刷新后数组出了问题
#import "PpDetailViewController.h"

@interface PpDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)CoverImageView *myView;
@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)NSDictionary *recaiveData;
@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,assign)CGFloat firstCellHight;
@property (nonatomic,assign)CGFloat seconCellHight;
@property (nonatomic,strong)UICollectionView *mycollectionView;
@property (nonatomic,strong)NSMutableArray *goodlistArray;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)PpgoodsListModel *model;
@end

@implementation PpDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
    _page=1;
    _goodlistArray=[NSMutableArray array];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ButtonBack2_Pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    _myView=[[[NSBundle mainBundle] loadNibNamed:@"CoverImageView" owner:nil options:nil] firstObject];
    _myView.frame=CGRectMake(0, 64, SCREEN_WIDTH, 180);
    [self loadData];
    [self loadDataByNet];
    
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
}
-(void)loadDataByNet
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:PpDetailJx,_ppModel.brand_id,_ppModel.brand_id,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"wangye%@",[NSString stringWithFormat:PpDetailJx,_ppModel.brand_id,_ppModel.brand_id,_page]);
        [_myView setImageWithURL:[NSURL URLWithString:_ppModel.brand_figure_image] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
        [self.view addSubview:_myView];
        _myView.backgroundColor=[UIColor redColor];
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"data"][@"goods_list"];
    
        if (arr.count>0) {
        _recaiveData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"data"];
           
        _model=[[PpgoodsListModel alloc] mj_setKeyValues:operation.responseString];
          
        for (NSDictionary *dic in _recaiveData[@"goods_list"])
        {
            
        [_goodlistArray addObject:dic];
        }
        
        [_tab reloadData];
        [_mycollectionView reloadData];
        }
        [_tab.header endRefreshing] ;
        [_tab.footer endRefreshing] ;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        NSLog(@"%@",error.localizedDescription);
        [_tab.header endRefreshing] ;
        [_tab.footer endRefreshing] ;
    }];
}

-(void)loadData
{
    
    _sectionArray =[NSMutableArray array];
    NSString *str=@"0";
    [_sectionArray addObject:str];
      [_sectionArray addObject:str];
    [_sectionArray addObject:str];
    _tab=[[UITableView alloc] initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:_tab];
    _tab.delegate=self;
    _tab.dataSource=self;
    _tab.tableFooterView=[[UIView alloc] init];
   
    //8.0table自适应
//    _tab.estimatedRowHeight=44.0;
//    _tab.rowHeight=UITableViewAutomaticDimension;

    _tab.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page=1;
        [_goodlistArray removeAllObjects];
        [self loadDataByNet];
        
    }];
    _tab.footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _page++;
        [self loadDataByNet];
    }];
    
}
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section<2&&_sectionArray) {
        if ([_sectionArray[section] isEqualToString:@"0"]) {
            return 0;
        }
        else
            return 1;
    }
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"head"];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"head"];
        }
        NSArray *arr=cell.contentView.subviews;
        for (UIView *view in arr) {
            [view removeFromSuperview];
        }
        if (_recaiveData) {
            
   
        UILabel *lab=[[UILabel alloc] init];
         lab.text=_recaiveData[@"brandInfo"][@"brand_desc"];
        lab.font=[UIFont systemFontOfSize:12];
        lab.textColor=[UIColor colorWithWhite:0.600 alpha:1.000];
        CGRect bound=[lab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:12]} context:nil];
        lab.frame=CGRectMake(10, 10, SCREEN_WIDTH-20, bound.size.height);
        lab.numberOfLines=0;
        [cell.contentView addSubview:lab];
        _firstCellHight=bound.size.height+20;
        }
                return cell;
        
    
        
    }
    if (indexPath.section==1) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"pl"];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pl"];
        }
        NSArray *arr=cell.contentView.subviews;
        for (UIView *view in arr) {
            [view removeFromSuperview];
        }
        UILabel *lab=[[UILabel alloc] init];
        if (_recaiveData) {
            
       
        lab.text=_recaiveData[@"brandInfo"][@"buyer_tj"][@"brief"];
        lab.font=[UIFont systemFontOfSize:12];
        lab.textColor=[UIColor colorWithWhite:0.600 alpha:1.000];
        CGRect bound=[lab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:12]} context:nil];
        lab.frame=CGRectMake(10, 10, SCREEN_WIDTH-20, bound.size.height);
        lab.numberOfLines=0;
        [cell.contentView addSubview:lab];
        _seconCellHight=bound.size.height+20;
        }
        return cell;
    }
    if (indexPath.section==2)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"pl"];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pl"];
        }
        NSArray *arr=cell.contentView.subviews;
        for (UIView *view in arr) {
            [view removeFromSuperview];
        }
       
        UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
     
        flowlayout.itemSize=CGSizeMake(SCREEN_WIDTH/2-10, SCREEN_WIDTH/2*1.5);
        flowlayout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
        _mycollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH/2*1.5+10)*(_goodlistArray.count/2+_goodlistArray.count%2)+5+80) collectionViewLayout:flowlayout];
       
        _mycollectionView.delegate=self;
        _mycollectionView.dataSource=self;
        _mycollectionView.backgroundColor=[UIColor colorWithRed:0.049 green:1.000 blue:0.110 alpha:1.000];
        [_mycollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//        _mycollectionView.scrollEnabled=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
        
        
        UINib *nib=[UINib nibWithNibName:@"XpCollectionViewCell" bundle:nil];
        [_mycollectionView registerNib:nib forCellWithReuseIdentifier:@"XpCollectionViewCell"];
        [cell.contentView addSubview:_mycollectionView];
        return cell;
    }
    return [[UITableViewCell alloc] init];
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIView *view=[[UIView alloc] init];
        
        
        UIImageView *imageviw=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [imageviw setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:LOGOIN_URLSTR,_ppModel.brand_logo]] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
        imageviw.layer.cornerRadius=20;
        
        imageviw.layer.masksToBounds=YES;
        UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 20)];
    
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        [view1 addSubview:lab];
        lab.alpha=0.1;
        view1.alpha=0.1;
        if (_recaiveData) {
        lab.text=_recaiveData[@"brandInfo"][@"brand_position"];
        }
        lab.textAlignment=NSTextAlignmentCenter;
        [_myView addSubview:view1];
        [view addSubview:imageviw];
        
        UIImageView *iv1=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 25, 15, 15)];
       
        imageviw.layer.borderWidth=2.0;
        
        imageviw.layer.borderColor=[[UIColor grayColor] CGColor];
        
        [iv1 setImage:[UIImage imageNamed:@"ui_arrow_bottom"]];
        
        iv1.transform=CGAffineTransformRotate(iv1.transform, -M_PI_2);
        
        [view addSubview:iv1];
        UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5)];
        view2.backgroundColor=[UIColor grayColor];
        [view addSubview:view2];
        
        if (_recaiveData)
        {
            UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, 120, 20)];
            lab1.font=[UIFont systemFontOfSize:15];
            lab1.textColor=[UIColor grayColor];
            lab1.text=_recaiveData[@"brandInfo"][@"site_url"];
            [view addSubview:lab1];
            UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(60, 30, 120, 20)];
            lab2.text=_recaiveData[@"brandInfo"][@"brand_name"];
            [view addSubview:lab2];
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapclick:)];
        [view addGestureRecognizer:tap];
        
        view.tag=0;
        view.userInteractionEnabled=YES;
        self.view.userInteractionEnabled=YES;
        
        return view;
    }
    else if(section==1)
    {
        UIView *view=[[UIView alloc] init];
     
        UIImageView *imageviw=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        if (_recaiveData)
        {
        [imageviw setImageWithURL:[NSURL URLWithString:_recaiveData[@"brandInfo"][@"buyer_tj"][@"img"]] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
        }
        imageviw.layer.cornerRadius=20;
        
        imageviw.layer.masksToBounds=YES;
       
        [view addSubview:imageviw];
        
        UIImageView *iv1=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 25, 15, 15)];
        
        imageviw.layer.borderWidth=2.0;
        
        imageviw.layer.borderColor=[[UIColor grayColor] CGColor];
        
        [iv1 setImage:[UIImage imageNamed:@"ui_arrow_bottom"]];
        
        iv1.transform=CGAffineTransformRotate(iv1.transform, -M_PI_2);
        
        [view addSubview:iv1];
        
        
        if (_recaiveData)
        {
           
            UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(60, 30, 120, 20)];
            lab2.text=_recaiveData[@"brandInfo"][@"buyer_tj"][@"uname"];
            [view addSubview:lab2];
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapclick:)];
        [view addGestureRecognizer:tap];
        
        view.tag=1;
        view.userInteractionEnabled=YES;
        self.view.userInteractionEnabled=YES;
        
        return view;

    }
   else if(section==2)
   {
       UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
       view1.backgroundColor=[UIColor grayColor];
       UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
   
       UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 25, 80, 30)];
       lab.text=@"明星款式";
       lab.textColor=[UIColor grayColor];
       lab.textAlignment=NSTextAlignmentCenter;
       [view addSubview:lab];
       [view addSubview:view1];
       return view;
   }
        else
        return [[UIView alloc] init];
}

-(void)tapclick:(UITapGestureRecognizer *)tap
{
   
    UIView *view = tap.view;
  
    NSString *str = _sectionArray[view.tag];

    if ([str isEqualToString:@"1"])
    {
        [_sectionArray replaceObjectAtIndex:view.tag withObject:@"0"];
    }
    else
    {
        [_sectionArray replaceObjectAtIndex:view.tag withObject:@"1"];
    }
    
    [_tab reloadData];

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0||section==1) {
         return 60.0;
    }
    
    else
        return 80.0;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section==0)
    {
            return  _firstCellHight;
    }
    
        else if(indexPath.section==1)
        {
          
        return  _seconCellHight;
  
        }
      else
      {
          return (SCREEN_WIDTH/2*1.5+10)*(_goodlistArray.count/2+_goodlistArray.count%2)+5+80;
      }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"_goodist%ld",_goodlistArray.count);
    return _goodlistArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XpCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"XpCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    if (_recaiveData) {
        
        if (_goodlistArray)
        {

    [cell.imageView setImageWithURL:[NSURL URLWithString:_goodlistArray[indexPath.row][@"list_url"]] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
    cell.titleLable.text=[NSString stringWithFormat:@"[%@/%@]%@",_goodlistArray[indexPath.row][@"brand_title"],_goodlistArray[indexPath.row][@"site_url"],_goodlistArray[indexPath.row][@"goods_title"]];
    cell.priceLable.text=[NSString stringWithFormat:@"¥%@",_goodlistArray[indexPath.row][@"shop_price"]];

            [cell.addLoveImage setImage:[UIImage imageNamed:@"icon_favorite"]];
            NSInteger iter=[_goodlistArray[indexPath.row][@"praise"] integerValue];
            cell.numOfLove.text=[NSString stringWithFormat:@"%ld",iter];
         }
         }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XPZFViewController *xpzvc=[[XPZFViewController alloc] init];
    [self.navigationController pushViewController:xpzvc animated:YES];
    MyPpdetailModel *ppdetailmodel= _model.goods_list[indexPath.row];
    NSLog(@"list_url:%@",ppdetailmodel.list_url);
    xpzvc.mydetailModel=ppdetailmodel;
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
