//
//  WYMusicDetailViewController.m
//  LoveLife
//
//  Created by wangyang on 16/1/4.
//  Copyright © 2016年 王洋. All rights reserved.
//

#import "WYMusicDetailViewController.h"
#import "MBProgressHUD.h"
#import "WYMusicModel.h"
#import "WYMusicModel.h"
#import "WYMusicTableViewCell.h"
@interface WYMusicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    MBProgressHUD * _hud;
    NSInteger page;
}

@property(nonatomic,strong)NSMutableArray * dataSource;
@end

@implementation WYMusicDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self createNav];
    [self createTableView];
    [self createRefresh];
}
-(void)createRefresh
{
    _tableView.footer = [MJRefreshAutoNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
-(void)loadMoreData
{
    page++;
    [self loadData];
}
-(void)loadData
{
    [_hud show:YES];
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",nil];
    
    [manager GET:self.urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        for (NSDictionary * dic in responseObject[@"data"])
        {
            WYMusicModel * model=[[WYMusicModel alloc]init];

            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataSource addObject:model];
            
        }
        
        [_tableView.footer endRefreshing];
        [_hud hide:YES];
        [_tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/** 设置导航 */
-(void)createNav
{
    self.titleLabel.text=self.typeString;
    [self.leftButton setImage:[UIImage imageNamed:@""] forState:0];
    
    [self setLeftButtonClick:@selector(leftButtonClock)];
}
-(void)leftButtonClock
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    _hud=[[MBProgressHUD alloc]initWithView:self.view];
    
    _hud.labelText=@"正在加载...";
    
    //背景颜色
    _hud.backgroundColor=[UIColor colorWithWhite:1 alpha:0.2];
    
    //指示器颜色
    _hud.activityIndicatorColor=[UIColor whiteColor];
    
    [self.view addSubview:_hud];
}

#pragma mark =====tableView=====
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseID=@"reuse";
    
    WYMusicTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell)
    {
        cell=[[WYMusicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    if(self.dataSource)
    {
        WYMusicModel * model=self.dataSource[indexPath.row];
        cell.model=model;
    }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}





@end
