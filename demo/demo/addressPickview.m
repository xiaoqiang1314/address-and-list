//
//  addressPickview.m
//  demo
//
//  Created by strong on 16/10/13.
//  Copyright © 2016年 strong. All rights reserved.
//

#import "addressPickview.h"
#import "AreaObject.h"
#import "addressModel.h"
#import "dataModel.h"
#import <MJExtension/MJExtension.h>
@interface addressPickview ()<UIPickerViewDataSource,UIPickerViewDelegate>
/**省份数组*/
@property (strong ,nonatomic) NSMutableArray *proviceArr;
/**市数组*/
@property (strong ,nonatomic) NSMutableArray *cityArr;
/**县数组*/
@property (strong ,nonatomic) NSMutableArray *townArr;

@property (strong ,nonatomic) NSMutableArray *dataArr;

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (strong, nonatomic) AreaObject *locate;

@property (assign ,nonatomic)NSInteger index;

@end
@implementation addressPickview

#pragma mark - 实例化
+(instancetype)shareInstance{
    static addressPickview *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[addressPickview alloc]init];
    });
    return shareInstance;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([addressPickview class]) owner:nil options:nil].lastObject;
        self.pickView.dataSource = self;
        self.pickView.delegate = self;
    }
    self.frame = [UIScreen mainScreen].bounds;
    _proviceArr = [NSMutableArray array];
    _cityArr = [NSMutableArray array];
    _townArr = [NSMutableArray array];
    
    for (addressModel *model in self.dataArr) {
        if ([model.pid isEqualToString:@"1"]) {
            [_proviceArr  addObject:model];
        }
        if ([model.level_type isEqualToString:@"2"]) {
            [self.cityArr addObject:model];
        }
        if ([model.level_type isEqualToString:@"3"]) {
            [self.townArr addObject:model];
        }
    }
//    NSLog(@"市数量=%ld 县数量=%ld",self.cityArr.count,self.townArr.count);
    return self;
}

#pragma mark - lazy
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        NSString *file = [[NSBundle mainBundle] pathForResource:@"city.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:file];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        dataModel*model= [dataModel mj_objectWithKeyValues:dict];
        for (NSDictionary *temp in model.RECORDS) {
            addressModel*model = [addressModel mj_objectWithKeyValues:temp];
            [_dataArr addObject:model];
        }
    }
    return _dataArr;
}


- (AreaObject *)locate{
    if (!_locate) {
        _locate = [[AreaObject alloc]init];
    }
    return _locate;
}

#pragma mark - action
- (IBAction)sureBtn:(UIButton *)sender {
    if (self.block) {
        
        addressModel *p1= [self.proviceArr objectAtIndex:[_pickView selectedRowInComponent:0]];
        NSString *province = p1.name;
        
        addressModel *p2= [self.cityArr objectAtIndex:[_pickView selectedRowInComponent:1]];
        NSString *city = p2.name;
//        NSLog(@"city=%@",city);
       addressModel *p3= [self.townArr objectAtIndex:[_pickView selectedRowInComponent:2]];
        NSString *town =p3.name;
//        NSLog(@"town=%@",town);
//        self.block(province,city,town);
        self.block(_locate);
//         NSLog(@"self.locate=%@",self.locate);
    }
     [self removeFromSuperview];
}
- (IBAction)cancelBtn:(UIButton *)sender {
    [self removeFromSuperview];
}
#pragma  mark -  UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    

    if (component == 0) {
        return self.proviceArr.count;
    } else if (component == 1) {
        // 取出
        NSInteger first = [pickerView selectedRowInComponent:0];
        addressModel *firstModel = self.proviceArr[first];
        int count = 0;
        for (addressModel *model in self.cityArr) {
            if ([model.pid isEqualToString:firstModel.ID] && [model.level_type isEqualToString:@"2"]) {
                count++;
            }
        }
        return count;
    } else {
        // 取出
        NSInteger first = [pickerView selectedRowInComponent:0];
        addressModel *firstModel = self.proviceArr[first];
        NSMutableArray *arrM = [NSMutableArray array];
        for (addressModel *model in self.cityArr) {
            if ([model.pid isEqualToString:firstModel.ID] && [model.level_type isEqualToString:@"2"]) {
                [arrM addObject:model];
            }
        }
        if (arrM.count ==0) {
            return 0;
        }
        else{
            NSInteger second = [pickerView selectedRowInComponent:1];
            addressModel *secondModel = arrM[second];
            int count = 0;
            for (addressModel *model in self.townArr) {
                if ([model.pid isEqualToString:secondModel.ID] && [model.level_type isEqualToString:@"3"]) {
                    count++;
                }
            }
            return count;
        }
    }
}


#pragma  mark -  UIPickerViewDelegate
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component ==0) {
        addressModel *model = self.proviceArr[row];
        self.locate.province = model.name;
        return model.name;
    }
    if (component ==1) {
        // 第二列
        NSInteger first = [pickerView selectedRowInComponent:0];
        addressModel *firstModel = self.proviceArr[first];
        NSMutableArray *arrM = [NSMutableArray array];
        for (addressModel *model in self.cityArr) {
            if ([model.pid isEqualToString:firstModel.ID] && [model.level_type isEqualToString:@"2"]) {
                [arrM addObject:model];
            }
        }
        addressModel *model = arrM[row];
        self.locate.city = model.name;
        return model.name;
    }
    else
        //第三列
    {
        NSInteger first = [pickerView selectedRowInComponent:0];
        addressModel *firstModel = self.proviceArr[first];
        NSMutableArray *cityM = [NSMutableArray array];
        for (addressModel *model in self.cityArr) {
            if ([model.pid isEqualToString:firstModel.ID] && [model.level_type isEqualToString:@"2"]) {
                [cityM addObject:model];
            }
        }
        NSInteger second = [pickerView selectedRowInComponent:1];
        addressModel *secondModel = cityM[second];
        NSMutableArray *arrM = [NSMutableArray array];
        for (addressModel *model in self.townArr) {
            if ([model.pid isEqualToString:secondModel.ID] && [model.level_type isEqualToString:@"3"]) {
                [arrM addObject:model];
            }
        }
        //钓鱼岛
        if (arrM.count==0) {
            return 0;
        }
        else{
            addressModel *model = arrM[row];
            self.locate.area = model.name;
            return model.name;
        }
    }
    return nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:18]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    if (component ==1) {
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
}


@end
