//
//  WindLineView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WindLineView : UIView

@property (nonatomic, assign)CGFloat windSpeed;
- (void)displayWindStyle;
@end

NS_ASSUME_NONNULL_END
