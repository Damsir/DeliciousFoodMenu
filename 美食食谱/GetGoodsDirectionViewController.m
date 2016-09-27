//
//  GetGoodsDirectionViewController.m
//  食客天下
//
//  Created by qianfeng on 15/12/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GetGoodsDirectionViewController.h"

@interface GetGoodsDirectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSDictionary *mydic;
@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)NSMutableArray *storeArray;
@end

@implementation GetGoodsDirectionViewController
-(void)viewWillAppear:(BOOL)animated
{
    _storeArray=[NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/arr.plist",NSHomeDirectory()]];
    if (_storeArray.count>0)
    {
        
        _tab=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tab.delegate=self;
        _tab.dataSource=self;
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"地址列表";
  UILabel *lab=[[UILabel  alloc] initWithFrame:CGRectMake(20, SCREEN_HIGHT-70, SCREEN_WIDTH-40, 40)];
    lab.backgroundColor=[UIColor redColor];
    lab.text=@"新增收货地址＋";
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:20];
    lab.textColor=[UIColor whiteColor];
    lab.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [lab addGestureRecognizer:tap];
    [self.view addSubview:lab];
    
}
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    PersonMessageViewController *per=[[PersonMessageViewController alloc] init];
    per.block=
    ^(NSDictionary *dic)
    {
        _mydic=dic;
        
    };
    [self.navigationController pushViewController:per animated:YES];
    per.navigationItem.title=@"添加地址";
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _storeArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
      cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    NSDictionary *dic=_storeArray[indexPath.row];
    CGRect bound=[dic[@"username"] boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil];
    UILabel *lab=[[UILabel alloc] init];
    lab.text=dic[@"username"];
    lab.font=[UIFont systemFontOfSize:15];
    lab.frame=CGRectMake(10, 10, bound.size.width, 20);
    [cell.contentView addSubview:lab];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
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
