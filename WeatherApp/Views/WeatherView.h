//
//  WeatherView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherView : UIView

@property (nonatomic, strong) UILabel *weatherTypeLabel;
@property (nonatomic, strong) UIImageView *weatherImgView;
@property (nonatomic, strong) UIImage *weatherImage;
@property (nonatomic, copy) NSString *baseImgUrlformat;

@property (nonatomic, copy) void(^getTypeStringBlock)(NSString *typeString);

- (void)buildWeather;

// 更新天气视图
- (void)updateImageview:(NSString *)imgID;
@end

NS_ASSUME_NONNULL_END
