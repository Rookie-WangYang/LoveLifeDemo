//
//  AppDelegate.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "AppDelegate.h"
#import "WYMyTableViewController.h"
#import "WYGuidePage.h"
#import "WYLeftViewController.h"
#import "MMDrawerController.h"

#import "WXApi.h"
#import "WXApiManager.h"
#import "WXApiObject.h"

#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"

#define isRuned @"1"

@interface AppDelegate ()

@property(nonatomic,strong)WYMyTableViewController * MyTable;

@property(nonatomic,strong)WYGuidePage * GuidePage;

@end

@implementation AppDelegate


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    application.applicationIconBadgeNumber=0;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    //设置window
    [self createWindow];
    
    //修改状态栏颜色
    [self setNavColor];
    
    //设置tabbar
    [self createTabBar];
    
    //添加引导页
    [self createGuidePage];
    
    //设置RootViewController
    [self createRootViewController];
    
    //添加友盟分享
    [self addUMShare];
    
    //注册微信支付
    [WXApi registerApp:@"wx12b249bcbf753e87" withDescription:@"WXPay"];
  
    return YES;
}
#pragma mark =====微信支付=====
//通过URL调起我们自己的应用时，传递数据
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

//回调函数：处理支付完成之后，微信返回的结果
-(void)onResp:(BaseResp*)resp
{
    //返回的错误码
    NSString * strMessage = [NSString stringWithFormat:@"%d",resp.errCode];
    
    switch (resp.errCode)
    {
        case 0:
        {
            //支付成功
            strMessage = @"支付结果:成功";
            break;
        }
        case -1:
        {
            //支付失败
            strMessage = @"支付结果:失败";
            break;
        }
        case -2:
        {
            //放弃支付
            strMessage = @"支付结果:放弃支付";
            break;
        }
        
        default:
            break;
    }
}



#pragma mark =====友盟分享=====
/** 添加友盟分享 */
-(void)addUMShare
{
    //注册友盟分享
    [UMSocialData setAppKey:UMShareKEY];
    
    //设置QQ的appID，appKey和url
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:nil];
    
    //设置微信的appID，appKey，Url
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    
    //打开微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
    //隐藏未安装的客户端
    //针对于QQ与微信
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
}
//修改状态栏颜色
-(void)setNavColor
{
    //第一步：修改状态栏的颜色:白色
    //第二步：infoPlist添加字段：最后一个
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}
//设置rootViewController
-(void)createRootViewController
{
    
    WYLeftViewController * left=[[WYLeftViewController alloc]init];
    
    //抽屉
    MMDrawerController * DrawerVC = [[MMDrawerController alloc]initWithCenterViewController:self.MyTable leftDrawerViewController:left];
    
    //设置抽屉打开和关闭的模式：会引起手势冲突
    DrawerVC.openDrawerGestureModeMask=MMOpenDrawerGestureModeAll;
    DrawerVC.closeDrawerGestureModeMask=MMCloseDrawerGestureModeAll;
    
    //设置左页面打开之后的宽度
    DrawerVC.maximumLeftDrawerWidth=WIDTH - 200;
    
    self.window.rootViewController = DrawerVC;
    
}
//设置window
-(void)createWindow
{
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    self.window.backgroundColor=[UIColor whiteColor];
    
    
    [self.window makeKeyAndVisible];
    
}

//创建tabbar
-(void)createTabBar
{
    self.MyTable =[[WYMyTableViewController alloc]init];
}

//添加引导页
-(void)createGuidePage
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:isRuned])
    {
        
        //初始化
        NSArray * imageArray=@[@"welcome1",@"welcome2",@"welcome3",@"welcome4",@"welcome5"];
        
        self.GuidePage =[[WYGuidePage alloc]initWithFrame:self.window.bounds ImageArray:imageArray];
        
        [self.MyTable.view addSubview:self.GuidePage];
        
        //第一次运行完成之后进行记录
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:isRuned];
    }
    
    [self.GuidePage.GoInApp addTarget:self action:@selector(GoInAppClick) forControlEvents:UIControlEventTouchUpInside];
    
}

//点击进入App，移除
-(void)GoInAppClick
{
    [self.GuidePage removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
