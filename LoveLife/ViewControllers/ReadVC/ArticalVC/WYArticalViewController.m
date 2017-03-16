//
//  WYArticalViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/30.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYArticalViewController.h"
#import "WYReadModel.h"
#import "WYReadTableViewCell.h"
#import "WYArticalDetailViewController.h"

@interface WYArticalViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@property(nonatomic,strong)NSMutableArray * dataSource;

@property(nonatomic,assign)NSInteger page;

@end

@implementation WYArticalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
   
    [self addRefresh];
}
/** 下载数据 */
-(void)addRefresh
{
    MJRefreshNormalHeader * header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerLoad)];
    
    _tableView.header = header;
    
    MJRefreshAutoNormalFooter * footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footLoad)];
    
    _tableView.footer=footer;
    
    [_tableView.header beginRefreshing];
    
}
/** 下拉刷新 */
-(void)headerLoad
{
    [self.dataSource removeAllObjects];
    _page=0;
    [self loadData];
}
/** 上拉加载 */
-(void)footLoad
{
    _page++;
    [self loadData];
}
/** 下载数据 */
-(void)loadData
{
    AFHTTPSessionManager * manager= [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",nil];
    
    [manager GET:[NSString stringWithFormat:ARTICALURL,_page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSArray * array =responseObject[@"data"];
        
        for (NSDictionary * dic in array)
        {
            WYReadModel * model=[WYReadModel modelWithDic:dic];
            
            [self.dataSource addObject:model];

        }
        
        if (_page==0)
        {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
        
        [_tableView reloadData];

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

/** 创建界面 */
-(void)createUI
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [_tableView registerClass:[WYReadTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    [self.view addSubview:_tableView];
}

#pragma mark =====协议方法=====
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseID=@"reuse";
    
    WYReadTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
//    
//    if (cell==nil)
//    {
//        cell=[[WYReadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
//    }
    
    WYReadModel * model=self.dataSource[indexPath.row];
    
    cell.model=model;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

//给cell添加一个动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的动画效果为3D效果
    cell.layer.transform=CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView  animateWithDuration:1 animations:^{
        
        cell.layer .transform=CATransform3DMakeScale(1, 1, 1);
    }];
    
}


/** 跳转到详情页面 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYArticalDetailViewController * detail = [[WYArticalDetailViewController alloc]init];
    
    detail.hidesBottomBarWhenPushed=YES;
    
    
    detail.model=self.dataSource[indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}







#pragma mark =====数据源懒加载=====
-(NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}
@end
