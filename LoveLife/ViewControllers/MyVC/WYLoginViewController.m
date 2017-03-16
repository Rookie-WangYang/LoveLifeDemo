//
//  WYLoginViewController.m
//  LoveLife
//
//  Created by wangyang on 16/1/6.
//  Copyright © 2016年 王洋. All rights reserved.
//

#import "WYLoginViewController.h"

@interface WYLoginViewController ()

@end

@implementation WYLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self createUI];

}
-(void)createUI
{

    NSArray * buttonArray = @[@"sina",@"qq",@"weixin.jpg"];
    
    for (int i =0; i<buttonArray.count; i++)
    {
        UIButton * button = [FactoryUI createButtonWithFrame:CGRectMake(20+i*WIDTH/3, 200, 50, 50) title:nil titleColor:nil imageName:buttonArray[i] backgroundImageName:nil target:self selector:@selector(buttonClick:)];
        
        [self.view addSubview:button];
        
        button .tag = 300+i;
    }
}

-(void)buttonClick:(UIButton *)button
{
    switch (button.tag-300)
    {
        case 0:
        {
            //新浪微博
            //指定第三方登陆平台
            UMSocialSnsPlatform * platform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            
            //点击之后的回调函数
            platform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * entity)
            {
                //获取用户信息
                if (entity.responseCode==UMSResponseCodeSuccess)
                {
                    //获取得到的用户信息
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    
                    //保存数据
                    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                    [user setObject:snsAccount.userName forKey:@"userName"];
                    
                    [user setObject:snsAccount.iconURL forKey:@"iconURL"];
                    
                    //拿到需要的信息 返回上级页面
                    [self.navigationController popViewControllerAnimated:YES];

                }
                
                
            });
            
            
            break;
        }
            case 1:
        {
            
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
            
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                //获取用户名和token等
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
                    
                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                }});

            
            
            break;
        }
            case 2:
        {
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
            
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                //获取用户名和token等
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
                    
                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                }});

            
            break;
        }
        default:
            break;
    }
    
    

    
}



@end
