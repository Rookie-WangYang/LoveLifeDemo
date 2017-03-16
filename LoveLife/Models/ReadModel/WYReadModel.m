//
//  WYReadModel.m
//  LoveLife
//
//  Created by wangyang on 15/12/30.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYReadModel.h"

@implementation WYReadModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.dataID=value;
    }
}

+(WYReadModel *)modelWithDic:(NSDictionary *)dic
{
    WYReadModel * model=[[WYReadModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}


@end
