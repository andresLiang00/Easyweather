//
//  CityitemCell.h
//  WeatherApp
//
//  Created by Andres on 2024/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityitemCell : UITableViewCell

typedef void(^deleteBlock)(void);
typedef void(^change_heightBlock)(void);

@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *label_city_name;
@property (nonatomic, strong) UILabel *label_weather_desc;
@property (nonatomic, strong) UILabel *label_current_temp;
@property (nonatomic, strong) UILabel *label_weather_humidity;
@property (nonatomic, strong) UIButton *cell_deletebtn;

@property (nonatomic, copy) deleteBlock deleteBlock;

@end

NS_ASSUME_NONNULL_END
