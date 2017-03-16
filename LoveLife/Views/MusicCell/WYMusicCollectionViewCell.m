//
//  WYMusicCollectionViewCell.m
//  LoveLife
//
//  Created by wangyang on 16/1/4.
//  Copyright © 2016年 王洋. All rights reserved.
//

#import "WYMusicCollectionViewCell.h"

@implementation WYMusicCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    self.imageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) imageName:nil];
    
    [self.contentView addSubview:self.imageView];
    
    self.title=[FactoryUI createLabelWithFrame:CGRectMake(0, 0, self.imageView.frame.size.width, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
    
    self.title.center=self.imageView.center;
    self.title.textAlignment=NSTextAlignmentCenter;
    
    [self.imageView addSubview:self.title];
    
    
}


@end
