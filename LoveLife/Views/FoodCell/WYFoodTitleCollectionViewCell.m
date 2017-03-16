//
//  WYFoodTitleCollectionViewCell.m
//  LoveLife
//
//  Created by wangyang on 15/12/31.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYFoodTitleCollectionViewCell.h"

@implementation WYFoodTitleCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.titleLabel=[FactoryUI createLabelWithFrame:CGRectMake(10, 10, (WIDTH-60)/2, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:20]];
        
        self.titleLabel.backgroundColor=RGB(255, 156, 187, 1);
        
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}


@end
