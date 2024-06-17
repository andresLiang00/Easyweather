//
//  SecondClickView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/23.
//

#import "DownPickerView.h"
#import "CityPickerModel.h"

@interface DownPickerView ()


@end

@implementation DownPickerView

- (void)showList {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = .5f;
    self.cityPKView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.cityPKView];
    [self loadData];
    
}

- (void)loadData {
    self.cityMuteArray = [CityPickerModel getCity];
    self.cityNameArray = [CityPickerModel getCityName];
    self.proMuteArray = [CityPickerModel getProvince];
    self.proNameArray = [CityPickerModel getProvinceName];
    self.combineArray = @[self.cityMuteArray,self.proMuteArray];
    self.currentRowName = self.combineArray[0];
}




@end
