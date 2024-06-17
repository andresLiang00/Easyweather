//
//  SaveModelManager.m
//  WeatherApp
//
//  Created by Andres on 2024/5/27.
//

#import "SaveModelManager.h"

#define cityList @"cityList"

@implementation SaveModelManager

+ (void)saveCityWeather:(CityInfoModel *)model {
    NSMutableArray *city_arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:cityList]];
    if (city_arr == nil || city_arr.count == 0) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [city_arr addObject:data];
    }
    else {
        NSArray *history_arr = [[NSUserDefaults standardUserDefaults] objectForKey:cityList];
        [history_arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *data = obj;
            CityInfoModel *child_model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if ([child_model.city_name isEqualToString:model.city_name]) {
                [city_arr removeObjectAtIndex:idx];
                *stop = YES;
                return;
            }
        }];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [city_arr insertObject:data atIndex:0];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:city_arr forKey:cityList];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 获取了定位权限 则后续的城市除了个人位置 都从下标为1开始记录
+ (void)saveCityWithDefault:(CityInfoModel *)model {
    NSMutableArray *city_arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:cityList]];
    if (city_arr == nil || city_arr.count == 0) {
        // 第一个插入的是个人位置
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [city_arr addObject:data];
    }
    else {
        NSArray *history_arr = [[NSUserDefaults standardUserDefaults] objectForKey:cityList];
        NSData *myCityData = history_arr[0];
        CityInfoModel *mycity_model = [NSKeyedUnarchiver unarchiveObjectWithData:myCityData];
        [history_arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *data = obj;
            CityInfoModel *child_model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if ([child_model.city_name isEqualToString:model.city_name] && idx != 0) {
                [city_arr removeObjectAtIndex:idx];
                *stop = YES;
                return;
            }
        }];
        // 从个人位置后开始插入
        if (![mycity_model.city_name isEqualToString:model.city_name]) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
            [city_arr insertObject:data atIndex:1];
        }
        else {
            [city_arr removeObjectAtIndex:0];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
            [city_arr insertObject:data atIndex:0];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:city_arr forKey:cityList];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)deleteCityModelWithDefault:(CityInfoModel *)deleteModel {
    NSMutableArray *city_arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:cityList]];
    if (city_arr == nil || city_arr.count == 0) {
        return;
    }
    else {
        NSArray *history_arr = [[NSUserDefaults standardUserDefaults] objectForKey:cityList];
        NSData *myCityData = history_arr[0];
        CityInfoModel *mycity_model = [NSKeyedUnarchiver unarchiveObjectWithData:myCityData];
        [history_arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *data = obj;
            CityInfoModel *child_model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if ([child_model.city_name isEqualToString:deleteModel.city_name] && idx != 0) {
                [city_arr removeObjectAtIndex:idx];
                *stop = YES;
                return;
            }
        }];
    }
    [[NSUserDefaults standardUserDefaults] setObject:city_arr forKey:cityList];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)deleteCityModel:(CityInfoModel *)deleteModel {
    NSMutableArray *city_arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:cityList]];
    if (city_arr == nil || city_arr.count == 0) {
        return;
    }
    else {
        NSArray *history_arr = [[NSUserDefaults standardUserDefaults] objectForKey:cityList];
        [history_arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *data = obj;
            CityInfoModel *child_model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if ([child_model.city_name isEqualToString:deleteModel.city_name]) {
                [city_arr removeObjectAtIndex:idx];
                *stop = YES;
                return;
            }
        }];
    }
    [[NSUserDefaults standardUserDefaults] setObject:city_arr forKey:cityList];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
