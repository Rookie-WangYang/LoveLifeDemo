//
//  WYHomeModel.m
//  LoveLife
//
//  Created by wangyang on 15/12/29.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYHomeModel.h"

@implementation WYHomeModel

//防崩溃，当ID和id相同，转换
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.dataID = value;
    }
}

-(WYHomeModel *)modelWithDic:(NSDictionary *)dic
{
    WYHomeModel * model=[[WYHomeModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}
@end
