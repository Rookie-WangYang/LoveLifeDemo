//
//  WYRecordModel.h
//  LoveLife
//
//  Created by wangyang on 15/12/31.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYRecordModel : NSObject

/** id */
@property(nonatomic,copy)NSString * dataId;
/** 标题 */
@property(nonatomic,copy)NSString * publisher_name;
/** 时间 */
@property(nonatomic,copy)NSString * pub_time;
/** 头像 */
@property(nonatomic,copy)NSString * publisher_icon_url;
/** 图片 */
@property(nonatomic,copy)NSString * image_url;
/** 详情 */
@property(nonatomic,copy)NSString * text;

+(WYRecordModel *)initWithDic:(NSDictionary *)dic;

@end
