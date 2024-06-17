//
//  SecondClickView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownPickerView : UIView

@property (nonatomic, strong)UIPickerView *cityPKView;
@property (nonatomic, strong)NSMutableArray *cityMuteArray;
@property (nonatomic, strong)NSMutableArray *cityNameArray;
@property (nonatomic, strong)NSMutableArray *proMuteArray;
@property (nonatomic, strong)NSMutableArray *proNameArray;
@property (nonatomic, strong)NSArray *combineArray;
@property (nonatomic, strong)NSArray *currentRowName;
@property (nonatomic, assign)int selectRow;
@property (nonatomic, assign)int cityID;

- (void)showList;

@end

NS_ASSUME_NONNULL_END
