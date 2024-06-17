//
//  UIView+AnimationView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/22.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AnimationView)

@property (nonatomic, strong) UICountingLabel   *numLabel;
@property (assign, nonatomic) CGFloat                growNumber;

- (void)numberGrowAnimation:(NSString *)format color:(UIColor *)color;
- (void)GlowLayerWithColor:(UIColor *)color glowRadius:(CGFloat)radius;
- (void)createCircleLayerWithAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle radius:(CGFloat)radius;
- (void)rotateCircle;
- (void)rotateView:(CGFloat)rotateSpeed;
- (void)upAndDownLoop:(CGFloat)duration;
- (void)createOwnGradientLayer:(UIColor *)colorStart endColor:(UIColor *)colorEnd;
@end

NS_ASSUME_NONNULL_END
