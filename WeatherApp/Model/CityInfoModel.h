//
//  CityInfoModel.h
//  WeatherApp
//
//  Created by Andres on 2024/5/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityInfoModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *weather_desc;
@property (nonatomic, copy) NSString *weather_icon_string;
@property (nonatomic, assign) int sunrise_time_string;
@property (nonatomic, assign) int sunset_time_string;
@property (nonatomic, assign) int weather_timezone;
@property (nonatomic, copy) NSString *current_temp;
@property (nonatomic, copy) NSString *max_temp;
@property (nonatomic, copy) NSString *min_temp;
@property (nonatomic, copy) NSString *weather_humidity;
@property (nonatomic, assign) float weather_windspeed;

@end

NS_ASSUME_NONNULL_END
