//
//  WYFoodCollectionViewCell.m
//  LoveLife
//
//  Created by wangyang on 15/12/31.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYFoodCollectionViewCell.h"
#import "WYFoodModel.h"



@implementation WYFoodCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self  createUI];
    }
    return self;
}


-(void)setModel:(WYFoodModel *)model
{
    _model= model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    _titleLabel.text = model.title;
    
    _detailLabel .text =model.datail;
}

-(void)createUI
{
    _iconImageView =[FactoryUI createImageViewWithFrame:CGRectMake(10, 10, (WIDTH-60)/2, 130) imageName:nil];
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _iconImageView.frame.size.height+10, (WIDTH-20)/2, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
    
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+5, (WIDTH-20)/2, 15) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:_detailLabel];
    
    _playButton=[FactoryUI createButtonWithFrame:CGRectMake(0, 0, 40, 40) title:nil titleColor:nil imageName:@"" backgroundImageName:nil target:self selector:@selector(playClick)];
    
    [_iconImageView addSubview:_playButton];
}

-(void)playClick
{
    
    if ([_delegate respondsToSelector:@selector(playWithModel:)])
    {
        [_delegate playWithModel:self.model];
    }
    
}

@end
