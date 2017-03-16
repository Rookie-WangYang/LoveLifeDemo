//
//  WYReadViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYReadViewController.h"

#import "WYRecordViewController.h"
#import "WYArticalViewController.h"

@interface WYReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UISegmentedControl * _segment;
}

@end

@implementation WYReadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置Nav
    [self setNav];
    
    //创建UI
    [self createUI];
}
#pragma mark =====创建UI=====
-(void)createUI
{
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _scrollView.delegate=self;
    
    //分页
    _scrollView.pagingEnabled=YES;
    
    //内容大小
    _scrollView.contentSize=CGSizeMake(WIDTH*2, 0);
    
    _scrollView.showsVerticalScrollIndicator=NO;
    
    //隐藏滚动条
    _scrollView.showsHorizontalScrollIndicator=NO;
    
    [self.view addSubview:_scrollView];
    
    //实例化子控制器
    WYArticalViewController * artical =[[WYArticalViewController alloc]init];
    
    WYRecordViewController * record= [[WYRecordViewController alloc]init];
    
    NSArray * array = @[artical,record];
    
    //滚动式框架
#pragma mark ======滚动式框架======
    
    int i =0;
    for (UIViewController * vc in array)
    {
        vc.view .frame =CGRectMake(i * WIDTH, 0, WIDTH, HEIGHT);
        
        [self addChildViewController:vc];
        
        [_scrollView addSubview:vc.view];
        
        i++;
    }
}

#pragma mark =====设置Nav=====
-(void)setNav
{
    //创建segment
    //前三个坐标没用
    _segment=[[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 0, 25)];
    
    //插入标题
    [_segment insertSegmentWithTitle:@"美文" atIndex:0 animated:YES];
    
    [_segment insertSegmentWithTitle:@"语录" atIndex:1 animated:YES];
    
    //字体颜色
    _segment.tintColor=[UIColor whiteColor];
    
    //设置默认选中的按钮
    _segment.selectedSegmentIndex=0;
    
    [_segment addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView=_segment;
    
}
/** segment切换 */
-(void)changeClick:(UISegmentedControl *)segment
{
//    if(segment.selectedSegmentIndex==1)
//    {
//        _scrollView.contentOffset=CGPointMake(WIDTH, 0);
//        NSLog(@"语录");
//    }
//    if (segment.selectedSegmentIndex==0)
//    {
//        _scrollView.contentOffset=CGPointMake(0, 0);
//        NSLog(@"美文");
//    }
//    
    _scrollView.contentOffset = CGPointMake(segment.selectedSegmentIndex*WIDTH, 0);
}

/** scrollView切换 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger index = scrollView.contentOffset.x/WIDTH;
    
    _segment.selectedSegmentIndex=index;
}



@end
