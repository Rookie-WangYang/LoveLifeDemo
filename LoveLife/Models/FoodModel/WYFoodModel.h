//
//  WYFoodModel.h
//  LoveLife
//
//  Created by wangyang on 15/12/31.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYFoodModel : NSObject

@property(nonatomic,copy)NSString * dishes_id;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * datail;
@property(nonatomic,copy)NSString * image;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * video;


@end

@interface WYFoodDetailModel : NSObject



//详情
@property(nonatomic,copy)NSString * dishes_step_desc;
//图片
@property(nonatomic,copy)NSString * dishes_step_image;

//序号
@property(nonatomic,copy)NSString * dishes_step_order;




@end
