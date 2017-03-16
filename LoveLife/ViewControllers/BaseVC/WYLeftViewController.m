//
//  WYLeftViewController.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYLeftViewController.h"

@interface WYLeftViewController ()

{
    UIImageView * _headerIamgeView;
    UILabel * _label;
    
}

@end

@implementation WYLeftViewController
-(void)viewWillAppear:(BOOL)animated
{
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    [_headerIamgeView sd_setImageWithURL:[NSURL URLWithString:[user objectForKey:@"iconURL"]]];
    
    _label.text = [user objectForKey:@"userName"];
    
    _label.textAlignment=NSTextAlignmentCenter;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=RGB(255, 156, 187, 1);
    
    _headerIamgeView=[FactoryUI createImageViewWithFrame:CGRectMake((WIDTH-80-100)/2, 80, 80, 80) imageName:nil];
    
    _headerIamgeView.layer.cornerRadius = 40;
    
    _headerIamgeView.layer.masksToBounds=YES;
    
    [self.view addSubview:_headerIamgeView];
    
    //昵称
    _label = [FactoryUI createLabelWithFrame:CGRectMake(0, _headerIamgeView.frame.size.height, WIDTH-100, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18]];
    
    [self.view addSubview:_label];
    
 
    
}









@end
