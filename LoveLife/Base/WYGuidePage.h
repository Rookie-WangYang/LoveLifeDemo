//
//  WYGuidePage.h
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYGuidePage : UIView

@property (nonatomic,strong)UIButton * GoInApp;

//重写父类的方法
-(id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray;

@end
