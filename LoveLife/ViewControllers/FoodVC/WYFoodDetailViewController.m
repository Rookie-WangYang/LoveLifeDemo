//
//  WYFoodDetailViewController.m
//  LoveLife
//
//  Created by wangyang on 16/1/4.
//  Copyright © 2016年 王洋. All rights reserved.
//

#import "WYFoodDetailViewController.h"
#import "WYFoodModel.h"
#import "WYFoodDetailTableViewCell.h"
@interface WYFoodDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIImageView *playImage;


@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UILabel *haha;


@property(nonatomic,strong)NSMutableArray * dataSource;


@end

@implementation WYFoodDetailViewController

-(void)dealloc
{
    //防止滑动时退出时卡死
    _tableView.delegate=nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setValue];
    
    [self loadData];
    
    
}

-(void)loadData
{
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    
    NSDictionary * dic = @{@"dishes_id": self.model.dishes_id, @"methodName": @"DishesView"};
    
    
    [manager POST:FOODURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSArray * array=responseObject[@"data"][@"step"];
        
        for (NSDictionary * dic in array)
        {
            
            WYFoodDetailModel * model=[[WYFoodDetailModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataSource addObject:model];
            
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


/** 设置属性 */
-(void)setValue
{
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_pressed"] forState:0];
    
    [self setLeftButtonClick:@selector(leftButtonClick)];
    self.titleLabel.text = self.model.title;
    
    //设置头视图
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
    
    //设置标题
    self.haha.text = self.model.title;
    
    //设置详情
    self.detailLabel.text = self.model.content;
}

#pragma mark =====tableView=====
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseID=@"reuse";
    
    
    WYFoodDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell)
    {

        cell = [[NSBundle mainBundle]loadNibNamed:@"WYFoodDetailTableViewCell" owner:self options:nil].firstObject;
        
    }
    WYFoodDetailModel * model=self.dataSource[indexPath.row];
    
    cell.model=model;
    
    cell.number.text=[NSString stringWithFormat:@"%zd",indexPath.row+1];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

#pragma mark =====dataSource=====

-(NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
