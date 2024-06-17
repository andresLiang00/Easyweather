//
//  WindView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/24.
//

#import "WindView.h"
#import "WindLineView.h"

@interface WindView ()

@property (nonatomic, strong) UILabel *windLabel;
@property (nonatomic, strong) WindLineView *threeLineView;

@end

@implementation WindView

- (void)showWindSpeed {
    _windLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 150, 50)];
    _windLabel.text = @"Wind Speed";
    _windLabel.textColor = [UIColor blackColor];
    _windLabel.font = [UIFont fontWithName:@"Lato-Thin" size:20];
    [self addSubview:_windLabel];
    
    _threeLineView = [[WindLineView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _threeLineView.windSpeed = self.windSpeed;
    [_threeLineView displayWindStyle];
    
    [self addSubview:_threeLineView];
}

- (void)updateWindSpeed:(CGFloat)speed {
    self.windSpeed = speed;
    [_threeLineView removeFromSuperview];
    _threeLineView = [[WindLineView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _threeLineView.windSpeed = self.windSpeed;
    [_threeLineView displayWindStyle];
    [self addSubview:_threeLineView];
}

@end
