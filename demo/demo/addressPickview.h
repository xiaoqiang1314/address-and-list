//
//  addressPickview.h
//  demo
//
//  Created by strong on 16/10/13.
//  Copyright © 2016年 strong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AreaObject;
//typedef void (^blockName) (NSString *province,NSString *city,NSString *town);
typedef void (^blockName) (AreaObject *block);
@interface addressPickview : UIView
/**block属性*/
@property (copy ,nonatomic) blockName block;

+ (instancetype)shareInstance;
@end
