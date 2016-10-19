//
//  dataModel.m
//  address
//
//  Created by strong on 2016/10/10.
//  Copyright © 2016年 strong. All rights reserved.
//

#import "dataModel.h"
#import <MJExtension.h>
@class addressModel;
@implementation dataModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"RECORDS":@"addressModel"};
}
@end
