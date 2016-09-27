//
//  PersonMessageViewController.m
//  食客天下
//
//  Created by qianfeng on 15/12/8.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "PersonMessageViewController.h"

@interface PersonMessageViewController ()
@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong)NSMutableArray *storeArray;
@end

@implementation PersonMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _storeArray=[NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/arr.plist",NSHomeDirectory()]];
    self.view.backgroundColor=[UIColor grayColor];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(10, 64+10, SCREEN_WIDTH-20, 40)];
    view.backgroundColor=[UIColor whiteColor];
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(10, 64+10+40.5, SCREEN_WIDTH-20, 40)];
    view1.backgroundColor=[UIColor whiteColor];
    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(10, 64+10+40.5*2+0.5, SCREEN_WIDTH-20, 40)];
    view2.backgroundColor=[UIColor whiteColor];
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    lab.text=@"收货人姓名:";
    lab1.text=@"手机号码:";
    lab2.text=@"添加地址:";
    [self.view addSubview:view];
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [view addSubview:lab];
    [view1 addSubview:lab1];
    [view2 addSubview:lab2];
    UITextField *fild=[[UITextField alloc] initWithFrame:CGRectMake(120,10 ,SCREEN_WIDTH-120-20 ,20)];
    UITextField *fild1=[[UITextField alloc] initWithFrame:CGRectMake(120,10 ,SCREEN_WIDTH-120-20 ,20)];
    UITextField *fild2=[[UITextField alloc] initWithFrame:CGRectMake(120,10 ,SCREEN_WIDTH-120-20 ,20)];
    [view addSubview:fild];
    [view1 addSubview:fild1];
    [view2 addSubview:fild2];
    fild.clearButtonMode=UITextFieldViewModeWhileEditing;
    fild1.clearButtonMode=UITextFieldViewModeWhileEditing;
    fild2.clearButtonMode=UITextFieldViewModeWhileEditing;
    UILabel *view3=[[UILabel alloc] initWithFrame:CGRectMake(10, 64+10+40.5*2+0.5+40.5+50, SCREEN_WIDTH-20, 40)];
    view3.backgroundColor=[UIColor redColor];
    view3.text=@"添加地址";
    view3.textColor=[UIColor whiteColor];
    view3.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:view3];
    view3.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [view3 addGestureRecognizer:tap];
    _dic=@{@"username":fild.text,@"phoneNum":fild1.text,@"directions":fild2.text};
    
}
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    
    [self.navigationController popViewControllerAnimated:YES];
    [_storeArray addObject:_dic];
    [_storeArray writeToFile:[NSString stringWithFormat:@"%@/Documents/arr.plist",NSHomeDirectory()] atomically:YES];
    
    _block(_dic);
    
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
