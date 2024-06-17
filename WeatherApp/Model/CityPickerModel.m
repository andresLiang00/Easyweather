//
//  CityPickerModel.m
//  WeatherApp
//
//  Created by Andres on 2024/4/26.
//

#import "CityPickerModel.h"
#import "JsonFileReader.h"
#import "NSData+JsonData.h"

@implementation CityPickerModel

+ (NSMutableArray *)getCity {
    NSData *cityData = [NSData dataWithContentsOfFile:[JsonFileReader getJsonByname:@"PKCity.json"]];
    NSArray *citys = [cityData jsonToArray];
    NSMutableArray *CityArray = [NSMutableArray array];
    [citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj[@"name"] containsString:@"Province"] && ![obj[@"name"] containsString:@"Region"]) {
            [CityArray addObject:obj];
        }
    }];
    return CityArray;
}

+ (NSMutableArray *)getCityName {
    NSData *cityData = [NSData dataWithContentsOfFile:[JsonFileReader getJsonByname:@"PKCity.json"]];
    NSArray *citys = [cityData jsonToArray];
    NSMutableArray *CityArray = [NSMutableArray array];
    [citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj[@"name"] containsString:@"Province"] && ![obj[@"name"] containsString:@"Region"]) {
            [CityArray addObject:obj[@"name"]];
        }
    }];
    return CityArray;
}

+ (NSMutableArray *)getProvince {
    NSData *cityData = [NSData dataWithContentsOfFile:[JsonFileReader getJsonByname:@"PKCity.json"]];
    NSArray *citys = [cityData jsonToArray];
    NSMutableArray *ProvinceArray = [NSMutableArray array];
    [citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"name"] containsString:@"Province"] || [obj[@"name"] containsString:@"Region"]) {
            [ProvinceArray addObject:obj];
        }
    }];
    return ProvinceArray;
}

+ (NSMutableArray *)getProvinceName {
    NSData *cityData = [NSData dataWithContentsOfFile:[JsonFileReader getJsonByname:@"PKCity.json"]];
    NSArray *citys = [cityData jsonToArray];
    NSMutableArray *ProvinceArray = [NSMutableArray array];
    [citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"name"] containsString:@"Province"] || [obj[@"name"] containsString:@"Region"]) {
            [ProvinceArray addObject:obj[@"name"]];
        }
    }];
    return ProvinceArray;
}
@end
