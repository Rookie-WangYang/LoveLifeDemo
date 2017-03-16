//
//  CycleImageCell.h
//  iPolice
//
//  Created by 杨阳 on 15/9/5.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CycleImageCell : UICollectionViewCell

@property (nonatomic, strong) NSString *placeHolderImageName;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSString *imageName;

@property (nonatomic,strong) UIImageView * imageView;

/**
 *  快速创建一个cell
 *
 *  @param collectionView 哪个collectionView
 *  @param indexPath      collectionView的哪个cell
 *
 *  @return 一个创建好的cell
 */
//+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
