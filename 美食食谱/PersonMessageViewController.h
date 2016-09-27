//
//  PersonMessageViewController.h
//  食客天下
//
//  Created by qianfeng on 15/12/8.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonMessageViewController : UIViewController
@property (nonatomic,strong)void (^block)(NSDictionary *dic);
@end
