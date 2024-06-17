//
//  SearchCityView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchCityView : UIView

@property (nonatomic, strong) UITextField *inputBox;
@property (nonatomic, copy) void(^processBlock)(void);
@property (nonatomic, copy) void(^locateBlock)(void);
- (void)buildCityView;

@end

NS_ASSUME_NONNULL_END
