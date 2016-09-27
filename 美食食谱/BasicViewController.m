//
//  BasicViewController.m
//  美食食谱
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BasicViewController.h"
#import "AppDelegate.h"
@interface BasicViewController ()<UIApplicationDelegate>
@property (nonatomic,strong)UIBarButtonItem *item2;

@end

@implementation BasicViewController
-(void)viewWillAppear:(BOOL)animated
{
    NSString *str1=[NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/string.plist",NSHomeDirectory()] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@/Documents/string.plist",NSHomeDirectory());
   _item2.title=str1;
    
    
   
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dtz2"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoDw)];
    _item2=[[UIBarButtonItem alloc] init];
    self.navigationItem.leftBarButtonItems=@[item1,_item2];
    UIApplicationShortcutItem * itemy = [[UIApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"打开应用" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:nil];
    UIApplicationShortcutItem * itemx = [[UIApplicationShortcutItem alloc]initWithType:@"one" localizedTitle:@"定位" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
    UIApplicationShortcutItem *itemz=[[UIApplicationShortcutItem alloc] initWithType:@"three" localizedTitle:@"分享应用"];
    [UIApplication sharedApplication].shortcutItems = @[itemx,itemy,itemz];
   
  
    
}
 -(void)gotoDw
{
    DwViewController *dw=[[DwViewController alloc] init];
    [self.navigationController pushViewController:dw animated:YES];
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
