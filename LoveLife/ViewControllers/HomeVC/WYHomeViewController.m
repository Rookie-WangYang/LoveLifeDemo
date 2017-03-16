//
//  WYHomeViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYHomeViewController.h"
#import "WYHomeModel.h"
#import "WYHomeTableViewCell.h"
#import "WYHomeDetailViewController.h"

//打开抽屉 :类别
#import "UIViewController+MMDrawerController.h"

//二维码扫描
#import "CustomViewController.h"

//广告轮播
#import "Carousel.h"

@interface WYHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

//轮播视图
@property(nonatomic,strong)Carousel * carousel;

//tableView
@property(nonatomic,strong)UITableView * tableView;

//分页
@property(nonatomic,assign)NSInteger page;

//数据源数组
@property(nonatomic,strong)NSMutableArray * dataSource;

@end

@implementation WYHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏
    [self createNav];
    
    //创建tableViewHeader
    [self createTableHeaderView];
    
    //创建tableView
    [self createTableView];
    
    //创建刷新
    [self createRefresh];
}
#pragma mark =====下载数据=====
-(void)createRefresh
{
    //上拉加载
    _tableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerLoad)];
    
    //下拉刷新
    _tableView.footer =[MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footLoad)];
    
    //程序启动时自动刷新一次
    [_tableView.header beginRefreshing];
}
/** headerLoad & footLoad */
-(void)headerLoad
{
    [self.dataSource removeAllObjects];
    _page=1;
    [self loadData];
}
-(void)footLoad
{
    _page++;
    [self loadData];
}


/** 请求数据 */
-(void)loadData
{
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:HOMEURL,_page] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (NSDictionary * dic in responseObject[@"data"][@"topic"])
        {
            WYHomeModel * model=[[WYHomeModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataSource addObject:model];
        }
        if (_page==1)
        {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        
    }];
    
}



#pragma mark =====tableView=====
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    //修改分割线：两种方法
//    _tableView.separatorColor =[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //去掉多余的线条
    _tableView.tableFooterView=[[UIView alloc]init];

    
    _tableView.tableHeaderView=_carousel;
    
    [self.view addSubview:_tableView];
}

#pragma mark =====tableView的协议方法=====
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseId = @"reuse id";
    
    WYHomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell==nil)
    {
        cell =[[WYHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    if (self.dataSource)
    {
        WYHomeModel * model=self.dataSource[indexPath.row];
        cell.model=model;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYHomeDetailViewController * homeDetail=[[WYHomeDetailViewController alloc]init];
    
    //隐藏tabbar两种方式：
    //第一种：
    homeDetail.hidesBottomBarWhenPushed=YES;
    //第二种是在Detail界面即将出现的时候隐藏
    
    WYHomeModel * model= self.dataSource[indexPath.row];
    
    homeDetail.dataID =model.dataID;
    
    [self.navigationController pushViewController:homeDetail animated:YES];

}


#pragma mark =====设置tableViewHeader=====
-(void)createTableHeaderView
{
    _carousel=[[Carousel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/3)];
    
    //设置是否需要pageController
    _carousel.needPageControl=YES;
    
    //设置是否需要无限轮播
    _carousel.infiniteLoop=YES;
    
    //设置pageController的位置
    _carousel.pageControlPositionType=PAGE_CONTROL_POSITION_TYPE_MIDDLE;
    
    //设置轮播的图片数组,本地使用ImageArray，网络使用imageUrlArray，注意：必须先请求下来图片
    
    //设置手动点击
    _carousel.imageArray=@[@"shili8",@"shili2",@"shili10",@"shili13"];
    
}






#pragma mark =====设置导航=====
/** 设置导航栏 */
-(void)createNav
{
    self.titleLabel.text = @"爱生活";
    
    //navLeftItem
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function"] forState:UIControlStateNormal];
    
    //navRightItem
    [self.rightButton setImage:[UIImage imageNamed:@"2vm"] forState:UIControlStateNormal];
    
    //设置响应事件
    [self setLeftButtonClick:@selector(leftButtonClick)];
    
    [self setRightButtonClick:@selector(rightButtonClick)];
}

/** 左按钮：打开抽屉 */
-(void)leftButtonClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

/** 右按钮：二维码扫描 */
-(void)rightButtonClick
{
    //第一个参数：YES-》关闭二维码扫描，只扫描条形码
    //第二个参数：result:结果 isSucceed：
    CustomViewController * VC = [[CustomViewController alloc]initWithIsQRCode:NO Block:^(NSString *result, BOOL isSucceed)
    {
        if (isSucceed)
        {
            NSLog(@"%@",result);
        }
        
    }];
    //跳转
    [self presentViewController:VC animated:YES completion:^{
        
    }];
}

#pragma mark =====懒加载=====
-(NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

@end
