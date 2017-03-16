//
//  WYGuidePage.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYGuidePage.h"

@interface WYGuidePage ()

@property(nonatomic,strong)UIScrollView * scrollView;

@end

@implementation WYGuidePage

-(id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray
{
    if (self=[super initWithFrame:frame])
    {
        _scrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT+64)];
        
        //设置分页
        _scrollView.pagingEnabled=YES;
        
        //设置显示的内容
        _scrollView.contentSize=CGSizeMake(imageArray.count*WIDTH, HEIGHT+64);

        [self addSubview:_scrollView];
        
        for (int i =0; i<imageArray.count; i++)
        {
            UIImageView * imageView=[FactoryUI createImageViewWithFrame:CGRectMake(i*WIDTH, 0, WIDTH, HEIGHT+64) imageName:imageArray[i]];
            [_scrollView addSubview:imageView];
            
            if (i==imageArray.count-1)
            {
                self.GoInApp =[UIButton buttonWithType:UIButtonTypeCustom];
                
                self.GoInApp.frame = CGRectMake(100, 100, 50, 50);
                
                [self.GoInApp setImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
                imageView.userInteractionEnabled=YES;
                [imageView addSubview:self.GoInApp];
            }
        }
    }
    return self;
}

@end
