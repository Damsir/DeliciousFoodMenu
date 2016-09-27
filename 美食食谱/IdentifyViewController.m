//
//  IdentifyViewController.m
//  食客天下
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "IdentifyViewController.h"

@interface IdentifyViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *IDNum;
@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (nonatomic,strong)NSMutableArray *messageArray;
@property (nonatomic,strong)  UIAlertController * alert;
@end

@implementation IdentifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=@"注册";
    _email.tag=100;
    _email.delegate=self;
    _messageArray=[NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/userMessage.plist",NSHomeDirectory()]];
    if (!_messageArray) {
        _messageArray=[NSMutableArray array];
    }
    
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==100) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return YES;
}
-(void)keyBoardShow:(NSNotification *)notify
    {
        NSLog(@"通知来了");
        CGRect bounds = self.view.bounds;
        if(bounds.origin.y < 100)
        {
            bounds.origin.y += 100;
        }
        self.view.bounds = bounds;
    }
    
-(void)keyBoardHidden:(NSNotification *)notify
    {
        CGRect bounds = self.view.bounds;
        if(bounds.origin.y >= 100)
        {
            bounds.origin.y -= 100;
        }
        self.view.bounds = bounds;
    }
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)IdentityUsers:(id)sender {
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"client_type":@"1",@"client_version":@"2.4.3",@"email":_email.text,@"nickname":_UserName.text,@"password":_PassWord.text,@"uuid":@"B0E8CE84-6241-4CDC-8F89-22B061B09832"};
    
    __weak typeof (&*self)weakself=self;
    [manager POST:REGISTER parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([[NSString stringWithFormat:@"%@", dic[@"success"]] isEqualToString:@"1"])
        {
         _alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
        }
        else
        {
       _alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"注册失败,请重新注册" preferredStyle:UIAlertControllerStyleAlert];
            
        }
        
        [_alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
            
            if ([[NSString stringWithFormat:@"%@", dic[@"success"]] isEqualToString:@"1"])
            {
                [_messageArray addObject:parameters];
                
                [_messageArray writeToFile:[NSString stringWithFormat:@"%@/Documents/userMessage.plist",NSHomeDirectory()] atomically:YES];
                _myBlock(parameters);
                [weakself.navigationController popViewControllerAnimated:YES];
                
            }

            
        }]];
        [weakself presentViewController:_alert animated:YES completion:^{
            
            
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    
    
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
