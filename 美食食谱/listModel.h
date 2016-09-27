//
//  listModel.h
//  食客天下
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listModel : NSObject
@property (nonatomic, copy) NSString *site_url;
@property (nonatomic, copy) NSString *activity_id;
@property (nonatomic, copy) NSString *dividend_start_time;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, strong) NSNumber *shop_price;
@property (nonatomic, strong) NSNumber *discount;
@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *vgn;
@property (nonatomic, copy) NSString *cat_name;
@property (nonatomic, copy) NSString *dividend_price;
@property (nonatomic, strong) NSNumber *shop_price_org;
@property (nonatomic, strong) NSNumber *promote_price;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, strong) NSNumber *seller_number;
@property (nonatomic, copy) NSString *dividend_end_time;
@property (nonatomic, copy) NSString *brand_name;
@property (nonatomic, copy) NSString *list_url;
@property (nonatomic, copy) NSString *seller_note;
@property (nonatomic, strong) NSNumber *soldout;
@property (nonatomic, copy) NSString *praise;
@property (nonatomic, strong) NSNumber *is_promote;
@end
