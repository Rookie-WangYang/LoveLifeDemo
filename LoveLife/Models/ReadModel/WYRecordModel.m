//
//  WYRecordModel.m
//  LoveLife
//
//  Created by wangyang on 15/12/31.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYRecordModel.h"

@implementation WYRecordModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.dataId=value;
    }
    if ([key isEqualToString:@"image_urls"])
    {
        value=(NSArray *)value;
        self.image_url=[value firstObject][@"middle"];
    }
}

+(WYRecordModel *)initWithDic:(NSDictionary *)dic
{
    WYRecordModel * model=[[WYRecordModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dic];

     return model;
}
@end
