//
//  WindView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WindView : UIView

- (void)showWindSpeed;

@property (nonatomic, assign)CGFloat windSpeed;
- (void)updateWindSpeed:(CGFloat)speed;

@end

NS_ASSUME_NONNULL_END
