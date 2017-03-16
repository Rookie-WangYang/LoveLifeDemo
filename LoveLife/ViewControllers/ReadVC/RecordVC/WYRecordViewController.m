//
//  WYRecordViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/30.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYRecordViewController.h"

#import "WYRecordTableViewCell.h"

#import "WYRecordModel.h"

@interface WYRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@property(nonatomic,strong)NSMutableArray * dataSource;

@property(nonatomic,assign)NSInteger page;

@end

@implementation WYRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];

    [self addRefresh];
}
-(void)addRefresh
{
    _tableView.header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    _tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_tableView.header beginRefreshing];
}
-(void)loadNewData
{
    [self.dataSource removeAllObjects];
    _page=1;
    [self loadData];
}
-(void)loadMoreData
{
    _page++;
    [self loadData];
}
-(void)loadData
{
    AFHTTPSessionManager  * manager=[AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:UTTERANCEURL,_page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        
        for (NSDictionary * dic in responseObject[@"content"])
        {
            WYRecordModel * model=[WYRecordModel initWithDic:dic];
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


-(void)createUI
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
}
#pragma mark =====tableView协议方法=====
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYRecordTableViewCell * cell=[[NSBundle mainBundle]loadNibNamed:@"WYRecordTableViewCell" owner:self options:nil].firstObject;
    
    WYRecordModel * model=self.dataSource[indexPath.row];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.model=model;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYRecordModel * model=self.dataSource[indexPath.row];
    
    float height=[model.text boundingRectWithSize:CGSizeMake(304,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    
    //
    
    return 300+height;
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
