//
//  WYLoveViewController.m
//  LoveLife
//
//  Created by wangyang on 16/1/6.
//  Copyright © 2016年 王洋. All rights reserved.
//

#import "WYLoveViewController.h"
#import "WYReadModel.h"
#import "WYReadTableViewCell.h"
#import "DBManager.h"
#import "WYArticalDetailViewController.h"
@interface WYLoveViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@property(nonatomic,strong)NSMutableArray * dataSource;
@end

@implementation WYLoveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self createNav];
    
    [self createTableView];
    
    [self loadData];
    
}
-(void)loadData
{
    self.dataSource = [[DBManager defaultManager]getData];

    [_tableView reloadData];
}

-(void)createNav
{
    self.titleLabel.text=@"我的收藏";
    
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_pressed"] forState:0];
    [self setLeftButtonClick:@selector(leftButtonClick:)];
}

-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYReadTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil)
    {
        cell=[[WYReadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    WYReadModel * model=self.dataSource[indexPath.row];
    
    cell.model=model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYArticalDetailViewController * detail = [[WYArticalDetailViewController alloc]init];
    
    detail.model=self.dataSource[indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark =====滑动删除=====
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除：先删除数据库中的数据，删除界面的cell，刷新界面
    DBManager * manager=[DBManager defaultManager];
    
    WYReadModel * model =self.dataSource[indexPath.row];
    
    [manager deleteNameFromTable:model.dataID];
    
    [self loadData];
}




@end
