//
//  JsonFileReader.m
//  WeatherApp
//
//  Created by Andres on 2024/4/25.
//

#import "JsonFileReader.h"

@implementation JsonFileReader

+ (NSString *)getJsonByname:(NSString *)name {
    return [[NSBundle mainBundle] pathForResource:name ofType:nil];
}

@end
