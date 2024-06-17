//
//  TempeatureView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TempeatureView : UIView

- (void)buildTempView;
- (void)resetNumberView:(NSString *)tempString;
@end

NS_ASSUME_NONNULL_END
