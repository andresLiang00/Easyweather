//
//  JsonFileReader.h
//  WeatherApp
//
//  Created by Andres on 2024/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JsonFileReader : NSObject
+ (NSString *)getJsonByname:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
