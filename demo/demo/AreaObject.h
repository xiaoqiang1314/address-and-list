//
//  AreaObject.h
//
//  Created by zhengzeqin on 15/5/28.
//  Copyright (c) 2015年 com.injoinow. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface AreaObject : NSObject


//省名
@property (copy, nonatomic) NSString *province;
//城市名
@property (copy, nonatomic) NSString *city;
//区县名
@property (copy, nonatomic) NSString *area;
/**地址编码*/
@property (nonatomic, copy) NSString *IDCode;

@end
