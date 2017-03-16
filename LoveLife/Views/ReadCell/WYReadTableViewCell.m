//
//  WYReadTableViewCell.m
//  LoveLife
//
//  Created by wangyang on 15/12/30.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYReadTableViewCell.h"
#import "WYReadModel.h"
@interface WYReadTableViewCell ()

@property(nonatomic,strong)UIImageView * icon;

@property(nonatomic,strong)UILabel * time;

@property(nonatomic,strong)UILabel * title;

@property(nonatomic,strong)UILabel * auther;


@end

@implementation WYReadTableViewCell


-(void)setModel:(WYReadModel *)model
{
    _model=model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    self.title.text=model.title;
    
    self.time.text=model.createtime;
    
    self.auther.text=model.author;
    
}


#pragma mark =====懒加载=====
-(UIImageView *)icon
{
    if (!_icon)
    {
        _icon=[[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 120, 90)];
        [self.contentView addSubview:_icon];
    }
    return _icon;
}

-(UILabel *)time
{
    if (!_time)
    {
        _time=[[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(self.icon.frame)+10, 160, 20)];

        _time.textAlignment=NSTextAlignmentLeft;
        
        _time.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:_time];
    }
    return _time;
}
-(UILabel *)auther
{
    if (!_auther)
    {
        _auther=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH -120, CGRectGetMaxY(self.icon.frame)+10, 110, 20)];
        
        _auther.font=[UIFont systemFontOfSize:15];
        
        _auther.textAlignment=NSTextAlignmentRight;
        
        [self.contentView addSubview:_auther];
    }
    return _auther;
}


-(UILabel *)title
{
    if (!_title)
    {
        _title=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+8, 30, WIDTH-CGRectGetMaxX(self.icon.frame)-20, 60)];
        
        _title.numberOfLines =0;
        
        _title.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:_title];
    }
    return _title;
}




- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
