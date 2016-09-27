//
//  XPZFViewController.m
//  食客天下
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//


#import "XPZFViewController.h"
#import "MyPrefix.pch"
@interface XPZFViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSInteger contentY;
    CGFloat  lastFloat;
    CGFloat  lastWidth;
    
}
@property (weak, nonatomic) IBOutlet UITableView *myTab;
@property (nonatomic,strong)NSMutableArray *colerArray;
@property(nonatomic,strong)NSMutableArray * cmArray;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)UIScrollView *scrollv;
@property (nonatomic,strong)NSDictionary *reciveData;
@property (nonatomic,strong)UIPageControl *page;
@property (nonatomic,strong)UIView *myView;
@property (nonatomic,assign)NSInteger descripH;
@property(nonatomic,strong) UIImageView *imgView;
@property (nonatomic,assign)NSInteger cellHight;
@property (nonatomic,strong)NSArray *spdw;
@property (nonatomic,strong)NSArray *spgg;
@property (nonatomic,assign)NSInteger spggCellHight;
@property (nonatomic,strong)UIButton *selectedBtn;
@property (nonatomic,strong)NSMutableArray *keysArray;
@property (nonatomic,strong)NSArray *colerKeys;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UIButton *storeBtn;
@property (nonatomic,assign)NSInteger pastNum;
@property (nonatomic,assign)NSInteger num;
@end

@implementation XPZFViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
    _num=0;
    _pastNum=0;
    for (NSDictionary *dic in [[DBManager sharedDBManager] recieveDBData])
    {
        NSInteger inter=[dic[@"contentNum"] integerValue];
        _pastNum+=inter;
    }
    [_storeBtn setTitle:[NSString stringWithFormat:@"%ld",_pastNum+_num] forState:UIControlStateNormal];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
    
    self.tabBarController.tabBar.hidden=YES;
  
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ButtonBack2_Pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.translucent=YES;
    _colerArray =[NSMutableArray array];
    _cmArray=[NSMutableArray array];
    _dataArray=[NSMutableArray array];
    _goods_id=[NSString string];
    [self loadData];
    [self loadDataByNet];
    _myTab.delegate=self;
    _myTab.dataSource=self;
    _myTab.backgroundColor=[UIColor colorWithWhite:0.800 alpha:1.000];
    _myView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    _myView.backgroundColor=[UIColor orangeColor];
    _myView.userInteractionEnabled=YES;
    _myView.userInteractionEnabled=YES;
    
    lastFloat=0;
    lastWidth=0;
    contentY=0;
}
-(void)back
{
//    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadDataByNet
{
    [self.view showJUHUAWithBool:YES];
    //    __weak typeof (*&self) weakself=self;
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    if (_model) {
        self.navigationItem.title=_model.goods_name;
        [manager GET:[NSString stringWithFormat:XPZF,_model.goods_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            NSDictionary *reciveData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"data"];
            _reciveData=reciveData;
            [self.view showJUHUAWithBool:NO];
           _colerKeys=[reciveData[@"color"] allKeys];
            _goods_id=[_colerKeys firstObject];
            [_colerArray addObject:_reciveData[@"color"][_goods_id][@"color_name"]];
            _keysArray=[NSMutableArray array];
            for (NSString *str in _colerKeys)
            {
                [_keysArray addObject:str];
                
            }
            
            [ _cmArray addObject:[_reciveData[@"color"][_goods_id][@"sku"] firstObject][@"size"]];
            if (_keysArray.count>1) {
                for (int i=1; i<_colerKeys.count-1; i++) {
                    
                    [ _colerArray addObject:_reciveData[@"color"][_keysArray[i]][@"color_name"]];
                    
                }
            }
            
            if (_colerKeys.count>0) {
                
                
                _scrollv.contentSize=CGSizeMake(SCREEN_WIDTH*[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count], 300);
                
                _scrollv.bounces=NO;
                _scrollv.pagingEnabled=YES;
                
                for (int i=0; i<[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count]; i++)
                {
                    UIImageView *imagv=[[UIImageView alloc] initWithFrame:CGRectMake(0+i*SCREEN_WIDTH, 0,SCREEN_WIDTH , 300)];
                    NSLog(@"%@",[_reciveData[@"color"] objectForKey:_goods_id]);
                    [imagv setImageWithURL:[NSURL URLWithString:[_reciveData[@"color"]objectForKey:_goods_id][@"img"][i]]placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
                    [_scrollv addSubview:imagv];
                    
                }
            }
            _page=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH, 10)];
            _page.numberOfPages=[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count];
            
            _page.pageIndicatorTintColor=[UIColor blueColor];
            _page.currentPageIndicatorTintColor=[UIColor orangeColor];
            [_myView addSubview:_scrollv];
            [_myView addSubview:_page];
            _myTab.tableHeaderView=_myView;
            [_myTab reloadData];
            UIView *toolBarView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT-49, SCREEN_WIDTH, 49)];
            toolBarView.backgroundColor=[UIColor colorWithWhite:0.850 alpha:1.000];
            [self.view addSubview:toolBarView];
            [self.view bringSubviewToFront:toolBarView];
    
            _btn =[[UIButton alloc] initWithFrame:CGRectMake(10.0,4.5,40,40)];
            [_btn setBackgroundImage:[UIImage imageNamed:@"icon_good_car"] forState:UIControlStateNormal];
            [_btn addTarget:self action:@selector(collectionstore:) forControlEvents:UIControlEventTouchUpInside];
            [toolBarView addSubview:_btn];
            UIButton *btn1=[[UIButton alloc] init ];
            btn1.frame=CGRectMake(SCREEN_WIDTH-100-10,4.5 ,100, 40);
            UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn2.frame=CGRectMake(SCREEN_WIDTH-(100+10)*2, 4.5 ,100, 40);
            [btn1 setTitle:@"立即购买" forState:UIControlStateNormal];
            [btn2 setTitle:@"加入购物袋" forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn1.backgroundColor=[UIColor redColor];
            btn2.backgroundColor=[UIColor orangeColor];
            btn1.layer.cornerRadius=2;
            btn2.layer.cornerRadius=2;
            btn1.layer.masksToBounds=YES;
            btn2.layer.masksToBounds=YES;
            [toolBarView addSubview:btn1];
            [toolBarView addSubview:btn2];
            btn1.tag=1;
            btn2.tag=2;
            [btn1 addTarget:self action:@selector(toolbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn2 addTarget:self action:@selector(toolbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
             _storeBtn=[[UIButton alloc] initWithFrame:CGRectMake(35, 4.5, 20, 20)];
             _storeBtn.backgroundColor=[UIColor redColor];
             _storeBtn.userInteractionEnabled=NO;
             [_storeBtn setTitle:[NSString stringWithFormat:@"%ld",_pastNum+_num] forState:UIControlStateNormal];
             _storeBtn.titleLabel.font=[UIFont systemFontOfSize:10];
             _storeBtn.layer.cornerRadius=10;
             _storeBtn.layer.masksToBounds=YES;
             [toolBarView addSubview:_storeBtn];
              [self storeBtnIshiden];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }
    else if( _listmodel)
    {
        self.navigationItem.title=_listmodel.goods_title;
        [manager GET:[NSString stringWithFormat:XPZF,_listmodel.goods_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *reciveData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"data"];
            _reciveData=reciveData;
            [self.view showJUHUAWithBool:NO];
            _colerKeys=[reciveData[@"color"] allKeys];
            _goods_id=[_colerKeys firstObject];
            [_colerArray addObject:_reciveData[@"color"][_goods_id][@"color_name"]];
            _keysArray=[NSMutableArray array];
            for (NSString *str in _colerKeys)
            {
                [_keysArray addObject:str];
                
            }
            
            [ _cmArray addObject:[_reciveData[@"color"][_goods_id][@"sku"] firstObject][@"size"]];
            if (_keysArray.count>1) {
                for (int i=1; i<_colerKeys.count-1; i++) {
                    
                    [ _colerArray addObject:_reciveData[@"color"][_keysArray[i]][@"color_name"]];
                    
                }
            }
            
            if (_colerKeys.count>0) {
                
                
                _scrollv.contentSize=CGSizeMake(SCREEN_WIDTH*[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count], 300);
                
                _scrollv.bounces=NO;
                _scrollv.pagingEnabled=YES;
                
                for (int i=0; i<[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count]; i++)
                {
                    UIImageView *imagv=[[UIImageView alloc] initWithFrame:CGRectMake(0+i*SCREEN_WIDTH, 0,SCREEN_WIDTH , 300)];
                    NSLog(@"%@",[_reciveData[@"color"] objectForKey:_goods_id]);
                    [imagv setImageWithURL:[NSURL URLWithString:[_reciveData[@"color"]objectForKey:_goods_id][@"img"][i]]placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
                    [_scrollv addSubview:imagv];
                    
                }
            }
            _page=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH, 10)];
            _page.numberOfPages=[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count];
            
            _page.pageIndicatorTintColor=[UIColor blueColor];
            _page.currentPageIndicatorTintColor=[UIColor orangeColor];
            [_myView addSubview:_scrollv];
            [_myView addSubview:_page];
            _myTab.tableHeaderView=_myView;
            [_myTab reloadData];
            UIView *toolBarView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT-49, SCREEN_WIDTH, 49)];
            toolBarView.backgroundColor=[UIColor colorWithWhite:0.850 alpha:1.000];
            [self.view addSubview:toolBarView];
            [self.view bringSubviewToFront:toolBarView];
           
            UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(10.0,4.5,40,40)];
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_good_car"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(collectionstore:) forControlEvents:UIControlEventTouchUpInside];
            [toolBarView addSubview:btn];
            UIButton *btn1=[[UIButton alloc] init ];
            btn1.frame=CGRectMake(SCREEN_WIDTH-100-10,4.5 ,100, 40);
            UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn2.frame=CGRectMake(SCREEN_WIDTH-(100+10)*2, 4.5 ,100, 40);
            [btn1 setTitle:@"立即购买" forState:UIControlStateNormal];
            [btn2 setTitle:@"加入购物袋" forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn1.backgroundColor=[UIColor redColor];
            btn2.backgroundColor=[UIColor orangeColor];
            btn1.layer.cornerRadius=2;
            btn2.layer.cornerRadius=2;
            btn1.layer.masksToBounds=YES;
            btn2.layer.masksToBounds=YES;
            [toolBarView addSubview:btn1];
            [toolBarView addSubview:btn2];
            btn1.tag=1;
            btn2.tag=2;
            [btn1 addTarget:self action:@selector(toolbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn2 addTarget:self action:@selector(toolbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            _storeBtn=[[UIButton alloc] initWithFrame:CGRectMake(35, 4.5, 20, 20)];
            _storeBtn.backgroundColor=[UIColor redColor];
            _storeBtn.userInteractionEnabled=NO;
            [_storeBtn setTitle:[NSString stringWithFormat:@"%ld",_pastNum+_num] forState:UIControlStateNormal];
            _storeBtn.titleLabel.font=[UIFont systemFontOfSize:10];
            _storeBtn.layer.cornerRadius=10;
            _storeBtn.layer.masksToBounds=YES;
            [toolBarView addSubview:_storeBtn];
            [self storeBtnIshiden];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        

    }
    else if(_mydetailModel)
    {
        self.navigationItem.title=_listmodel.goods_title;
        [manager GET:[NSString stringWithFormat:XPZF,_mydetailModel.goods_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *reciveData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"data"];
            _reciveData=reciveData;
            [self.view showJUHUAWithBool:NO];
            _colerKeys=[reciveData[@"color"] allKeys];
            _goods_id=[_colerKeys firstObject];
            [_colerArray addObject:_reciveData[@"color"][_goods_id][@"color_name"]];
            _keysArray=[NSMutableArray array];
            for (NSString *str in _colerKeys)
            {
                [_keysArray addObject:str];
                
            }
            
            [ _cmArray addObject:[_reciveData[@"color"][_goods_id][@"sku"] firstObject][@"size"]];
            if (_keysArray.count>1) {
                for (int i=1; i<_colerKeys.count-1; i++) {
                    
                    [ _colerArray addObject:_reciveData[@"color"][_keysArray[i]][@"color_name"]];
                    
                }
            }
            
            if (_colerKeys.count>0) {
                
                
                _scrollv.contentSize=CGSizeMake(SCREEN_WIDTH*[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count], 300);
                
                _scrollv.bounces=NO;
                _scrollv.pagingEnabled=YES;
                
                for (int i=0; i<[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count]; i++)
                {
                    UIImageView *imagv=[[UIImageView alloc] initWithFrame:CGRectMake(0+i*SCREEN_WIDTH, 0,SCREEN_WIDTH , 300)];
                    NSLog(@"%@",[_reciveData[@"color"] objectForKey:_goods_id]);
                    [imagv setImageWithURL:[NSURL URLWithString:[_reciveData[@"color"]objectForKey:_goods_id][@"img"][i]]placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
                    [_scrollv addSubview:imagv];
                    
                }
            }
            _page=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH, 10)];
            _page.numberOfPages=[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count];
            
            _page.pageIndicatorTintColor=[UIColor blueColor];
            _page.currentPageIndicatorTintColor=[UIColor orangeColor];
            [_myView addSubview:_scrollv];
            [_myView addSubview:_page];
            _myTab.tableHeaderView=_myView;
            [_myTab reloadData];
            UIView *toolBarView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT-49, SCREEN_WIDTH, 49)];
            toolBarView.backgroundColor=[UIColor colorWithWhite:0.850 alpha:1.000];
            [self.view addSubview:toolBarView];
            [self.view bringSubviewToFront:toolBarView];

            UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(10.0,4.5,40,40)];
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_good_car"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(collectionstore:) forControlEvents:UIControlEventTouchUpInside];
            [toolBarView addSubview:btn];
            UIButton *btn1=[[UIButton alloc] init ];
            btn1.frame=CGRectMake(SCREEN_WIDTH-100-10,4.5 ,100, 40);
            UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn2.frame=CGRectMake(SCREEN_WIDTH-(100+10)*2, 4.5 ,100, 40);
            [btn1 setTitle:@"立即购买" forState:UIControlStateNormal];
            [btn2 setTitle:@"加入购物袋" forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn1.backgroundColor=[UIColor redColor];
            btn2.backgroundColor=[UIColor orangeColor];
            btn1.layer.cornerRadius=2;
            btn2.layer.cornerRadius=2;
            btn1.layer.masksToBounds=YES;
            btn2.layer.masksToBounds=YES;
            [toolBarView addSubview:btn1];
            [toolBarView addSubview:btn2];
            btn1.tag=1;
            btn2.tag=2;
            [btn1 addTarget:self action:@selector(toolbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn2 addTarget:self action:@selector(toolbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            _storeBtn=[[UIButton alloc] initWithFrame:CGRectMake(35, 4.5, 20, 20)];
            _storeBtn.backgroundColor=[UIColor redColor];
            _storeBtn.userInteractionEnabled=NO;
            [_storeBtn setTitle:[NSString stringWithFormat:@"%ld",_pastNum+_num] forState:UIControlStateNormal];
            _storeBtn.titleLabel.font=[UIFont systemFontOfSize:10];
            _storeBtn.layer.cornerRadius=10;
            _storeBtn.layer.masksToBounds=YES;
            [toolBarView addSubview:_storeBtn];
            [self storeBtnIshiden];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            
        }];
    }
}
-(void)toolbarButtonClick:(UIButton *)btn
{
    if (btn.tag==2)
    {
        DBManager *manger=[DBManager sharedDBManager];
        
        UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, (SCREEN_HIGHT-100)/2,100 ,100)];
        [imageview setImageWithURL:[NSURL URLWithString:[_reciveData[@"color"]objectForKey:_goods_id][@"img"][0]] placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
        [self.view addSubview:imageview];
        [UIView animateWithDuration:1.0 animations:^{
            imageview.frame=CGRectMake(10.0, SCREEN_HIGHT-49.0+4.5, 40, 40);
            imageview.alpha=0.2;
        } completion:^(BOOL finished) {
            [imageview removeFromSuperview];
            
            [self storeBtnIshiden];
            
        }];
        _num++;
        NSArray *dataArray=[manger recieveDBData];
        imageview =nil;
        if (_model)
        {
            
            NSDictionary *dic=@{@"imageUrl":_model.list_url,@"dtailDescrip":[NSString stringWithFormat:@"[%@/%@]%@",_model.brand_name,_model.site_url,_model.goods_title],@"price":[NSString stringWithFormat:@"%@",_model.shop_price],@"contentNum":[NSString stringWithFormat:@"%ld",_num
                ]};
         
            for (int i=0;i<dataArray.count;i++)
            {

                NSDictionary *dic1=dataArray[i];
                if ([dic1[@"imageUrl"] isEqualToString:dic[@"imageUrl"]])
                {
                    NSInteger mycontentNum=[dic1[@"contentNum"]  integerValue]+1;
                    [manger changeDataWithDictionary:@{@"imageUrl":_model.list_url,@"contentNum":[NSString stringWithFormat:@"%ld",mycontentNum]}];
                
                    break;
                }
                else if(i==dataArray.count-1)
                {
                    [manger insertDataWithDictionary:dic];
                }
           
            }
            if (dataArray.count==0) {
                [manger insertDataWithDictionary:dic];
            }
           
            
        }
        else if(_listmodel)
        {
            NSDictionary *dic=@{@"imageUrl":_listmodel.list_url,@"dtailDescrip":[NSString stringWithFormat:@"[%@/%@]%@",_listmodel.brand_name,_listmodel.site_url,_listmodel.goods_title],@"price":[NSString stringWithFormat:@"%@",_listmodel.shop_price],@"contentNum":[NSString stringWithFormat:@"%ld",_num]};
            for (int i=0;i<dataArray.count;i++)
            {
                
                NSDictionary *dic1=dataArray[i];
                if ([dic1[@"imageUrl"] isEqualToString:dic[@"imageUrl"]])
                {
                    NSInteger mycontentNum=[dic1[@"contentNum"]  integerValue]+1;
                    [manger changeDataWithDictionary:@{@"imageUrl":_listmodel.list_url,@"contentNum":[NSString stringWithFormat:@"%ld",mycontentNum]}];
                    
                    break;
                }
                else if(i==dataArray.count-1)
                {
                    [manger insertDataWithDictionary:dic];
                }
                
            }
            if (dataArray.count==0) {
                [manger insertDataWithDictionary:dic];
            }
        }
        else if(_mydetailModel)
        {
            NSDictionary *dic=@{@"imageUrl":_mydetailModel.list_url,@"dtailDescrip":[NSString stringWithFormat:@"[%@/%@]%@",_mydetailModel.brand_name,_mydetailModel.site_url,_mydetailModel.goods_title],@"price":[NSString stringWithFormat:@"%@",_mydetailModel.shop_price],@"contentNum":[NSString stringWithFormat:@"%ld",_num]};
            for (int i=0;i<dataArray.count;i++)
            {
                
                NSDictionary *dic1=dataArray[i];
                if ([dic1[@"imageUrl"] isEqualToString:dic[@"imageUrl"]])
                {
                    NSInteger mycontentNum=[dic1[@"contentNum"]  integerValue]+1;
                    [manger changeDataWithDictionary:@{@"imageUrl":_mydetailModel.list_url,@"contentNum":[NSString stringWithFormat:@"%ld",mycontentNum]}];
                    
                    break;
                }
                else if(i==dataArray.count-1)
                {
                    [manger insertDataWithDictionary:dic];
                }
                
            }
            if (dataArray.count==0) {
                [manger insertDataWithDictionary:dic];
            }

            
        }
  
    }
    else if(btn.tag==1)
    {
        
        AffordViewController *afvc=[[AffordViewController alloc] init];
        [self.navigationController pushViewController:afvc animated:YES];
        afvc.navigationItem.title=@"结算";
        DBManager *manger=[DBManager sharedDBManager];
        _num++;
        NSArray *dataArray=[manger recieveDBData];
        [self storeBtnIshiden];
        if (_model)
        {
            
            NSDictionary *dic=@{@"imageUrl":_model.list_url,@"dtailDescrip":[NSString stringWithFormat:@"[%@/%@]%@",_model.brand_name,_model.site_url,_model.goods_title],@"price":[NSString stringWithFormat:@"%@",_model.shop_price],@"contentNum":[NSString stringWithFormat:@"%ld",_num]};
                                                                                                                                                                                                            
            
            for (int i=0;i<dataArray.count;i++)
            {
                
                NSDictionary *dic1=dataArray[i];
                if ([dic1[@"imageUrl"] isEqualToString:dic[@"imageUrl"]])
                {
                    NSInteger mycontentNum=[dic1[@"contentNum"]  integerValue]+1;
                    [manger changeDataWithDictionary:@{@"imageUrl":_model.list_url,@"contentNum":[NSString stringWithFormat:@"%ld",mycontentNum]}];
                    
                    break;
                }
                else if(i==dataArray.count-1)
                {
                    [manger insertDataWithDictionary:dic];
                }
                
            }
            if (dataArray.count==0) {
                [manger insertDataWithDictionary:dic];
            }
            
            
        }
        else if(_listmodel)
        {
            NSDictionary *dic=@{@"imageUrl":_listmodel.list_url,@"dtailDescrip":[NSString stringWithFormat:@"[%@/%@]%@",_listmodel.brand_name,_listmodel.site_url,_listmodel.goods_title],@"price":[NSString stringWithFormat:@"%@",_listmodel.shop_price],@"contentNum":[NSString stringWithFormat:@"%ld",_num]};
            for (int i=0;i<dataArray.count;i++)
            {
                
                NSDictionary *dic1=dataArray[i];
                if ([dic1[@"imageUrl"] isEqualToString:dic[@"imageUrl"]])
                {
                    NSInteger mycontentNum=[dic1[@"contentNum"]  integerValue]+1;
                    [manger changeDataWithDictionary:@{@"imageUrl":_listmodel.list_url,@"contentNum":[NSString stringWithFormat:@"%ld",mycontentNum]}];
                    
                    break;
                }
                else if(i==dataArray.count-1)
                {
                    [manger insertDataWithDictionary:dic];
                }
                
            }
            if (dataArray.count==0) {
                [manger insertDataWithDictionary:dic];
            }
        }
        else if(_mydetailModel)
        {
            NSDictionary *dic=@{@"imageUrl":_mydetailModel.list_url,@"dtailDescrip":[NSString stringWithFormat:@"[%@/%@]%@",_mydetailModel.brand_name,_mydetailModel.site_url,_mydetailModel.goods_title],@"price":[NSString stringWithFormat:@"%@",_mydetailModel.shop_price],@"contentNum":[NSString stringWithFormat:@"%ld",_num]};
            for (int i=0;i<dataArray.count;i++)
            {
                
                NSDictionary *dic1=dataArray[i];
                if ([dic1[@"imageUrl"] isEqualToString:dic[@"imageUrl"]])
                {
                    NSInteger mycontentNum=[dic1[@"contentNum"]  integerValue]+1;
                    [manger changeDataWithDictionary:@{@"imageUrl":_mydetailModel.list_url,@"contentNum":[NSString stringWithFormat:@"%ld",mycontentNum]}];
                    
                    break;
                }
                else if(i==dataArray.count-1)
                {
                    [manger insertDataWithDictionary:dic];
                }
                
            }
            if (dataArray.count==0) {
                [manger insertDataWithDictionary:dic];
            }
        }
    }
    
    
}
-(void)storeBtnIshiden
{
    if (_pastNum+_num==0) {
       
        _storeBtn.hidden=YES;
    }
    else{
        _storeBtn.hidden=NO;
    }
     [_storeBtn setTitle:[NSString stringWithFormat:@"%ld",_pastNum+_num] forState:UIControlStateNormal];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point=scrollView.contentOffset;
    _page.currentPage=point.x/SCREEN_WIDTH;
}

-(void)loadData
{
     _scrollv=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,300)];
    _scrollv.showsHorizontalScrollIndicator=NO;
    _scrollv.showsVerticalScrollIndicator=NO;
    _scrollv.bounces=NO;
    _scrollv.pagingEnabled=YES;
    _scrollv.delegate=self;
//    [_myView addSubview:_scrollv];
//     _myTab.tableHeaderView=_myView;
    

}
-(void)collectionstore:(UIButton *)btn
{
    ShoppingViewController *svc=[[ShoppingViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (indexPath.section==0)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"headViewCell"];
        NSArray *array=cell.contentView.subviews;
        for (UIView *view in array) {
            [view removeFromSuperview];
        }
        if (!cell) {
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headViewCell"];
                 }
        cell.backgroundColor=[UIColor whiteColor];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1.0)];
        view.backgroundColor=[UIColor blackColor];
        UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 40.0, SCREEN_WIDTH, 1.0)];
        view1.backgroundColor=[UIColor blackColor];
        UIView *view2=[[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-1.0)/2.0, 0, 1.0, 40.0)];
        view2.backgroundColor=[UIColor blackColor];
        [cell.contentView addSubview:view2];
        [cell.contentView addSubview:view];
        [cell.contentView addSubview:view1];
        UIImageView *imav=[[UIImageView alloc] initWithFrame:CGRectMake(((SCREEN_WIDTH)/2.0-90)/2.0, 5, 30, 30)];
        imav.image=[UIImage imageNamed:@"icon_favorite"];
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(((SCREEN_WIDTH)/2.0-90)/2.0+35, 5, 60, 30)];
        
        NSInteger inter=[_reciveData[@"praise"] integerValue];
        
        NSLog(@"%ld",inter);
        NSString *str=[NSString stringWithFormat:@"(%ld)",inter];
        lab.text=str;
        
        UIImageView *imav1=[[UIImageView alloc] initWithFrame:CGRectMake(((SCREEN_WIDTH)/2.0-90)/2.0+(SCREEN_WIDTH)/2.0, 5, 30, 30)];
        imav1.image=[UIImage imageNamed:@"icon_share_detail"];
        UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(((SCREEN_WIDTH)/2.0-90)/2.0+(SCREEN_WIDTH)/2.0+30, 5, 60, 30)];
        lab1.text=@"分享";
        [cell.contentView addSubview:imav];
        [cell.contentView addSubview:lab];
        [cell.contentView addSubview:imav1];
        [cell.contentView addSubview:lab1];
        
        UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(20, 42, SCREEN_WIDTH-20, 50)];
        lab2.numberOfLines=0;
        if (_model) {
          lab2.text=_model.goods_name;
        }
        else
        {
            lab2.text=_listmodel.goods_title;
        }
        
        lab2.font=[UIFont systemFontOfSize:17];
        
        UILabel *lab3=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 100, 60, 20)];
          NSInteger inter1=[_reciveData[@"shop_price"] integerValue];
        lab3.text=[NSString stringWithFormat:@"¥%ld",inter1];
        lab3.textColor =[UIColor redColor];
          [cell.contentView addSubview:lab3];
        [cell.contentView addSubview:lab2];
        
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 20, 20)];
        [iv setImage:[UIImage imageNamed:@"dtz2"]];
        [cell.contentView addSubview:iv];
        UILabel *lab4=[[UILabel alloc] initWithFrame:CGRectMake(50.0, 100.0, 150.0, 19.0)];
        if (_model) {
             lab4.text=[NSString stringWithFormat:@"%@/%@",_model.brand_title,_model.site_url];
        }
        else if(_listmodel)
        {
          lab4.text=[NSString stringWithFormat:@"%@/%@",_listmodel.brand_name,_listmodel.site_url];
        }
       else if(_mydetailModel)
       {
        lab4.text=[NSString stringWithFormat:@"%@/%@",_mydetailModel.brand_name,_mydetailModel.site_url];
       }
        lab4.textColor=[UIColor orangeColor];
        lab4.font=[UIFont systemFontOfSize:18];
        CGRect bounds = [lab4.text boundingRectWithSize:CGSizeMake(1000000000, 19) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
        [cell.contentView addSubview:lab4];
        UIView *view4=[[UIView alloc] initWithFrame: CGRectMake(50.0, 119.0, bounds.size.width, 1.0)];
        view4.backgroundColor=[UIColor orangeColor];
        
        [cell.contentView addSubview:view4];
        return cell;

    }
    else if(indexPath.section==1)
    {
       
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"kind"];
        NSArray *array=cell.contentView.subviews;
        for (UIView *view in array)
        {
            [view removeFromSuperview];
            
        }
        lastFloat=0;
        lastWidth=0;
         contentY=0;
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kind"];
        }
        cell.backgroundColor=[UIColor whiteColor];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
        lab.text=@"颜色分类";
        lab.font=[UIFont systemFontOfSize:17];
        [cell.contentView addSubview:lab];
        if (_colerArray) {
            int a=0;
        for (int i=0; i<_colerArray.count; i++)
        {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            [btn setTitle:_colerArray[i] forState:UIControlStateNormal];

            btn.titleLabel.font=[UIFont systemFontOfSize:15];
            lastFloat+=10;
          
            CGRect  bound=[ btn.titleLabel.text boundingRectWithSize:CGSizeMake(1000000000, 19) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
            
            CGFloat  contentOrgX=lastFloat+lastWidth+a*10.0;
            if (contentOrgX+bound.size.width>SCREEN_WIDTH-10)
            {
                lastFloat=10;
                lastWidth=0;
                contentOrgX=lastWidth+lastFloat;
                contentY+=1;
                a=0;
            }
          
            btn.frame=CGRectMake(contentOrgX, 40+contentY*40, bound.size.width+10, 30);
             lastWidth+=bound.size.width;
            //给btn加一个边框 边框宽度为1
            btn.layer.borderWidth=1.0;

            if (i==0) {
                btn.layer.borderColor=[[UIColor redColor] CGColor];
                _selectedBtn=btn;
            }
            else
            btn.layer.borderColor=[[UIColor blackColor]CGColor];
            btn.tag=i+100;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            a++;
            [cell.contentView addSubview:btn];
        }
     }
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, (contentY+1)*40+14+30, SCREEN_WIDTH, 1)];
        view.backgroundColor=[UIColor blackColor];
        [cell.contentView addSubview:view];
        UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(10, (contentY+1)*40+15+30+10, SCREEN_WIDTH-20, 20)];
        lab1.text=@"尺寸";
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        if (_cmArray.count>0) {
        [btn1 setTitle:[_cmArray firstObject] forState:UIControlStateNormal];
        }
    
    btn1.titleLabel.font=[UIFont systemFontOfSize:15];
    CGRect  bound1=[ btn1.titleLabel.text boundingRectWithSize:CGSizeMake(1000000000, 19) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
     btn1.frame=CGRectMake(10,(contentY+1)*40+15+30+10+30 , bound1.size.width+10, 30);
        btn1.layer.borderWidth=1.0;
        btn1.layer.borderColor=[[UIColor redColor] CGColor];
        [cell.contentView addSubview:btn1];
        
        [cell.contentView addSubview:lab1];
        return cell;

    }
        else if(indexPath.section==2)
    {
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"zs"];
        NSArray *array=cell.contentView.subviews;
        for (UIView *view in array) {
            [view removeFromSuperview];
        }
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"zs"];
        }
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
        lab.text=@"商品展示";
        
               _imgView=[[UIImageView alloc] init];
        
        [cell.contentView addSubview:_imgView];
        [cell.contentView addSubview:lab];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        return cell;

    }
       else if(indexPath.section==3)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"gg"];
        NSArray *array=cell.contentView.subviews;
        for (UIView *view in array) {
            [view removeFromSuperview];
        }
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gg"];
        }
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
        lab.text=@"商品描述";
        [cell.contentView addSubview:lab];
        UILabel *lab1=[[UILabel alloc] init];
        if(_reciveData[@"IOS_DESC"][@"iosGoodsInfoDesc"]&& [_reciveData[@"IOS_DESC"][@"iosGoodsInfoDesc"] count]>0)
        {
            lab1.text=[_reciveData[@"IOS_DESC"][@"iosGoodsInfoDesc"] firstObject];
            lab1.numberOfLines=0;
        lab1.font=[UIFont systemFontOfSize:15];
        CGRect bound=[lab1.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 1000000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil];
            lab1.frame=CGRectMake(10, 40, SCREEN_WIDTH-20, bound.size.height);
            _descripH=bound.size.height;
            [cell.contentView addSubview:lab1];
        }
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
        
    }
    
    else if(indexPath.section==4)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"web"];
        NSArray *array=cell.contentView.subviews;
        for (UIView *view in array) {
            [view removeFromSuperview];
        }
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"web"];
            
        }
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
        lab.text=@"商品规格";
        if ([_reciveData[@"IOS_DESC"][@"iosGoodsInfoDesc"]count]>0)
           {
               
        _spdw=_reciveData[@"IOS_DESC"][@"iosGoodsTh"];
               _spgg=_reciveData[@"IOS_DESC"][@"iosGoodsTd"];
        for (int i=0; i<_spdw.count; i++) {
            UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(20, 40+i*20, SCREEN_WIDTH-20, 20)];
            lab.text=[NSString stringWithFormat:@"%@   %@",_spdw[i],_spgg[i]];
            lab.tag=i+1000;
            [cell.contentView addSubview:lab];
            
           }
               UILabel *lab1=(UILabel *)[self.view viewWithTag:_spdw.count-1+1000];
               _spggCellHight=lab1.frame.origin.y+20;
        }
        [cell.contentView addSubview:lab];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
        
    }
    
    else if(indexPath.section==5)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"fw"];
        NSArray *array=cell.contentView.subviews;
        for (UIView *view in array) {
            [view removeFromSuperview];
        }
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fw"];

        }
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
        
        lab.text=@"客户服务";
        [cell.contentView addSubview:lab];
        UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(20,40 , SCREEN_WIDTH-20, 20)];
        lab1.text=@"【客服电话】400-0788-738";
        [cell.contentView addSubview:lab1];
        UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(20,40+20 , SCREEN_WIDTH-20, 20)];
        lab2.text=@"【客服时间】周一至周五09:00-22:00";
        [cell.contentView addSubview:lab2];
        UILabel *lab3=[[UILabel alloc] initWithFrame:CGRectMake(20,40+20+20 , SCREEN_WIDTH-20, 20)];
        lab3.text=@"【发货时间】周一至周日全天发货,17点付款当天发货";
        [cell.contentView addSubview:lab3];
        UILabel *lab4=[[UILabel alloc] initWithFrame:CGRectMake(20,40+20+20+20 , SCREEN_WIDTH-20, 20)];
        lab4.text=@"【配送服务】限大陆地区,港澳台地区无法配送";
        [cell.contentView addSubview:lab4];
        UILabel *lab5=[[UILabel alloc] initWithFrame:CGRectMake(20,40+20+20+20+20 , SCREEN_WIDTH-20, 20)];
        lab5.text=@"【相关服务】请参阅我的订单,可办理退换货";
        
        [cell.contentView addSubview:lab5];
       
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
         cell.backgroundColor=[UIColor whiteColor];
        return cell;
    }

    else if(indexPath.section==6)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"collection"];
        NSArray *array=cell.contentView.subviews;
        for (UIView *view in array)
        {
            [view removeFromSuperview];
        }
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collection"];
           
        }
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
    }

    return [[UITableViewCell alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
       return 140.0;
    }
   else if (indexPath.section==1) {
        return (contentY+1)*40.0+30.0+15.0+30.0+50.0;
    }
   else if (indexPath.section==2) {
    
       __weak typeof (&*self)weakSelf=self;
       if (_reciveData[@"IOS_DESC"][@"iosGoodsDescImg"]&&[_reciveData[@"IOS_DESC"][@"iosGoodsDescImg"] count]>0){
           
           
           [_imgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_reciveData[@"IOS_DESC"][@"iosGoodsDescImg"][0]]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
               
               weakSelf.imgView.image=image;
               
               weakSelf.imgView.frame=CGRectMake(0, 40.0, image.size.width, image.size.height);
               _cellHight=image.size.height;
               
           } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
               NSLog(@"%@",error);
           }];
       }

       return _cellHight+50.0;
   }
    else if(indexPath.section==3)
    {
        return _descripH+50.0;
    }
    else if
        (indexPath.section==4)
    {
        if (_spggCellHight==0) {
            return 40.0;
        }
        else
        return _spggCellHight+10.0;
    }
    else if (indexPath.section==5)
    {
        return 40.0+20.0+20.0+20.0+20.0+40.0;
    }
        else
            return 44.0;
}
-(void)btnClick:(UIButton *)btn
{
    if (btn.tag!=100) {
        
    
    _selectedBtn.layer.borderColor=[[UIColor blackColor]CGColor ];
    btn.layer.borderColor=[[UIColor redColor] CGColor];
    _selectedBtn=btn;
    
    NSArray *imgArray=_scrollv.subviews;
    for (UIImageView *imv in imgArray) {
        [imv removeFromSuperview];
    }
    
   _scrollv.contentSize=CGSizeMake(([[_reciveData[@"color"]objectForKey:_keysArray[btn.tag-100]][@"img"] count])*SCREEN_WIDTH, 300);
    for (int i=0; i<[[_reciveData[@"color"]objectForKey:_keysArray[btn.tag-100]][@"img"] count]; i++)
    {
        NSLog(@"xxxxxxxxxxxxxxxxxxxx");
        UIImageView *imagv=[[UIImageView alloc] initWithFrame:CGRectMake(0+i*SCREEN_WIDTH, 0,SCREEN_WIDTH , 300)];
        NSLog(@"%@",[_reciveData[@"color"] objectForKey:_goods_id]);
        [imagv setImageWithURL:[NSURL URLWithString:[_reciveData[@"color"]objectForKey:_keysArray[btn.tag-100]][@"img"][i]]placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
        _scrollv.contentOffset=CGPointMake(0, 0);
        [_scrollv addSubview:imagv];
      
    }
        _goods_id=_colerKeys[btn.tag-100];
    _page.numberOfPages=[[_reciveData[@"color"]objectForKey:_keysArray[btn.tag-100]][@"img"] count];
    _page.currentPage=0;
    [_myView bringSubviewToFront:_page];

    }
    else if(btn.tag==100)
    {
        if ([btn isEqual:_selectedBtn]) {
            
        }
        else
        {
            _selectedBtn.layer.borderColor=[[UIColor blackColor]CGColor ];
            btn.layer.borderColor=[[UIColor redColor] CGColor];
            _selectedBtn=btn;
            
            NSArray *imgArray=_scrollv.subviews;
            for (UIImageView *imv in imgArray) {
                [imv removeFromSuperview];
            }
            _goods_id=_colerKeys[0];
            
              _scrollv.contentSize=CGSizeMake(([[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count])*SCREEN_WIDTH, 300);
        for (int i=0; i<[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count]; i++)
        {
            UIImageView *imagv=[[UIImageView alloc] initWithFrame:CGRectMake(0+i*SCREEN_WIDTH, 0,SCREEN_WIDTH , 300)];
            NSLog(@"%@",[_reciveData[@"color"] objectForKey:_goods_id]);
            [imagv setImageWithURL:[NSURL URLWithString:[_reciveData[@"color"]objectForKey:_goods_id][@"img"][i]]placeholderImage:[UIImage imageNamed:@"area_detai_default"]];
             _scrollv.contentOffset=CGPointMake(0, 0);
            [_scrollv addSubview:imagv];
            
        }
            _page.numberOfPages=[[_reciveData[@"color"]objectForKey:_goods_id][@"img"] count];
            _page.currentPage=0;
            [_myView bringSubviewToFront:_page];

        }

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
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
