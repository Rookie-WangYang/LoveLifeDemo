//
//  WYFoodCollectionViewCell.h
//  LoveLife
//
//  Created by wangyang on 15/12/31.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYFoodModel;


@protocol playDelegate <NSObject>

-(void)playWithModel:(WYFoodModel *)model;

@end

@interface WYFoodCollectionViewCell : UICollectionViewCell
{
    UIImageView * _iconImageView;
    UIButton * _playButton;
    UILabel * _titleLabel;
    UILabel * _detailLabel;
}
@property(nonatomic,strong)WYFoodModel * model;


//声明一个代理的对象，代理修饰符用weak，主要是为了防止循环引用导致的内存泄露，ARC下得strong和weak就相当于MRC下得retain和assin
@property(nonatomic,weak)id<playDelegate>delegate;

@end
