//
//  WYHomeDetailViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/30.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYHomeDetailViewController.h"
#import "WXApi.h"
@interface WYHomeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    //头部图片
    UIImageView * _headImageView;
    //头部文字
    UILabel * _headTitle;
}
//商品数据
@property(nonatomic,strong)NSDictionary * goodsDic;

//头部视图的数据
@property(nonatomic,strong)NSMutableDictionary * dataDic;

//tableView的数据
@property(nonatomic,strong)NSMutableArray * dataSource;

@end

@implementation WYHomeDetailViewController
//界面出现时
-(void)viewWillAppear:(BOOL)animated
{
    //判断用户是否安装微信客户端
    if ([WXApi isWXAppInstalled])
    {
        //监听支付的结果
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getOederResult:) name:@"success" object:nil];
    }
}
//退出页面移除监听
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //自定制导航栏
    [self customNav];
    
    //创建UI
    [self createUI];
    
    //下载数据
    [self loadData];
    
}
#pragma mark =====数据=====
-(void)loadData
{
    self.dataDic = [NSMutableDictionary dictionary];
    
    self.dataSource=[NSMutableArray array];
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    

    [manager GET:[NSString stringWithFormat:    HOMEDETAIL,[self.dataID intValue]] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //头部视图的数据
        self.dataDic=responseObject [@"data"];
        
        //tableView的数据
        self.dataSource=responseObject[@"data"][@"product"];
        
        //刷新界面
        [self reloadHeaderData];
        [_tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

/** 刷新头视图 */
-(void)reloadHeaderData
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"pic"]]];
    
    _headTitle.text=self.dataDic[@"desc"];
    
    float height=[_headTitle.text boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    
}


#pragma mark =====创建tableView=====
-(void)createUI
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];

    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    
    //头部控件
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/3)];
    
    _tableView.tableHeaderView=_headImageView;
    
    
    //文字
//    _headTitle = [FactoryUI createLabelWithFrame:CGRectMake(0, CGRectGetHeight(_headImageView.frame)-60, WIDTH, 60) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14]];
    
    _headTitle = [FactoryUI createLabelWithFrame:CGRectZero text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14]];
    
    _headTitle.numberOfLines=0;
    
    
    [_tableView.tableHeaderView addSubview:_headTitle];
}

#pragma mark =====协议方法=====
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section][@"pic"]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseID= @"reuse id";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
        UIImageView * imageView=[FactoryUI createImageViewWithFrame:CGRectMake(10, 10, WIDTH-20, 200) imageName:nil];
        
        imageView . tag =100;
        
        [cell.contentView addSubview:imageView];
        
    }
    
    UIImageView * imageView=(UIImageView *)[cell.contentView viewWithTag:100];
    
    if (self.dataSource)
    {
        NSArray * sectionArray = self.dataSource[indexPath.section][@"pic"];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:sectionArray[indexPath.row][@"pic"]]];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

//每个section的header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * backView=[FactoryUI createViewWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    
    backView .backgroundColor =[UIColor whiteColor];
    
    //索引
    UILabel * indexLabel =[FactoryUI createLabelWithFrame:CGRectMake(10, 10, 40, 40) text:[NSString stringWithFormat:@"%zd",section+1] textColor:RGB(255, 156, 187, 1) font:[UIFont systemFontOfSize:16]];
    
    indexLabel.layer.borderColor = RGB(255, 156, 187, 1).CGColor;
    
    indexLabel.textAlignment=NSTextAlignmentCenter;
    
    indexLabel.layer.borderWidth=2;
    
    [backView addSubview:indexLabel];
    
    
    //标题
    UILabel * titleLabel=[FactoryUI createLabelWithFrame:CGRectMake(CGRectGetMaxY(indexLabel.frame)+10, 10, 250, 40) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
    
    titleLabel.text=self.dataSource[section][@"title"];
    
    //左对齐
    titleLabel.textAlignment=NSTextAlignmentLeft;
    
    [backView addSubview:titleLabel];
    
    
    //价格
    UIButton * button=[FactoryUI createButtonWithFrame:CGRectMake(WIDTH-60, 10, 60, 40) title:nil titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(payClick)];
    
    [button setTitle:[NSString stringWithFormat:@"￥%@",self.dataSource[section][@"price"]] forState:0];

    button.titleLabel.font=[UIFont systemFontOfSize:14];
    
    
    self.goodsDic = self.dataSource[section];

    
    [backView addSubview:button];
    
    
    return backView;
}

#pragma mark =====跳转支付=====
-(void)payClick
{
    if([WXApi isWXAppInstalled])
    {
        NSLog(@"支付成功");
    }
    else
    {
        NSLog(@"lalalalal ~");
    }
    
}
//支付结果
-(void)getOederResult:(NSNotification *)noti
{
    if([noti.object isEqualToString:@"success"])
    {
        NSLog(@"支付成功");
    }
    else
    {
        NSLog(@"支付失败");
    }
}



#pragma mark =====自定制Nav=====
-(void)customNav
{
    self.titleLabel.text=@"详情";
    
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_pressed"] forState:0];
    
    [self setLeftButtonClick:@selector(leftButtonClick)];
}
/** 左按钮返回事件 */
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
