//
//  WYMyViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYMyViewController.h"
#import "AppDelegate.h"
#import "WYLoveViewController.h"
#import "WYLoginViewController.h"
@interface WYMyViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    UITableView * _tableView;
    UIImageView * _headerImageView;
    //夜间模式
    UIView * _darkView;
}

@property(nonatomic,strong)NSArray * iconArray;

@property(nonatomic,strong)NSArray * titleArray;

@end

@implementation WYMyViewController

static float headerImageOriginHeighe = 200;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNav];
    
    _darkView=[[UIView alloc]initWithFrame:self.view.bounds];
    
    [self createUI];
    
    self.iconArray = @[@"iconfont-iconfontaixinyizhan",@"iconfont-lajitong",@"iconfont-yejianmoshi",@"iconfont-zhengguiicon40",@"iconfont-guanyu"];
    
    self.titleArray = @[@"我的收藏",@"清理缓存",@"夜间模式",@"推送消息",@"关于"];
    
}
/** 创建导航栏 */
-(void)setNav
{
    self.titleLabel.text = @"我的";
    [self.rightButton setTitle:@"登陆" forState:0];
    
    [self setRightButtonClick:@selector(rightButtonClick)];
}

-(void)rightButtonClick
{
    WYLoginViewController * login = [[WYLoginViewController alloc]init];
    
    [self.navigationController pushViewController:login animated:YES];
}

/** 创建UI */
-(void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView=[[UIView alloc]init];
    
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, -headerImageOriginHeighe,WIDTH , headerImageOriginHeighe) imageName:@"welcome1"];
    
    [_tableView addSubview:_headerImageView];
    
    //设置tableView的内容从imageOriginal显示
    _tableView.contentInset=UIEdgeInsetsMake(headerImageOriginHeighe, 0, 0, 0);
    
    
   
  
}


#pragma mark =====tableView=====
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        if (indexPath.row==0|indexPath.row==1|indexPath.row==4)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==2|indexPath.row==3)
        {
            UISwitch * switcher = [[UISwitch alloc]initWithFrame:CGRectMake(WIDTH-60, 5, 50, 30)];
            //设置颜色
            switcher.onTintColor= [UIColor greenColor];
            switcher.tag=indexPath.row+100;
            [switcher addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:switcher];
        }
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.imageView.image=[UIImage imageNamed:self.iconArray[indexPath.row]];
    
    
    cell.textLabel.text=self.titleArray[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {

        WYLoveViewController * love =[[WYLoveViewController alloc]init];
        [self.navigationController pushViewController:love animated:YES];
    
    }
    if (indexPath.row==1)
    {
        //清理缓存
        [self folderSizeWithPath:[self getPath]];
        
    }
}


-(void)changeValue:(UISwitch *)switcher
{
    switch (switcher.tag-100)
    {

            
        case 2:
        {
            //夜间模式
            if (switcher.on)
            {
                AppDelegate * app=[UIApplication sharedApplication].delegate;
                
                //设置View的背景色
                _darkView.backgroundColor=[UIColor blackColor];
                
                _darkView.alpha=0.5;
                
                [app.window addSubview:_darkView];
                //关掉View的交互
                _darkView.userInteractionEnabled=NO;
            }
            
            else
            {
                [_darkView removeFromSuperview];
            }
            break;

        }
            case 3:
        {
            if (switcher.on)
            {
                //创建本地推送任务
                [self createLocalNotification];
                
            }
            else
            {
                //取消推送任务
                [self cancelNotification];
                
            }
            
            break;
        }
            case 4:
        {
            
            
            break;
        }
        default:
            break;
    }
    
}
/** 创建本地推送任务 */
-(void)createLocalNotification
{
    /** 解决iOS8之后推送无法接受到推送消息的问题 */
    float systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    
    if (systemVersion>=8.0)
    {
        //设置推送消息的类型
        UIUserNotificationType type = UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound;
        
        //将类型添加到设置里
        UIUserNotificationSettings * settings=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        
        //将设置内容注册到系统管理里面
        [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
        
//        
//        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    
    //初始化本地推送
    UILocalNotification * localNotification = [[UILocalNotification alloc]init];
    
    //设置从当前开始什么时候开始推送
    localNotification.fireDate=[NSDate dateWithTimeIntervalSinceNow:5];
    
    //需要推送的重复周期
    localNotification.repeatInterval = NSCalendarUnitDay;
    
    //设置推送的时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    //设置推送的内容
    localNotification.alertBody = @"你好久没来爱生活了，快看看更新的内容吧";
    
    //推送音效:不设置有默认
    localNotification.soundName = @"";
    
    //设置提示消息的个数
    localNotification.applicationIconBadgeNumber=1;
    
    //将推送添加到
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
}
-(void)cancelNotification
{
    //直接取消全部的推送任务
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    
    //取消指定条件下的推送任务
    NSArray * array = [[UIApplication sharedApplication]scheduledLocalNotifications];
    
    for (UILocalNotification * noti in array)
    {
        if ([noti.alertBody isEqualToString:@"你好久没来爱生活了，快看看更新的内容吧"])
        {
            [[UIApplication sharedApplication]cancelLocalNotification:noti];
            //取消推送任务后重置数值
            [UIApplication sharedApplication].applicationIconBadgeNumber=0;
            
        }
    }
}


#pragma mark =====清除缓存=====
//计算缓存文件的大小
//首先获取缓存文件的路径
-(NSString *)getPath
{
    //缓存文件是存在于沙盒目录下library文件夹下的cache文件夹
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return path;
}
-(CGFloat)folderSizeWithPath:(NSString *)path
{
    //初始化一个文件管理类
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    CGFloat folderSize = 0.0;
    
    //如果文件夹存在 计算大小
    if ([fileManager fileExistsAtPath:path])
    {
        //获取文件下下的文件路径
        NSArray * fileArray = [fileManager subpathsAtPath:path];
        
        for (NSString * file in fileArray)
        {
            //获取子文件
            NSString * subFile=[path stringByAppendingPathComponent:file];
            
            long fileSize = [fileManager attributesOfItemAtPath:subFile error:nil].fileSize;
            
           folderSize+=fileSize/1024.0/1024.0;
        }
        //删除文件
        [self showTipView:folderSize];
        return folderSize;
    }
    
    return 0;
    
}
-(void)showTipView:(CGFloat)folderSize
{
    if (folderSize>0.01)
    {
        //提示用户清除缓存
        UIAlertView * alere=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存为%.2fM,是否清除",folderSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alere  show];
        return;
    }
    else
    {
        UIAlertView * alere=[[UIAlertView alloc]initWithTitle:@"提示" message:@"缓存已清除"delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alere  show];
        return;
    }
}
/** 清除缓存 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        //彻底删除
        [self clearCacheWithPath:[self getPath]];
    }
}
-(void)clearCacheWithPath:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray * subFile = [fileManager subpathsAtPath:path];
        for (NSString * fileName in subFile)
        {
            //如有需要，可以过滤掉不想删除的文件
            if ([fileName hasSuffix:@".mp4"])
            {
                NSLog(@"不删除");
                return;
            }
            else
            {
                NSString * absolutePath = [path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
        }
    }
}




#pragma mark =====scrollView=====
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //实现思路:通过改变scrollView的偏移量，来改变图片的frame
    if (scrollView==_tableView)
    {
        //获取偏移量
        
        CGFloat y = scrollView.contentOffset.y;
        
        CGFloat x = (y + headerImageOriginHeighe)/2;
        
        if (y<-headerImageOriginHeighe)
        {
            CGRect rect = _headerImageView.frame;
            rect.origin.y = y;
            rect.size.height = -y;
            rect.origin.x = x;
            rect.size.width=WIDTH+fabs(x)*2;
            _headerImageView . frame=rect;
        }
        
    }
    
}


@end
