
//
//  WYArticalDetailViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/30.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYArticalDetailViewController.h"
#import "WYReadModel.h"
#import "DBManager.h"

@interface WYArticalDetailViewController ()

@end

@implementation WYArticalDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createNav];
    
    [self createUI];
}
//再次进入页面时，收藏过的按钮保持收藏状态
-(void)viewWillAppear:(BOOL)animated
{
    DBManager * manager= [DBManager defaultManager];
    
    if ([manager isHasDataIDFromTable:self.model.dataID])
    {
        UIButton * button = [(UIButton *)self.view viewWithTag:100];
        
        button.selected=YES;
    }
    
    
}


/** 创建UI */
-(void)createUI
{
    UIWebView * webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
//    webView.opaque=NO;
    
    //loadHtmlString加载的是类似标签式的字符串
    //loadRequest加载的是网址
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.model.dataID]]]];
    
    //使得webView适配屏幕大小
    webView.scalesPageToFit=YES;
    
    //webView与javaScript的交互
    
    [self.view addSubview:webView];
    
    //收藏按钮
    UIButton * button = [FactoryUI createButtonWithFrame:CGRectMake(WIDTH-50, 80, 40, 40) title:nil titleColor:nil imageName:@"iconfont-iconfontshoucang" backgroundImageName:nil target:self selector:@selector(loveClick:)];
    
    button.tag=100;
    
    [button setImage:[UIImage imageNamed:@"iconfont-iconfontshoucang-2"] forState:UIControlStateSelected];
    
    [self.view addSubview:button];
    
}
/** 收藏 */
-(void)loveClick:(UIButton *)button
{
    button.selected=YES;
    DBManager * manager=[DBManager defaultManager];
    
    if ([manager isHasDataIDFromTable:self.model.dataID])
    {
        //说明已经收藏过
//        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"已经收藏" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        
        UIAlertController * alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"已经收藏" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [manager insertDataModel:self.model];
    }
}

/** 设置NAV */
-(void)createNav
{
    self.titleLabel.text=@"美文详情";
    
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_pressed"] forState:0];
    
    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-fenxiang"] forState:0];
    
    [self setLeftButtonClick:@selector(leftButtonClick)];
    
    [self setRightButtonClick:@selector(rightButtonClick)];
    
}

#pragma mark =====按钮事件=====
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 分享 */
-(void)rightButtonClick
{
    //下载网络图片
    UIImage * image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pic]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMShareKEY shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.model.dataID] shareImage:image shareToSnsNames:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToRenren] delegate:nil];
}



@end
