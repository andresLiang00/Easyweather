//
//  CityInfoModel.m
//  WeatherApp
//
//  Created by Andres on 2024/5/27.
//

#import "CityInfoModel.h"

@implementation CityInfoModel

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.city_id forKey:@"city_id"];
    [coder encodeObject:self.city_name forKey:@"city_name"];
    [coder encodeObject:self.weather_desc forKey:@"weather_desc"];
    [coder encodeObject:self.weather_icon_string forKey:@"weather_icon_string"];
    [coder encodeObject:[NSString stringWithFormat:@"%d",self.sunrise_time_string] forKey:@"sunrise_time_string"];
    [coder encodeObject:[NSString stringWithFormat:@"%d",self.sunset_time_string] forKey:@"sunset_time_string"];
    [coder encodeObject:[NSString stringWithFormat:@"%d",self.weather_timezone] forKey:@"weather_timezone"];
    [coder encodeObject:self.current_temp forKey:@"current_temp"];
    [coder encodeObject:self.max_temp forKey:@"max_temp"];
    [coder encodeObject:self.min_temp forKey:@"min_temp"];
    [coder encodeObject:self.weather_humidity forKey:@"weather_humidity"];
    [coder encodeObject:[NSString stringWithFormat:@"%f",self.weather_windspeed] forKey:@"weather_windspeed"];
}

- (instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if (self = [self init]) {
        self.city_id  = [coder decodeObjectForKey:@"city_id"];
        self.city_name  = [coder decodeObjectForKey:@"city_name"];
        self.weather_desc  = [coder decodeObjectForKey:@"weather_desc"];
        self.weather_icon_string  = [coder decodeObjectForKey:@"weather_icon_string"];
        self.sunrise_time_string  = [[coder decodeObjectForKey:@"sunrise_time_string"] intValue];
        self.sunset_time_string  = [[coder decodeObjectForKey:@"sunset_time_string"] intValue];
        self.weather_timezone  = [[coder decodeObjectForKey:@"weather_timezone"] intValue];
        self.current_temp  = [coder decodeObjectForKey:@"current_temp"];
        self.max_temp  = [coder decodeObjectForKey:@"max_temp"];
        self.min_temp  = [coder decodeObjectForKey:@"min_temp"];
        self.weather_humidity  = [coder decodeObjectForKey:@"weather_humidity"];
        self.weather_windspeed  = [[coder decodeObjectForKey:@"weather_windspeed"] floatValue];
    }
    return self;
}


@end
