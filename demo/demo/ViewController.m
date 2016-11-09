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
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addressLabel.userInteractionEnabled =YES;
    [self.addressLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressClick)]];
}

-(void)addressClick{
    addressPickview *pick = [addressPickview shareInstance];
    
    //    pick.block = ^(NSString *province,NSString *city,NSString *town){
    //       NSLog(@"省 =%@ 市=%@ 县=%@",province,city,town);
    //    };
    __weak typeof(self) weakSelf = self;
    pick.block = ^(AreaObject *locate){
        NSLog(@"locate=%@",locate);
        weakSelf.addressLabel.text = [NSString stringWithFormat:@"%@",locate];
    };
    
    [self.view addSubview:pick];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)even
{
   
    
}
@end
