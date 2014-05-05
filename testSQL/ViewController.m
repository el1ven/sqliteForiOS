//
//  ViewController.m
//  testSQL
//
//  Created by el1ven on 14-5-5.
//  Copyright (c) 2014年 el1ven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//利用宏定义常量，方便以后使用
#define DBNAME @"personinfo.sqlite"
#define NAME @"name"
#define AGE @"age"
#define ADDRESS @"address"
#define TABLENAME @"PERSONINFO"

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	NSString *path = [[NSHomeDirectory() stringByAppendingString:@"/Documents/"]stringByAppendingPathComponent:DBNAME];//设置数据库的路径

    if(sqlite3_open([path UTF8String], &db)!=SQLITE_OK){//打开数据库，没有就根据路径创建
        sqlite3_close(db);
        NSLog(@"数据库打开失败!");
    }
    
    /*NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS PERSONINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, address TEXT )";
    [self execSql:sqlCreateTable];//创建table
    
    NSString *sql1 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                      TABLENAME, NAME, AGE, ADDRESS, @"张三", @"23", @"西城区"];
    
    NSString *sql2 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                      TABLENAME, NAME, AGE, ADDRESS, @"老六", @"20", @"东城区"];
    
    [self execSql:sql1];//插入数据库
    [self execSql:sql2];
     */
     
    
    NSString *sqlQuery = @"select * from PERSONINFO";
    sqlite3_stmt *statement;//查询数据库
    
    if(sqlite3_prepare(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK){
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *name = (char*)sqlite3_column_text(statement, 1);
            NSString *nsNameStr = [[NSString alloc] initWithUTF8String:name];
            
            int age = sqlite3_column_int(statement, 2);
            
            char *address = (char*)sqlite3_column_text(statement, 3);
            NSString *nsAddressStr = [[NSString alloc]initWithUTF8String:address];
            
            NSLog(@"name:%@ age:%d address:%@",nsNameStr,age,nsAddressStr);//在控制台打印出来
            
            
        }
        
    }
    
    sqlite3_close(db);//记得关闭数据库
    
    
    
    
    
    
    
}

-(void)execSql:(NSString *)sql//可以执行任何sql语句的函数
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], nil, nil, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作失败!");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
