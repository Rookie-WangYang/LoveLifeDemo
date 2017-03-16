//
//  WYHomeModel.h
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYHomeModel : NSObject

@property(nonatomic,copy)NSString * title;

@property(nonatomic,copy)NSString * pic;

@property (nonatomic,copy)NSString * dataID;

-(WYHomeModel *)modelWithDic:(NSDictionary *)dic;

@end
