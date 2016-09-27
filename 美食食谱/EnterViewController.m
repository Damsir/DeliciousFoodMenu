//
//  EnterViewController.m
//  食客天下
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "EnterViewController.h"

@interface EnterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@property (nonatomic,strong)NSMutableArray *userMessage;
@property (nonatomic,strong)  UIAlertController * alert;
@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(identyfiyID)];
    _userMessage =[NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/userMessage.plist",NSHomeDirectory()]];
    NSLog(@"%@",NSHomeDirectory());
    if (_userMessage) {
    _UserName.text=[_userMessage lastObject][@"email"];
    _PassWord.text=[_userMessage lastObject][@"password"];

    }
    
}
-(void)identyfiyID
{
    IdentifyViewController *identy=[[IdentifyViewController alloc] init];
    identy.myBlock=^(NSDictionary *mydic)
    {
        _UserName.text=mydic[@"email"];
        _PassWord.text=mydic[@"password"];
    };
    [self.navigationController pushViewController:identy animated:YES];
}
- (IBAction)enterClick:(id)sender {
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager] ;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
     NSDictionary *parameters = @{@"client_type":@"1",@"client_version":@"2.4.3",@"email":_UserName.text,@"login_type":@"1",@"password":_PassWord.text,@"uuid":@"B0E8CE84-6241-4CDC-8F89-22B061B09832"};
    [manager POST:LOGIN_VERIFY_INFORMATION parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * recieveDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] ;
        //判断登录是否成功，成功则记录用户信息
        NSLog(@"%@",recieveDic);
        if ([[NSString stringWithFormat:@"%@", recieveDic[@"success"]] isEqualToString:@"1"])
        {
            
            _backBlock(parameters);
            [self.navigationController popViewControllerAnimated:YES] ;
            _alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
        }
        
        
        else
        {
           _alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"登录失败,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
        }
        
        [_alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            
        }]];
        [self presentViewController:_alert animated:YES completion:^{
            
        }];


        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }] ;
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
