//
//  ViewController.m
//  demo
//
//  Created by strong on 16/10/13.
//  Copyright © 2016年 strong. All rights reserved.
//

#import "ViewController.h"
#import "addressPickview.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)even
{
    addressPickview *pick = [addressPickview shareInstance];
    
//    pick.block = ^(NSString *province,NSString *city,NSString *town){
//       NSLog(@"省 =%@ 市=%@ 县=%@",province,city,town);
//    };

    pick.block = ^(AreaObject *locate){
        NSLog(@"locate=%@",locate);
    };
    
    [self.view addSubview:pick];
    
}
@end
