//
//  WYMusicViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYMusicViewController.h"
#import "WYMusicCollectionReusableView.h"
#import "WYMusicCollectionViewCell.h"
#import "WYMusicDetailViewController.h"
@interface WYMusicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    UICollectionView * _collectionView;

}
@property(nonatomic,strong)NSArray * nameArray;
@property(nonatomic,strong)NSArray * urlArray;
@property(nonatomic,strong)NSArray * imageArray;

@end

@implementation WYMusicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self initArray];
    
    [self createUI];
}
/** 初始化数据 */
-(void)initArray
{
    self.nameArray = @[@"流行",@"新歌",@"华语",@"英语",@"日语",@"轻音乐",@"民谣",@"韩语",@"歌曲排行榜"];
    self.urlArray = @[liuxing,xinge,huayu,yingyu,riyu,qingyinyue,minyao,hanyu,paihangbang];
    self.imageArray = @[@"shili0",@"shili1",@"shili2",@"shili8",@"shili10",@"shili19",@"shili15",@"shili13",@"shili24"];
}
/** 创建UI */
-(void)createUI
{
    //创建网格布局对象
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建网格对象
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:flowLayout];
    
    //注册cell
    [_collectionView registerClass:[WYMusicCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    
    //注册header
    [_collectionView registerClass:[WYMusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view"];
    
    [_collectionView registerClass:[WYMusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"view"];

    _collectionView.backgroundColor=[UIColor whiteColor];
    
    
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    
    [self.view addSubview:_collectionView];
}
#pragma mark =====代理协议方法=====
/** 确定Section的个数 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
/** 确定每个section的Item的个数 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
/** 创建cell */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseID=@"reuse";
    
    WYMusicCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    
    [cell.imageView setImage:[UIImage imageNamed:self.imageArray[indexPath.item]]];
    
    cell.title.text=self.nameArray[indexPath.item];
    
    return cell;
}
/** 设置cell的大小 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WIDTH-20)/2, 150);
}
/** 设置垂直的间距 :默认为10*/
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
/** 设置水平间距 */
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
/** 返回四周的间距 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
/** 设置header的大小 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(60, 30);
}
/** 设置footer的大小 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(60, 30);
}
/** header和footer的View */
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WYMusicCollectionReusableView * view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"view" forIndexPath:indexPath];
    
    //分别给header和footer赋值
    if (kind == UICollectionElementKindSectionHeader)
    {
        view.title.text=@"头";
    }
    if (kind==UICollectionElementKindSectionFooter)
    {
        view.title.text=@"尾";
    }
    
    
    return view;
}

/** 跳转 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WYMusicDetailViewController * detail =[[WYMusicDetailViewController alloc]init];
    
    detail.hidesBottomBarWhenPushed=YES;
    
    detail.urlString=self.urlArray[indexPath.row];
    
    detail.typeString=self.nameArray[indexPath.item];
    
    [self.navigationController  pushViewController:detail animated:YES];
}



@end
