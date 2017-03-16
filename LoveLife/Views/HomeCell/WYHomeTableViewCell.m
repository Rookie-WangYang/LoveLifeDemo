//
//  WYHomeTableViewCell.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYHomeTableViewCell.h"

@interface WYHomeTableViewCell ()

@property(nonatomic,strong)UIImageView * ImageView;

@property(nonatomic,strong)UILabel * label;

@end


@implementation WYHomeTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _label=[FactoryUI createLabelWithFrame:CGRectMake(10, 10, WIDTH-20, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:18]];
    
    [self.contentView addSubview:_label];
    
    _ImageView =[FactoryUI createImageViewWithFrame:CGRectMake(10, _label.frame.size.height+_label.frame.origin.y+10, WIDTH-20, 150) imageName:nil];
    [self.contentView addSubview:_ImageView];
    
}

-(void)setModel:(WYHomeModel *)model
{
    [_ImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]placeholderImage:[UIImage imageNamed:@""]];
    
    _label.text=model.title;
}




- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
