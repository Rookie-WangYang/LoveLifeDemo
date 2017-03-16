//
//  CycleImageCell.m
//  iPolice
//
//  Created by 杨阳 on 15/9/5.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "CycleImageCell.h"
#import "UIImageView+WebCache.h"


#define CycleImageCellIdentifier @"CycleImageCell"

@interface CycleImageCell()
@end

@implementation CycleImageCell
-(id)initWithFrame:(CGRect)frame
{
    if ( self == [super initWithFrame:frame])
    {
        [self makeUI];
    }
    return self;
}

-(void)makeUI
{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.contentView addSubview:self.imageView];
}

- (void)setPlaceHolderImageName:(NSString *)placeHolderImageName
{
    _placeHolderImageName = placeHolderImageName;
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    //一句话, 自动实现了异步下载. 图片本地缓存. 网络下载. 自动设置占位符.
    [self.imageView sd_setImageWithURL:self.imageURL placeholderImage:[UIImage imageNamed:_placeHolderImageName]];
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}

//+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
//{
//    [collectionView registerClass:[CycleImageCell class] forCellWithReuseIdentifier:CycleImageCellIdentifier];
//    CycleImageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CycleImageCellIdentifier forIndexPath:indexPath];
//    
//    return cell;
//}

@end
