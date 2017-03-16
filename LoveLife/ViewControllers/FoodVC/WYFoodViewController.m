//
//  WYFoodViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYFoodViewController.h"
#import "NBWaterFlowLayout.h"
#import "WYFoodTitleCollectionViewCell.h"
#import "WYFoodCollectionViewCell.h"
#import "WYFoodModel.h"
#import "WYFoodDetailViewController.h"
//iOS9以下的视频播放，
#import <AVKit/AVKit.h>
#import "AVFoundation/AVFoundation.h"

@interface WYFoodViewController ()<UICollectionViewDelegate,UICollectionViewDelegateWaterFlowLayout,UICollectionViewDataSource,playDelegate>
{
    UICollectionView * _collectionView;
    
    UIView * _lineView;
}

/** 数据源数组 */
@property(nonatomic,strong)NSMutableArray * dataSource;

/** 分页ID */
@property(nonatomic,assign)NSInteger categoryID;

/** 标题 */
@property(nonatomic,copy)NSString * titleStr;

/** 滚动button */
@property(nonatomic,strong)NSMutableArray * buttonArray;

/** page */
@property(nonatomic,assign)NSInteger page;

@end

@implementation WYFoodViewController

-(void)viewWillAppear:(BOOL)animated
{
    for (UIButton * button in self.buttonArray)
    {
        if (button==[self.buttonArray firstObject])
        {
            button.selected=YES;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    [self setNav];
    
    [self createHeaderView];
    
    [self createCollectionView];
    
    [self addRefresh];
}
#pragma mark =====刷新=====
-(void)addRefresh
{
    MJRefreshNormalHeader * header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    _collectionView.header=header;
    
    _collectionView.footer=[MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_collectionView.header beginRefreshing];
    
}

-(void)loadNewData
{
    _page=1;
    [self.dataSource removeAllObjects];
    [self loadData];
}
-(void)loadMoreData
{
    _page++;
    [self loadData];
}

-(void)loadData
{
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    
    NSDictionary * dic = @{@"methodName": @"HomeSerial", @"page": [NSString stringWithFormat:@"%zd",_page], @"serial_id":[NSString stringWithFormat:@"%zd",_categoryID], @"size": @"20"};
    
    [manager POST:FOODURL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
        
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
         if ([responseObject[@"code"]integerValue]==0)
         {
             for (NSDictionary * dic in responseObject[@"data"][@"data"])
             {
                 WYFoodModel * model=[[WYFoodModel alloc]init];
                 
                 [model setValuesForKeysWithDictionary:dic];
                 [self.dataSource addObject:model];
             }
         }
         
         if (_page==1)
         {
             [_collectionView.header endRefreshing];
         }
         else
         {
             [_collectionView.footer endRefreshing];
         }
         
         [_collectionView reloadData];
         
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark =====协议方法=====
/** 创建collectionView */
-(void)createCollectionView
{
    //创建布局对象：使用第三方库重写
    NBWaterFlowLayout * flowLayout=[[NBWaterFlowLayout alloc]init];
    
    //网格的大小
    flowLayout.itemSize=CGSizeMake((WIDTH-20)/2, 150);
    
    //设置列数
    flowLayout.numberOfColumns = 2;
    
    //代理
    flowLayout.delegate=self;
    
    //创建网格对象
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 45, WIDTH, HEIGHT-40) collectionViewLayout:flowLayout];
    
    //代理
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    
    //背景颜色
    _collectionView.backgroundColor=[UIColor whiteColor];
    
    //注册cell
    [_collectionView registerClass:[WYFoodCollectionViewCell class] forCellWithReuseIdentifier:@"WYFoodCollectionViewCell"];
    
    [_collectionView registerClass:[WYFoodTitleCollectionViewCell class] forCellWithReuseIdentifier:@"WYFoodTitleCollectionViewCell"];
    
    [self.view addSubview:_collectionView];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource ? self.dataSource.count+1:0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        //标题
        WYFoodTitleCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"WYFoodTitleCollectionViewCell" forIndexPath:indexPath];
        
        //赋值
        cell.titleLabel.text=_titleStr;

        return cell;
    }
    else
    {
        //正文
        WYFoodCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"WYFoodCollectionViewCell" forIndexPath:indexPath];
        
        cell.delegate=self;
        
        if (self.dataSource)
        {
            WYFoodModel * model=self.dataSource[indexPath.row-1];
            
            cell.model=model;
        }
        return cell;
    }

}

//跳转到详情页面
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WYFoodModel * model=self.dataSource[indexPath.row];
    
    WYFoodDetailViewController * detail = [[WYFoodDetailViewController alloc]init];
    
    detail.model=model;
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
}

#pragma mark =====AVPalyer=====
-(void)playWithModel:(WYFoodModel *)model
{
    //初始化播放器
    AVPlayerViewController * player=[[AVPlayerViewController alloc]init];
    
    //设置播放资源
    AVPlayer * avPlayer=[AVPlayer playerWithURL:[NSURL URLWithString:model.video]];
    
    
    player.player = avPlayer;
    [self presentViewController:player animated:YES completion:nil];
}

//返回高度
-(CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(NBWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 30;
    }
    else
        return 160;
}

/** 初始化数据 */
-(void)initData
{
    _categoryID = 1;
    
    _titleStr = @"家常菜";
    
    _buttonArray = [NSMutableArray array];
}

/** 设置导航 */
-(void)setNav
{
    self.titleLabel.text=@"美食";
}

/** 初始化头部分类按钮 */
-(void)createHeaderView
{
    NSArray * titleArray =@[@"家常菜",@"小炒",@"凉菜",@"烘焙"];
    
    UIView * bgView=[FactoryUI createViewWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    
    bgView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:bgView];
    
    //创建button
    for (int i =0; i<titleArray.count; i++)
    {
        UIButton * button =[FactoryUI createButtonWithFrame:CGRectMake(i*(WIDTH/4), 0, WIDTH/4, 40) title:titleArray[i] titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(headerButton:)];
        
        //结合selected属性使用，上方页面即将出现
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        button.tag = 100+i;
        
        [bgView addSubview:button];
        
        //添加到数组中
        [_buttonArray addObject:button];
    }
    
    //创建指示条
    _lineView = [FactoryUI createViewWithFrame:CGRectMake(0, 38, WIDTH/4, 2)];
    
    _lineView.backgroundColor=[UIColor redColor];
    
    [bgView addSubview:_lineView];
    
    
}
-(void)headerButton:(UIButton *)button
{
    
    [UIView animateWithDuration:0.3 animations:^{
       
        _lineView.frame = CGRectMake((button.tag-100)*WIDTH/4, 38, WIDTH/4, 2);
    }];
    
    //保证每次点击只选中一个按钮
    for (UIButton * button in self.buttonArray)
    {
        if (button.selected==YES)
        {
            button.selected=NO;
            
        }
    }
    button.selected=YES;
    
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
