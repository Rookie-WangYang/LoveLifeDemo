//
//  WYMusicTableViewCell.m
//  LoveLife
//
//  Created by wangyang on 16/1/4.
//  Copyright © 2016年 王洋. All rights reserved.
//

#import "WYMusicTableViewCell.h"
#import "WYMusicModel.h"
@interface WYMusicTableViewCell ()

{
    UIImageView * _imageView;
    UILabel * _author;
    UILabel * _name;
}

@end

@implementation WYMusicTableViewCell

-(void)setModel:(WYMusicModel *)model
{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 100, 70) imageName:nil];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverURL]];
    [self.contentView addSubview:_imageView];
    
    
    _name=[FactoryUI createLabelWithFrame:CGRectMake(50, 60, 100, 100) text:nil textColor:nil font:[UIFont systemFontOfSize:15]];
    _name .text = model.title;
    
    [self.contentView addSubview:_name];
    
    
    _author = [FactoryUI createLabelWithFrame:CGRectMake(100, 100, 100, 100) text:nil textColor:nil font:[UIFont systemFontOfSize:15]];
    
    _author.text=model.artist;
    
    [self.contentView addSubview:_author];

    
    
}





- (void)awakeFromNib {
    // Initialization code
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
