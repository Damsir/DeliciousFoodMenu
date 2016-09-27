//
//  ShoppingViewController.m
//  食客天下
//
//  Created by qianfeng on 15/12/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ShoppingViewController.h"
@interface ShoppingViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)MyPpdetailModel *mydetailModel;
@property (nonatomic,strong)listModel *listmodel;
@property (nonatomic,strong)goodsListModel *goodlistModel;
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)UITextField *tf;
@property (nonatomic,strong)NSMutableArray *selectedArray;
@property (nonatomic,assign)CGFloat moneyCount;
@property (nonatomic,strong)UILabel *lab1;
@property (nonatomic,assign)NSInteger allGoodsNum;
@property (nonatomic,strong)UILabel *lab2;
@property (nonatomic,strong)UILabel *lab3;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationItem.title=@"购物袋";
    _selectedArray=[NSMutableArray array];
    _tab=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tab.delegate=self;
    _tab.dataSource=self;
    [self.view addSubview:_tab];
    UIView *myview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    myview.backgroundColor=[UIColor grayColor];
    UIView *toolBarView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT-49, SCREEN_WIDTH, 49)];
    [self.view addSubview:toolBarView];
    [toolBarView addSubview:myview];
    toolBarView.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(10, 5, 20, 20);
    btn.layer.cornerRadius=10;
    btn.layer.masksToBounds=YES;
    btn.layer.borderWidth=1.0;
    btn.tag=3000;
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_checked_ok"] forState:UIControlStateNormal];
    btn.layer.borderColor=[[UIColor grayColor] CGColor];
    [btn addTarget:self action:@selector(allcolected:) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:btn];
    toolBarView.alpha=1.0;
  _array = [[DBManager sharedDBManager] recieveDBData] ;
    NSLog(@"%@",_array);
    for (int i=0; i<_array.count; i++) {
        [_selectedArray addObject:[NSString stringWithFormat:@"1"]];
    }
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(40, 5, 50, 20)];
    lab.text=@"全选";
    _lab1=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 9, 150, 20)];
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    
    UILabel *lab3=[[UILabel alloc] init];
    
    for (int i=0; i<_array.count; i++)
    {
        NSInteger inter=[_array[i][@"price"] integerValue]*[_array[i][@"contentNum"] integerValue];
        _allGoodsNum+=[_array[i][@"contentNum"] integerValue];
        
        _moneyCount+=inter;
    }
    lab2.text=[NSString stringWithFormat:@"商品数量:%ld",_allGoodsNum];
    _lab1.text=[NSString stringWithFormat:@"应付:￥%.2lf",_moneyCount];
    lab3.text=[NSString stringWithFormat:@"总金额:￥%.2f",_moneyCount];
    lab3.font=[UIFont systemFontOfSize:15];
    CGRect bound=[lab3.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    lab3.frame=CGRectMake(SCREEN_WIDTH-bound.size.width-10, 10, bound.size.width, 20);
    _moneyCount=0;
    _allGoodsNum=0;
    _lab1.textColor=[UIColor redColor];
    [toolBarView addSubview:_lab1];
    _lab1.textAlignment=NSTextAlignmentCenter;
    UIButton *buybtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buybtn.frame=CGRectMake(SCREEN_WIDTH-60,(49-35)/2 , 50, 35);
    buybtn.backgroundColor=[UIColor redColor];
    [buybtn setTitle:@"去结算" forState:UIControlStateNormal];
    [buybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buybtn.layer.cornerRadius=3;
    buybtn.layer.masksToBounds=YES;
    [buybtn addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:buybtn];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ButtonBack2_Pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT-49-40, SCREEN_WIDTH, 40)];
    [self.view addSubview:view1];
    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    view2.backgroundColor=[UIColor grayColor];
    view1.backgroundColor=[UIColor whiteColor];
    [view1 addSubview:view2];
    [view1 addSubview:lab2];
    [view1 addSubview:lab3];
    _lab2=lab2;
    _lab3=lab3;
   
    
    
}
-(void)buy:(UIButton *)btn
{
    AffordViewController *afvc=[[AffordViewController alloc] init];
    [self.navigationController pushViewController:afvc animated:YES];
    afvc.navigationItem.title=@"结算";
}
-(void)allcolected:(UIButton *)btn
{

    BOOL isSel=[self isallColected];
    NSArray *array=[[DBManager sharedDBManager] recieveDBData];
    if (isSel==NO)
    {
        
    for (int i=0; i<array.count; i++)
    {
        UIButton *btn=(UIButton *)[self.view viewWithTag:2000+i];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_checked_ok"] forState:UIControlStateNormal];
        _selectedArray[i]=[NSString stringWithFormat:@"1"];
    }
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_checked_ok"] forState:UIControlStateNormal ];
        for (int i=0; i<array.count; i++)
        {
            NSInteger inter=[array[i][@"price"] integerValue]*[array[i][@"contentNum"] integerValue];
            _allGoodsNum+=[array[i][@"contentNum"] integerValue];
            _moneyCount+=inter;
        }
        _lab1.text=[NSString stringWithFormat:@"应付:￥%.2lf",_moneyCount];
        _lab2.text=[NSString stringWithFormat:@"商品数量:%ld",_allGoodsNum];
        _lab3.text=[NSString stringWithFormat:@"总金额:￥%.2f",_moneyCount];
        _moneyCount=0;
    }
    else
    {
        for (int i=0; i<array.count; i++)
        {
            UIButton *btn=(UIButton *)[self.view viewWithTag:2000+i];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            _selectedArray[i]=[NSString stringWithFormat:@"0"];
        }
        [btn setBackgroundImage:nil forState:UIControlStateNormal ];
         _lab1.text=[NSString stringWithFormat:@"应付:￥%.2lf",0.0];
        _lab2.text=[NSString stringWithFormat:@"商品数量:0"];
        _lab3.text=[NSString stringWithFormat:@"总金额:￥%.2f",0.00];
    }
  
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_array.count<499)
    {
        
        return _array.count;
    }
    else
    {
        return 499;
    }
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSArray *arr=cell.contentView.subviews;
    for (UIView *view in arr) {
        [view removeFromSuperview];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(50, 20, 80, 80)];
    imageview.layer.borderWidth=1.0;
    imageview.layer.borderColor=[[UIColor grayColor] CGColor];
    NSDictionary *dic =_array[indexPath.row];
    [imageview setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]]];
    [cell.contentView addSubview:imageview];
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(150, 20, SCREEN_WIDTH-150-20, 20)];
    lab.text=dic[@"dtailDescrip"];
    UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(150, 20+20, SCREEN_WIDTH-150-20, 20)];
    lab1.text=[NSString stringWithFormat:@"￥%@",dic[@"price"]];
    lab1.textColor=[UIColor redColor];
    [cell.contentView addSubview:lab];
    [cell.contentView addSubview:lab1];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(150, 20+20+20, 20, 20);
    [btn setTitle:@"-" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=100+indexPath.row;
    btn.backgroundColor=[UIColor colorWithWhite:0.875 alpha:1.000];
    [cell.contentView addSubview:btn];
  UITextField *tf=[[UITextField alloc] initWithFrame:CGRectMake(150+20, 20+20+20, 30, 20)];
    tf.delegate=self;
    tf.text=dic[@"contentNum"];
    if ([tf.text isEqualToString:@"1"]) {
         [btn setTitleColor:[UIColor colorWithWhite:0.500 alpha:1.000] forState:UIControlStateNormal];
    }
    tf.textAlignment=NSTextAlignmentCenter;
    tf.tag=1000+indexPath.row;
    [cell.contentView addSubview:tf];
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame=CGRectMake(150+20+30, 20+20+20, 20, 20);
    [btn1 setTitle:@"+" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor=[UIColor colorWithWhite:0.870 alpha:1.000];
    btn1.tag=500+indexPath.row;
    [cell.contentView addSubview:btn1];
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(10, 50, 20, 20);
    btn2.layer.cornerRadius=10;
    btn2.layer.masksToBounds=YES;
    btn2.layer.borderWidth=1.0;
    btn2.tag=2000+indexPath.row;
    btn2.layer.borderColor=[[UIColor grayColor] CGColor];
    [btn2 addTarget:self action:@selector(chooseMygoods:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn2];
    if ([_selectedArray[indexPath.row] isEqualToString:@"1"])
    {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"icon_checked_ok"] forState:UIControlStateNormal];
    }
    else
    {
        [btn2 setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    return cell;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)chooseMygoods:(UIButton *)btn
{
    NSInteger inter=[_selectedArray[btn.tag-2000] integerValue];
    NSLog(@"%ld",inter);
    if (inter==0) {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_checked_ok"] forState:UIControlStateNormal];
        _selectedArray[btn.tag-2000] =[NSString stringWithFormat:@"1"];
        BOOL isSel=[self isallColected];
        if (isSel==YES)
        {
            
            UIButton *btn=(UIButton *)[self.view viewWithTag:3000];
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_checked_ok"] forState:UIControlStateNormal];
        }
        NSArray *array=[[DBManager sharedDBManager]recieveDBData];
        for (int i=0; i<array.count; i++)
        {
            if ([_selectedArray[i] isEqualToString:@"1"]) {
                
                
            NSInteger inter1=[array[i][@"price"] integerValue]*[array[i][@"contentNum"] integerValue];
                _allGoodsNum+=[array[i][@"contentNum"] integerValue];
            _moneyCount+=inter1;
                
        }
        }
        _lab1.text=[NSString stringWithFormat:@"应付:￥%.2lf",_moneyCount];
        _lab2.text=[NSString stringWithFormat:@"商品数量:%ld",_allGoodsNum];
        _lab3.text=[NSString stringWithFormat:@"总金额:￥%.2f",_moneyCount];
        _moneyCount=0;
        
    }
    
        
   
    else if(inter==1)
    {
       [btn setBackgroundImage:nil forState:UIControlStateNormal];
        _selectedArray[btn.tag-2000] =[NSString stringWithFormat:@"0"];
        UIButton *btn=(UIButton *)[self.view viewWithTag:3000];
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
        
        NSArray *array=[[DBManager sharedDBManager]recieveDBData];
        for (int i=0; i<array.count; i++)
        {
            if ([_selectedArray[i] isEqualToString:@"1"]) {
                
                
                NSInteger inter1=[array[i][@"price"] integerValue]*[array[i][@"contentNum"] integerValue];
                 _allGoodsNum+=[array[i][@"contentNum"] integerValue];
                _moneyCount+=inter1;
            }
        }
        _lab1.text=[NSString stringWithFormat:@"应付:￥%.2lf",_moneyCount];
        _lab2.text=[NSString stringWithFormat:@"商品数量:%ld",_allGoodsNum];
        _lab3.text=[NSString stringWithFormat:@"总金额:￥%.2f",_moneyCount];
        _moneyCount=0;
        _allGoodsNum=0;
        
    }
    
    
}
-(BOOL)isallColected
{
    NSInteger num=0;
    for (NSString *str in _selectedArray) {
        if ([str isEqualToString:@"1"]) {
            num++;
        }
        
    }
    if (num==_selectedArray.count) {
        return YES;
    }
    else
        return NO;
}
-(void)btnClick:(UIButton *)sender
{
    NSInteger index;
    if (sender.tag<500) {
        index=sender.tag+900;
    }
    else
    {
        index=sender.tag+500;
    }
    UITextField *tf=(UITextField *)[self.view viewWithTag:index];
    NSInteger tfNum=[tf.text integerValue];
    if (sender.tag<500)
    {
        
        if (tfNum>1) {
     
            tfNum--;
            tf.text=[NSString stringWithFormat:@"%ld",tfNum];
            DBManager *manger= [DBManager sharedDBManager];
            NSArray *array=[manger recieveDBData];
            NSDictionary *dic=array[index-1000];
            [manger changeDataWithDictionary:@{@"imageUrl":dic[@"imageUrl"],@"contentNum":[NSString stringWithFormat:@"%ld",tfNum]}];
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            NSArray *array1=[manger recieveDBData];
            for (int i=0; i<array1.count; i++)
            {
                if ([_selectedArray[i] isEqualToString:@"1"]) {
                    
                    
                    NSInteger inter1=[array1[i][@"price"] integerValue]*[array1[i][@"contentNum"] integerValue];
                    _allGoodsNum+=[array1[i][@"contentNum"] integerValue];
                    _moneyCount+=inter1;
                }
            }
            _lab1.text=[NSString stringWithFormat:@"应付:￥%.2lf",_moneyCount];
            _lab2.text=[NSString stringWithFormat:@"商品数量:%ld",_allGoodsNum];
            _lab3.text=[NSString stringWithFormat:@"总金额:￥%.2f",_moneyCount];
            _moneyCount=0;
            _allGoodsNum=0;
            
        

            
        }
        else
        {
            [sender setTitleColor:[UIColor colorWithWhite:0.500 alpha:1.000] forState:UIControlStateNormal];
        }
        
    }
    else if(sender.tag>=500)
    {
        if (tfNum<50) {
            tfNum++;
            tf.text=[NSString stringWithFormat:@"%ld",tfNum];
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            DBManager *manger= [DBManager sharedDBManager];
            NSArray *array=[manger recieveDBData];
            NSDictionary *dic=array[index-1000];
            [manger changeDataWithDictionary:@{@"imageUrl":dic[@"imageUrl"],@"contentNum":[NSString stringWithFormat:@"%ld",tfNum]}];
            NSArray *array1=[manger recieveDBData];
            for (int i=0; i<array1.count; i++)
            {
                if ([_selectedArray[i] isEqualToString:@"1"]) {
                    
                    
                    NSInteger inter1=[array1[i][@"price"] integerValue]*[array1[i][@"contentNum"] integerValue];
                   _allGoodsNum+=[array1[i][@"contentNum"] integerValue];
                    _moneyCount+=inter1;
                }
            }
            _lab1.text=[NSString stringWithFormat:@"应付:￥%.2lf",_moneyCount];
            _lab2.text=[NSString stringWithFormat:@"商品数量:%ld",_allGoodsNum];
            _lab3.text=[NSString stringWithFormat:@"总金额:￥%.2f",_moneyCount];
            _moneyCount=0;
            _allGoodsNum=0;
        }
        else
        {
            [sender setTitleColor:[UIColor colorWithWhite:0.500 alpha:1.000] forState:UIControlStateNormal];
        }

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    DBManager *manger= [DBManager sharedDBManager];
    NSArray *array=[manger recieveDBData];
    NSDictionary *dic=array[textField.tag-1000];
    [manger changeDataWithDictionary:@{@"imageUrl":dic[@"imageUrl"],@"contentNum":textField.text}];
     NSArray *array1=[manger recieveDBData];
    for (int i=0; i<array1.count; i++)
    {
        if ([_selectedArray[i] isEqualToString:@"1"]) {
            
            
            NSInteger inter1=[array1[i][@"price"] integerValue]*[array1[i][@"contentNum"] integerValue];
             _allGoodsNum+=[array1[i][@"contentNum"] integerValue];
            _moneyCount+=inter1;
        }
    }
    _lab1.text=[NSString stringWithFormat:@"应付:￥%.2lf",_moneyCount];
    _lab2.text=[NSString stringWithFormat:@"商品数量:%ld",_allGoodsNum];
    _lab3.text=[NSString stringWithFormat:@"总金额:￥%.2f",_moneyCount];
    _moneyCount=0;
    _allGoodsNum=0;
    

    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
      DBManager *manger=[DBManager sharedDBManager];
        [manger deleteDataWithDictionary:@{@"imageUrl":[manger recieveDBData][indexPath.row][@"imageUrl"]}];
    }
    
    [_selectedArray removeObjectAtIndex:indexPath.row];
    NSArray  *chagedArray=[[DBManager sharedDBManager] recieveDBData];
     _array=chagedArray;
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
  
  
    
    for (int i=0; i<chagedArray.count; i++)
    {
        NSInteger inter=[chagedArray[i][@"price"] integerValue]*[chagedArray[i][@"contentNum"] integerValue];
        _allGoodsNum+=[chagedArray[i][@"contentNum"] integerValue];
        _moneyCount+=inter;
    }
    _lab1.text=[NSString stringWithFormat:@"应付:￥%.2lf",_moneyCount];
   _lab2.text=[NSString stringWithFormat:@"商品数量:%ld",_allGoodsNum];
    _lab3.text=[NSString stringWithFormat:@"总金额:￥%.2f",_moneyCount];
    _moneyCount=0;
    _allGoodsNum=0;
    if (chagedArray.count==0)
    {
        UIButton *btn=(UIButton *)[self.view viewWithTag:3000];
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
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
