//
//  SaveModelManager.h
//  WeatherApp
//
//  Created by Andres on 2024/5/27.
//

#import <Foundation/Foundation.h>
#import "CityInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SaveModelManager : NSObject

+ (void)saveCityWeather:(CityInfoModel *)model;
+ (void)saveCityWithDefault:(CityInfoModel *)model;
+ (void)deleteCityModel:(CityInfoModel *)deleteModel;
+ (void)deleteCityModelWithDefault:(CityInfoModel *)deleteModel;
@end

NS_ASSUME_NONNULL_END
