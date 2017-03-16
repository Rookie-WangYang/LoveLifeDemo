//
//  WYFoodModel.m
//  LoveLife
//
//  Created by wangyang on 15/12/31.
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "WYFoodModel.h"

@implementation WYFoodModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"])
    {
        self.datail=value;
    }
}

@end


@implementation WYFoodDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
