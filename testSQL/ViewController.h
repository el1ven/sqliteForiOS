//
//  ViewController.h
//  testSQL
//
//  Created by el1ven on 14-5-5.
//  Copyright (c) 2014年 el1ven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController
{
    sqlite3 *db;//创建数据库对象
}

@end
