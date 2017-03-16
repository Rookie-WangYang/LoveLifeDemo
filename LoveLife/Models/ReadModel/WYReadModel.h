//
//  WYReadModel.h
//  LoveLife
//
//  Created by wangyang on 15/12/30.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYReadModel : NSObject

/** 作者 */
@property(nonatomic,copy)NSString * author;

/** 日期 */
@property(nonatomic,copy)NSString * createtime;

/** id */
@property(nonatomic,copy)NSString * dataID;

/** 图片 */
@property(nonatomic,copy)NSString * pic;

/** 标题*/
@property(nonatomic,copy)NSString * title;


+(WYReadModel *)modelWithDic:(NSDictionary *)dic;

@end
