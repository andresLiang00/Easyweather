//
//  WeatherRequest.h
//  WeatherApp
//
//  Created by Andres on 2024/4/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherRequest : NSObject

+ (void)weatherNetRequest:(int)queryType params:(id)params result:(void (^)(id responseObj))responseBlock;

@end

NS_ASSUME_NONNULL_END
