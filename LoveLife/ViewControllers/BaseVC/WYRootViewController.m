//
//  WYRootViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYRootViewController.h"

@interface WYRootViewController ()



@end

@implementation WYRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建导航栏
    [self createRootNav];
    
    self.view.backgroundColor=[UIColor whiteColor];

    
}

/** 导航栏 */
-(void)createRootNav
{
    //设置导航栏不透明，确保64是从头开始的
    self.navigationController.navigationBar.translucent=NO;
    
    //设置导航栏颜色
    self.navigationController.navigationBar.barTintColor=RGB(255, 156, 187, 1);
    
    //方法一：修改状态栏的颜色:白色
    //有局限性，只能修改继承自rootViewController的页面
//    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    
    //创建左按钮
    self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame=CGRectMake(0, 0, 44, 44);
    [self.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    
    //标题
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.font=[UIFont systemFontOfSize:20];
    self.navigationItem.titleView=self.titleLabel;
    
    //右按钮
    self.rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame=CGRectMake(0, 0, 44, 44);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
}

//左按钮点击事件
-(void)setLeftButtonClick:(SEL)selector
{
    [self.leftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

//右按钮点击事件
-(void)setRightButtonClick:(SEL)selector
{
     [self.rightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}
@end
