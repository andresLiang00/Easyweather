//
//  DownListView.h
//  WeatherApp
//
//  Created by Andres on 2024/5/27.
//

#import <UIKit/UIKit.h>
#import "CityInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SaveCityTagView : UIView

typedef void(^city_ChooseBlock)(CityInfoModel *model);
typedef void(^click_Block)(void);

// 请求定位权限
@property (nonatomic, assign) BOOL location_isAllow;
@property (nonatomic, copy) city_ChooseBlock city_chooseBlock;
@property (nonatomic, copy) click_Block click_block;
- (void)setview;

@end

NS_ASSUME_NONNULL_END
