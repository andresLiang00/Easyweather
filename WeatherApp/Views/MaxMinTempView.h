//
//  MaxMinTempView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaxMinTempView : UIView

@property (nonatomic, assign) CGFloat minTemperature;
@property (nonatomic, assign) CGFloat maxTemperature;
- (void)drawMinAndMax;
- (void)updateData:(NSArray *)arr;
@end

NS_ASSUME_NONNULL_END
