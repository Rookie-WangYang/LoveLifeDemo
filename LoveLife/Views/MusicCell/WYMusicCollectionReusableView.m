//
//  WYMusicCollectionReusableView.m
//  LoveLife
//
//  Created by wangyang on 16/1/4.
//  Copyright © 2016年 王洋. All rights reserved.
//

#import "WYMusicCollectionReusableView.h"

@implementation WYMusicCollectionReusableView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.title=[FactoryUI createLabelWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) text:nil textColor:nil font:[UIFont systemFontOfSize:15]];
        [self addSubview:self.title];
    }
    return self;
}

@end
