//
//  TempeatureView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/24.
//

#import "TempeatureView.h"
#import "UIView+AnimationView.h"

@interface TempeatureView ()

@property (nonatomic, strong) UILabel *tempLabel;
@property (nonatomic, strong) UIView *tempbackView;
@property (nonatomic, strong) UIView *numberView;

@end

@implementation TempeatureView

- (void)buildTempView {
    _tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 150, 50)];
    _tempLabel.text = @"Temperature";
    _tempLabel.textColor = [UIColor blackColor];
    _tempLabel.font = [UIFont fontWithName:@"Lato-Thin" size:20];
    [self addSubview:_tempLabel];
    
    _numberView = [[UIView alloc] initWithFrame:CGRectMake(25, 25, self.frame.size.width-50, self.frame.size.height-50)];
    _numberView.growNumber = 22.0;
    [_numberView numberGrowAnimation:@"°C" color:[UIColor colorWithRed:29/255.0 green:177/255.0 blue:177/255.0 alpha:1.f]];
    [self addSubview:_numberView];
}

- (void)resetNumberView:(NSString *)tempString {
    CGFloat currentTemp = -273.15 + [tempString doubleValue];
    NSString *temp = [NSString stringWithFormat:@"%.1f",currentTemp];
    [_numberView removeFromSuperview];
    _numberView = [[UIView alloc] initWithFrame:CGRectMake(25, 25, self.frame.size.width-50, self.frame.size.height-50)];
    _numberView.growNumber = [temp doubleValue];
    [_numberView numberGrowAnimation:@"°C" color:[UIColor colorWithRed:29/255.0 green:177/255.0 blue:177/255.0 alpha:1.f]];
    [self addSubview:_numberView];
}

@end
