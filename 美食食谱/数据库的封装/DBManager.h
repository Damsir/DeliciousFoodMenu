//
//  DBManager.h
//  数据库的封装
//
//  Created by smith on 15/11/4.
//  Copyright © 2015年 smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

+ (instancetype)sharedDBManager ;
//插入一条数据
- (BOOL)insertDataWithDictionary:(NSDictionary *)dataDic ;
//删除一条数据
- (BOOL)deleteDataWithDictionary:(NSDictionary *)dataDic ;
//修改数据
- (BOOL)changeDataWithDictionary:(NSDictionary *)dataDic ;

//查询所有数据
- (NSArray *)recieveDBData ;
@end
