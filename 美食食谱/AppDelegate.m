//
//  AppDelegate.m
//  美食食谱
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
//#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"


@interface AppDelegate ()
@property (nonatomic,strong)DwViewController *dw;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    NSLog(@"xxxxxxxxxxx%@",[launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey]);
    [UMSocialData setAppKey:@"565fde64e0f55adda6001a7b"];
    [UMSocialWechatHandler setWXAppId:@"wx73c9a4083c1bce8e" appSecret:@"278d34f28158775fd58c45e09155932c" url:@"http://weibo.com/u/3119709301/home?topnav=1&wvr=6"];
    
  
    return YES;
}


-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{

    if ([shortcutItem.type isEqualToString:@"one"])
    {
        DwViewController *vc=[[DwViewController alloc]init];
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        view.backgroundColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
        [vc.view addSubview:view];
        [vc.view bringSubviewToFront:view];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame=CGRectMake(10, 27, 30, 30);
        [btn setBackgroundImage:[UIImage imageNamed:@"ButtonBack2_Pressed"] forState:UIControlStateNormal];
        [view addSubview:btn];
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 20, 60, 30)];
        lab.text=@"定位";
        lab.textColor=[UIColor whiteColor];
        lab.textAlignment=NSTextAlignmentCenter;
        [view addSubview:lab];
        [btn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
        _dw=vc;
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
        
        
    }
    if ([shortcutItem.type isEqualToString:@"two"])
    {
        
        
        
    }
    
}

-(void)btnClik:(UIButton *)btn
{
    [_dw dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [UMSocialSnsService handleOpenURL:url];
}
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//    }
//    return result;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
