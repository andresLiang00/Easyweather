//
//  CityPickerModel.h
//  WeatherApp
//
//  Created by Andres on 2024/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityPickerModel : NSObject

+ (NSMutableArray *)getCity;
// 获取城市名列表
+ (NSMutableArray *)getCityName;
+ (NSMutableArray *)getProvince;
// 获取城市名列表
+ (NSMutableArray *)getProvinceName;

@end

NS_ASSUME_NONNULL_END
