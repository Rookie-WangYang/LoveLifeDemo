//
//  WYFoodDetailTableViewCell.h
//  LoveLife
//
//  Created by wangyang on 16/1/4.
//  Copyright © 2016年 王洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYFoodDetailModel;
@interface WYFoodDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *number;


@property(nonatomic,strong)WYFoodDetailModel * model;

@end
