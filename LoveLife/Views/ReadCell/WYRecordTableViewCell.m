//
//  WYRecordTableViewCell.m
//  LoveLife
//
//  Created by wangyang on 15/12/31.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYRecordTableViewCell.h"
#import "WYRecordModel.h"
@interface WYRecordTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end

@implementation WYRecordTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setModel:(WYRecordModel *)model
{
    _model=model;
    
    self.time.text=model.pub_time;
    
    [self.photo sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    
    self.title.text=model.publisher_name;
    
    self.icon.layer.cornerRadius=30;
    self.icon.layer.borderWidth=0.2;
    self.icon.layer.masksToBounds=YES;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.publisher_icon_url]];
    
    
    self.desc.text=model.text;
    
}

@end
