//
//  SuntimeView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuntimeView : UIView

@property (nonatomic, strong) UILabel *sunriseLabel;
@property (nonatomic, strong) UILabel *sunsetLabel;

- (void)buildSunView;
- (NSString *)transformTimeStamp:(NSString *)timeStamp timeZone:(NSInteger)timezone;
@end

NS_ASSUME_NONNULL_END
