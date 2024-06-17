//
//  NumView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HumidityView : UIView

- (void)buildView;
- (void)updateCurrentHumidity:(NSString *)hudString;
@end

NS_ASSUME_NONNULL_END
