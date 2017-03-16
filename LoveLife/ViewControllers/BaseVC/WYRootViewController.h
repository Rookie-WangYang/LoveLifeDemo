//
//  WYRootViewController.h
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYRootViewController : UIViewController

/** 左按钮 */
@property(nonatomic,strong)UIButton * leftButton;

/** 标题 */
@property(nonatomic,strong)UILabel * titleLabel;


/** 右按钮 */
@property(nonatomic,strong)UIButton * rightButton;


/** 左按钮点击事件 */
-(void)setLeftButtonClick:(SEL)selector;

/** 右按钮点击事件 */
-(void)setRightButtonClick:(SEL)selector;



@end
