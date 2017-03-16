//
//  WYFoodDetailTableViewCell.m
//  LoveLife
//
//  Created by wangyang on 16/1/4.
//  Copyright © 2016年 王洋. All rights reserved.
//

#import "WYFoodDetailTableViewCell.h"
#import "WYFoodModel.h"
@interface WYFoodDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;


@property (weak, nonatomic) IBOutlet UILabel *detail;


@end



@implementation WYFoodDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(WYFoodDetailModel *)model
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.dishes_step_image]];
    
    
    self.detail.text = model.dishes_step_desc;
    
}



@end
