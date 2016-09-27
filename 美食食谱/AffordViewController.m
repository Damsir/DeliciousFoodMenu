//
//  AffordViewController.m
//  食客天下
//
//  Created by qianfeng on 15/12/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AffordViewController.h"

@interface AffordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)NSArray *mydata;
@property (nonatomic,strong)NSMutableArray *contentModelArray;
@property (nonatomic,strong)NSArray *timeAray;
@property (nonatomic,strong)NSArray *affordArray;
@property (nonatomic,strong)NSString *contentString;

@end

@implementation AffordViewController

-(void)viewDidAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
    _contentModelArray=[NSMutableArray array];
    [_contentModelArray addObject:@"1"];
    [_contentModelArray addObject:@"1"];
    
    // Do any additional setup after loading the view.
    _mydata=@[@"收货信息",@"发货时间",@"支付方式",@"订单金额"];
    _timeAray=@[@"任何时间均可送货",@"工作日送货",@"双休日送货"];
    _affordArray=@[@"在线支付",@"货到付款"];
    
    _contentString=_timeAray[0];
    self.view.backgroundColor=[UIColor whiteColor];
    _tab=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStyleGrouped];
    self.navigationController.navigationBar.translucent=YES;
    _tab.delegate=self;
    _tab.dataSource=self;
    [self.view addSubview:_tab];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section!=1&&section!=2) {
        return 1;
    }
    else if(section==1)
    {
        NSLog(@"qqqqqqqqqqq%@",_contentModelArray);
        if ([_contentModelArray[0] isEqualToString:@"1"]) {
             NSLog(@"xxxxxxxxxxx");
            return 1;
           
        }
        else if([_contentModelArray[0] isEqualToString:@"0"])
        {
             NSLog(@"vvvvvvvvvvvvv");
            return 3;
        }
    }
    else if (section==2)
    {
        if ([_contentModelArray[1] isEqualToString:@"1"]) {
            return 1;
        }
        else
            return 2;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.section==1) {
        if (indexPath.section==1&&indexPath.row==0) {
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 20, 20)];
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cell)
            {
                cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
                
                imageView.image=[UIImage imageNamed:@"icon_checked_ok"];
                imageView.layer.cornerRadius=10;
                imageView.layer.masksToBounds=YES;
                imageView.layer.borderWidth=1;
                imageView.layer.borderColor=[[UIColor grayColor] CGColor];
                UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(40, 14, 150, 20)];
                lab.text=_timeAray[0];
                [cell.contentView addSubview:lab];
                [cell.contentView addSubview:imageView];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }
  
        }
        if (indexPath.section==1&&indexPath.row==1) {
            
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 20, 20)];
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cell)
            {
                cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
                
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                imageView.image=[UIImage imageNamed:@"icon_checked_ok"];
                imageView.layer.cornerRadius=10;
                imageView.layer.masksToBounds=YES;
                imageView.layer.borderWidth=1;
                imageView.layer.borderColor=[[UIColor grayColor] CGColor];
                UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(40, 14, 100, 20)];
                lab.text=_timeAray[1];
                [cell.contentView addSubview:lab];
                [cell.contentView addSubview:imageView];
                return cell;
            }
            
        }
        if (indexPath.section==1&&indexPath.row==2) {
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 20, 20)];
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cell)
            {
                cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
                
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                imageView.image=[UIImage imageNamed:@"icon_checked_ok"];
                imageView.layer.cornerRadius=10;
                imageView.layer.masksToBounds=YES;
                imageView.layer.borderWidth=1;
                imageView.layer.borderColor=[[UIColor grayColor] CGColor];
                UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(40, 14, 100, 20)];
                lab.text=_timeAray[2];
                [cell.contentView addSubview:lab];
                [cell.contentView addSubview:imageView];
                return cell;
            }
            
        }
            }
    return [[UITableViewCell alloc] init];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 12, 80, 20)];
    lab.text=_mydata[section];
    [view addSubview:lab];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView  *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor=[UIColor grayColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        GetGoodsDirectionViewController *gvc=[[GetGoodsDirectionViewController alloc] init];
        [self.navigationController pushViewController:gvc animated:YES];
        
    }
    if (indexPath.section==1)
    {
        if ([_contentModelArray[0] isEqualToString:@"1"]) {
            _contentModelArray[0]=@"0";
        }
        else
        {
            _contentModelArray[0]=@"1";
        }
        
        [_tab reloadData];
    }
    if (indexPath.section==2) {
        
    }
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
