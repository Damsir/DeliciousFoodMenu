//
//  BasicTabBarController.m
//  美食食谱
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.

#import "BasicTabBarController.h"

@interface BasicTabBarController ()
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UIScrollView *scroll;
@end
@implementation BasicTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor=[UIColor redColor];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults] ;
    //从NSUserDefaults中通过isFirst取到程序启动的状态
    BOOL isFirst = [defaults boolForKey:@"isFirst"] ;
    
    if (!isFirst)
    {
        //是第一次启动，创建scrollView显示引导页
        [self createSCrollView] ;
        if (!_timer)
        {
            _timer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        }

    }
    else
    {
        //不是第一次启动，直接设置window的根试图控制器为tabBarController
      [self initTabBarcontroller];
    }

    
}
-(void)timerRun
{
    CATransition *transition=[CATransition animation];
    transition.duration=3.5;
    transition.type=@"rippleEffect";
    transition.subtype=kCATransitionFromRight;
    [_scroll.layer addAnimation:transition forKey:@"animation"];
    CGPoint point=_scroll.contentOffset;
    if (point.x<=SCREEN_WIDTH*3) {
       point.x+=SCREEN_WIDTH;
    }
   
    _scroll.contentOffset=point;
    if (_scroll.contentOffset.x==SCREEN_WIDTH*4) {
//        [_timer invalidate];
//        _timer=nil;
    }
}
-(void)initTabBarcontroller
{
    NSArray *nameArray=@[@"首页",@"新品",@"品牌",@"我的"];
    NSArray *imageNameArray=@[@"tab_home_",@"tab_new_",@"tab_brand_",@"tab_user_"];

   int i=0;
    for (UINavigationController *nav in self.viewControllers)
    {
        UIViewController *vc=nav.viewControllers.firstObject;
        UIImage *image=[UIImage resizableImage:[NSString stringWithFormat:@"%@normal",imageNameArray[i]]];
        UIImage *selcetedImage=[UIImage resizableImage:[NSString stringWithFormat:@"%@checked",imageNameArray[i]]];
        vc.tabBarItem=[[UITabBarItem alloc] initWithTitle:nameArray[i] image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selcetedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        i++;
    }
}
-(void)createSCrollView
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults setBool:YES forKey:@"isFirst"] ;
    [defaults synchronize] ;
    
     _scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds] ;
    //设置画布大小
    _scroll.contentSize = CGSizeMake(self.view.bounds.size.width*5, self.view.bounds.size.height) ;
    
    _scroll.bounces = NO ;
    
    _scroll.pagingEnabled = YES ;
    
    _scroll.showsHorizontalScrollIndicator = NO ;
    
    _scroll.tag = 101 ;
    
    [self.view addSubview:_scroll] ;
    
    NSArray * imageNameArray = @[@"one",@"two",@"three",@"four",@"five"];
     
    for (int i = 0 ; i < 5 ; i++ )
    {
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)] ;
        
      
        if (i==0) {
            
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"helpphoto_%@",imageNameArray[i]]] ;
            UIImageView *imagev=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-50)/2, 40, 50, 400)];
            imagev.image=[UIImage imageNamed:@"1449286386_224620"];
            [imageV addSubview:imagev];
            UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-160, SCREEN_HIGHT-60, 150, 40)];
            iv.image=[UIImage imageNamed:@"1449287029_109247"];
            [imageV addSubview:iv];
            
        }
        if (i==1) {
            
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"helpphoto_%@",imageNameArray[i]]] ;
            UIImageView *imagev=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 40, 50, 400)];
            imagev.image=[UIImage imageNamed:@"1449286493_856235"];
            [imageV addSubview:imagev];
            UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-160, SCREEN_HIGHT-60, 150, 40)];
            iv.image=[UIImage imageNamed:@"1449287029_109247"];
            [imageV addSubview:iv];
            
        }
        if (i==2) {
            
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"helpphoto_%@",imageNameArray[i]]] ;
            UIImageView *imagev=[[UIImageView alloc] initWithFrame:CGRectMake(10, SCREEN_HIGHT-500, 50, 400)];
            imagev.image=[UIImage imageNamed:@"1449286793_409670"];
            [imageV addSubview:imagev];
            UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-160, SCREEN_HIGHT-60, 150, 40)];
            iv.image=[UIImage imageNamed:@"1449287029_109247"];
            [imageV addSubview:iv];
            
        }
        if (i==3) {
            
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"helpphoto_%@",imageNameArray[i]]] ;
            UIImageView *imagev=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-50)/2+50, 40, 50, 400)];
            imagev.image=[UIImage imageNamed:@"1449286953_913182"];
            [imageV addSubview:imagev];
            UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-160, SCREEN_HIGHT-60, 150, 40)];
            iv.image=[UIImage imageNamed:@"1449287029_109247"];
            [imageV addSubview:iv];
            
        }
        
        if (i == 4)
        {
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"helpphoto_%@",imageNameArray[i]]] ;
            imageV.userInteractionEnabled = YES ;
            UIImageView *lab=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-120)/2, 500, 120, 50)];
            lab.image=[UIImage imageNamed:@"1449284783_994019"];

            [imageV addSubview:lab];
            UIImageView *imagev=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-50)/2, 40, 50, 400)];
            imagev.image=[UIImage imageNamed:@"1449284145_578596"];
            imagev.layer.cornerRadius=3;
            imagev.layer.masksToBounds=YES;
            lab.layer.borderWidth=1.0;
            lab.layer.borderColor=[[UIColor grayColor] CGColor];
            [imageV addSubview:imagev];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOne:)] ;
            [imageV addGestureRecognizer:tap] ;
        }
        [_scroll addSubview:imageV] ;
    }
    
}
- (void)tapOne:(UITapGestureRecognizer *)tap
{
    [self initTabBarcontroller];
    UIScrollView * scroll = (id)[self.view viewWithTag:101] ;
    
    [scroll removeFromSuperview] ;
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
