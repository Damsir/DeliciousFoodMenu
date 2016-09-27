//
//  DBManager.m
//  数据库的封装
//
//  Created by smith on 15/11/4.
//  Copyright © 2015年 smith. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

static DBManager * _db ;

@implementation DBManager
{
    //数据库类
    FMDatabase * _fmdb ;
}

+ (instancetype)sharedDBManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_db)
        {
            _db = [[DBManager alloc] init] ;
        }
    });
    return _db ;
}

- (instancetype)init
{
    if (self = [super init])
    {
        //我们初始化一个数据的时候，我们需要给数据库一个沙盒路径进行永久保存,存储在Documents目录下
        NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/appsb.db"] ;
        NSLog(@"%@",path) ;
        //通过接收一个路径来创建数据可
        _fmdb = [FMDatabase databaseWithPath:path] ;
        
        BOOL isSuccess =  [_fmdb open] ;
        //判断数据库是否创建成功
        if (isSuccess)
        {
            //数据库语言，sqlite语句，创建一张数据库表格
            //@"create table if not exists 表名(参数名 varchar(32),参数名 varchar(128),参数名 varchar(1024))"
            
            NSString * sql = @"create table if not exists appdsb(imageUrl varchar(1024),dtailDescrip varchar(1024),price varchar(128),contentNum varchar(32))" ;
            BOOL tableSuccedd = [_fmdb executeUpdate:sql] ;
            
            if (tableSuccedd)
            {
                NSLog(@"表格创建成功") ;
            }
            else
            {
                NSLog(@"表格创建失败") ;
            }

            NSLog(@"数据库创建成功") ;
        }
        else
        {
            NSLog(@"数据库创建失败:%@",_fmdb.lastErrorMessage) ;
        }
        
        
    }
    return self ;
}


- (BOOL)insertDataWithDictionary:(NSDictionary *)dataDic
{
    /*增insert into 表名 (applicationId,name,iconUrl) values (?,?,?)*/
    
    NSString * sql = @"insert into appdsb (imageUrl,dtailDescrip ,price,contentNum) values (?,?,?,?)" ;
    //插入一条数据
    BOOL success = [_fmdb executeUpdate:sql,dataDic[@"imageUrl"],dataDic[@"dtailDescrip"],dataDic[@"price"],dataDic[@"contentNum"]] ;
    
    if (success)
    {
        NSLog(@"插入成功") ;
    }
    else
    {
        NSLog(@"插入失败:%@",_fmdb.lastErrorMessage) ;
    }
    return success ;
}

- (BOOL)deleteDataWithDictionary:(NSDictionary *)dataDic
{
    /*删delete from 表名 where applicationId = ?*/
    
    NSString * sql = @"delete from appdsb where imageUrl = ?" ;
    
    BOOL success = [_fmdb executeUpdate:sql,dataDic[@"imageUrl"]] ;
    
    if (success)
    {
        NSLog(@"删除成功") ;
    }
    else
    {
        NSLog(@"删除失败:%@",_fmdb.lastErrorMessage) ;
    }
    
    return success ;
}

- (BOOL)changeDataWithDictionary:(NSDictionary *)dataDic
{
    
    /*改  update 表名 set 属性名 = ? where applicationId = ?*/
    
    NSString * sql = @"update appdsb set contentNum = ? where imageUrl = ?" ;
    
    BOOL success = [_fmdb executeUpdate:sql,dataDic[@"contentNum"],dataDic[@"imageUrl"]] ;
    
    if (success)
    {
        NSLog(@"修改成功") ;
    }
    else
    {
        NSLog(@"修改失败:%@",_fmdb.lastErrorMessage) ;
    }
    
    return success ;
}

- (BOOL)searchOneDataWithDictionary:(NSDictionary *)dataDic
{
    
    /*查询某一个是否存在select applicationId from 表名 where applicationId = ?*/
    NSString * sql = @"select applicationId from appdsb where imageUrl = ?" ;
    
    FMResultSet * set =   [_fmdb executeQuery:sql,dataDic[@"imageUrl"]] ;
    
    BOOL success = [set next] ;
    
    if (success)
    {
        NSLog(@"查询成功") ;
    }
    else
    {
        NSLog(@"查询失败%@",_fmdb.lastErrorMessage) ;
    }
    
    return success ;
}

- (NSArray *)recieveDBData
{
    /* 查询所有的数据select * from 表名 */
    
    NSString * sql = @"select * from appdsb" ;
    
    FMResultSet * set = [_fmdb executeQuery:sql] ;
    
    NSMutableArray * array = [NSMutableArray array] ;
    
    while ([set next])
    {
        NSDictionary * dic = [set resultDictionary] ;
        [array addObject:dic] ;
    }
    
    return array ;
}









@end
