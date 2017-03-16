//
//  WYMyTableViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYMyTableViewController.h"
#import "WYReadViewController.h"
#import "WYMyViewController.h"
#import "WYHomeViewController.h"
#import "WYFoodViewController.h"
#import "WYMusicViewController.h"

@interface WYMyTableViewController ()

@end

@implementation WYMyTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createViewControllers];
    
    [self createTabBarItem];
}

-(void)createViewControllers
{
    //实例化子页面
    
    //首页
    UINavigationController * Home =[[UINavigationController alloc]initWithRootViewController:[[WYHomeViewController alloc]init]];
    
    //阅读
    UINavigationController * Read = [[UINavigationController alloc]initWithRootViewController:[[WYReadViewController alloc]init]];
    
    //美食
    UINavigationController * Food = [[UINavigationController alloc]initWithRootViewController:[[WYFoodViewController alloc]init]];
    
    //音乐
    UINavigationController * Music = [[UINavigationController alloc]initWithRootViewController:[[WYMusicViewController alloc]init]];
    
    //我的
    UINavigationController * My=[[UINavigationController alloc]initWithRootViewController:[[WYMyViewController alloc]init]];
    
    //添加到ViewController
    self.viewControllers=@[Home,Read,Food,Music,My];
}

-(void)createTabBarItem
{
    //未选中的图片
    NSArray * unSelectedImageNames=@[@"ic_tab_home_normal@2x",@"ic_tab_category_normal@2x",@"iconfont-iconfontmeishi",@"health",@"ic_tab_profile_normal_female@2x"];
    
    //选中时的图片
    NSArray * SelectedImageNames=@[@"ic_tab_home_selected@2x",@"ic_tab_category_selected@2x",@"iconfont-iconfontmeishi-2",@"health2",@"ic_tab_profile_selected_female@2x"];
    
    //标题
    NSArray * titleArray = @[@"首页",@"阅读",@"美食",@"音乐",@"我的"];
    
    
    //循环赋值
    for (int i =0; i<unSelectedImageNames.count; i++)
    {
        UIImage * unSelectedImage=[UIImage imageNamed:unSelectedImageNames[i]];
        
        //原色处理
        unSelectedImage = [unSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage * selectedImage = [UIImage imageNamed:SelectedImageNames[i]];
        
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //获取Item并且赋值
        UITabBarItem * item = self.tabBar.items[i];
        
        item = [item initWithTitle:titleArray[i] image:unSelectedImage selectedImage:selectedImage];
    }
    
    //设置选中时的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    
}


@end
