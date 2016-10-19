//
//  addressModel.m
//  address
//
//  Created by strong on 16/10/10.
//  Copyright © 2016年 strong. All rights reserved.
//

#import "addressModel.h"
#import <MJExtension.h>
@implementation addressModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
