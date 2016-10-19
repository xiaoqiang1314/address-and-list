//
//  addressModel.h
//  address
//
//  Created by strong on 16/10/10.
//  Copyright © 2016年 strong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addressModel : NSObject
/**父类地址编码*/
@property (copy ,nonatomic) NSString *parent_id;
/**地址编码*/
@property (copy ,nonatomic) NSString *ad_code;

/**父类地址pid*/
@property (nonatomic, copy) NSString *pid;
/**地址id*/
@property (nonatomic, copy) NSString *ID;

/**地址名称*/
@property (nonatomic, copy) NSString *name;

/**等级*/
@property (copy ,nonatomic) NSString *level_type;
@end
