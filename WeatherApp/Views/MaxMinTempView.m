//
//  MaxMinTempView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/24.
//

#import "MaxMinTempView.h"

@interface MaxMinTempView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *baseLine;
@property (nonatomic, strong) UIView *minSquare;
@property (nonatomic, strong) UIView *maxSquare;
@property (nonatomic, strong) UILabel *minLabel;
@property (nonatomic, strong) UILabel *maxLabel;
@property (nonatomic, strong) UILabel *tipsLabel;

@end


// 以中间为0度基准线
CGFloat maxSquareWidth = 20;
CGFloat maxSquareHeight = 60;
CGFloat minHeight;
CGFloat maxHeight;

@implementation MaxMinTempView

- (void)drawMinAndMax {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 50)];
    _label.text = @"Max/Min";
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont fontWithName:@"Lato-Thin" size:20];
    [self addSubview:_label];
    
    _baseLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-60, 1)];
    _baseLine.center = CGPointMake(0.5 * self.frame.size.width, 0.5 * self.frame.size.height+25);
    _baseLine.backgroundColor = [UIColor blackColor];
    [self addSubview:_baseLine];
    [self resetMaxAndMin];
}

- (void)resetSquare {
    _minSquare = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_baseLine.frame), maxSquareWidth, 0)];
    _maxSquare = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_baseLine.frame), maxSquareWidth, 0)];
    _minSquare.center = CGPointMake(_baseLine.center.x - 20, _minSquare.center.y);
    _maxSquare.center = CGPointMake(_baseLine.center.x + 20, _maxSquare.center.y);
    _minSquare.backgroundColor = [UIColor blueColor];
    _maxSquare.backgroundColor = [UIColor redColor];
    [self addSubview:_minSquare];
    [self addSubview:_maxSquare];
}

- (void)resetHeight {
    // 可能有负数
    minHeight = _minTemperature/ 40.f * maxSquareHeight;
    maxHeight = _maxTemperature/ 40.f * maxSquareHeight;
    _minLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_minSquare.frame)-60, CGRectGetMaxY(_baseLine.frame)-20, 60, 0)];
    _minLabel.center = CGPointMake(_minLabel.center.x, _minLabel.center.y);
    _minLabel.text = [NSString stringWithFormat:@"%.1f °C",_minTemperature];
    _minLabel.textColor = [UIColor blackColor];
    _minLabel.font = [UIFont fontWithName:@"Lato-Thin" size:15];
    [self addSubview:_minLabel];
    
    _maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_maxSquare.frame)-20, CGRectGetMaxY(_baseLine.frame)-20, 60, 0)];
    _maxLabel.center = CGPointMake(_maxLabel.center.x, _maxLabel.center.y);
    _maxLabel.text = [NSString stringWithFormat:@"%.1f °C",_maxTemperature];
    _maxLabel.textColor = [UIColor blackColor];
    _maxLabel.font = [UIFont fontWithName:@"Lato-Thin" size:15];
    [self addSubview:_maxLabel];
}

- (void)showSquareAnimation {
    [UIView animateWithDuration:1.5 animations:^{
        CGRect leftRect = self.minSquare.frame;
        leftRect.size.height = -minHeight;
        CGRect rightRect = self.maxSquare.frame;
        rightRect.size.height = -maxHeight;
        self.minSquare.frame = leftRect;
        self.maxSquare.frame = rightRect;
        if (self.minTemperature > 0){
            self.minLabel.frame = CGRectMake(self.minLabel.frame.origin.x, self.minLabel.frame.origin.y-minHeight, 60, 20);
        }
        else {
            self.minLabel.frame = CGRectMake(self.minLabel.frame.origin.x, self.minLabel.frame.origin.y, 60, 20);
        }
        if (self.maxTemperature > 0){
            self.maxLabel.frame = CGRectMake(self.maxLabel.frame.origin.x, self.maxLabel.frame.origin.y-maxHeight, 60, 20);
        }
        else {
            self.maxLabel.frame = CGRectMake(self.maxLabel.frame.origin.x, self.maxLabel.frame.origin.y, 60, 20);
        }
        self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.minSquare.frame)>CGRectGetMaxY(self.maxSquare.frame)?CGRectGetMaxY(self.minSquare.frame):CGRectGetMaxY(self.maxSquare.frame), self.frame.size.width, 0)];
        self.tipsLabel.text = @"Data may lost \n if 'Max' is equal to 'Min'";
        self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        self.tipsLabel.textColor = [UIColor blackColor];
        self.tipsLabel.font = [UIFont fontWithName:@"Lato-Thin" size:15];
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.tipsLabel sizeToFit];
        self.tipsLabel.center = CGPointMake(0.5 * self.frame.size.width, self.tipsLabel.center.y);
        [self addSubview:self.tipsLabel];
    }];
}

- (void)updateData:(NSArray *)arr {
    _maxTemperature = -273.15 + [arr[0] floatValue];
    _minTemperature = -273.15 + [arr[1] floatValue];
    [self resetMaxAndMin];
}

- (void)resetMaxAndMin {
    [_minSquare removeFromSuperview];
    [_maxSquare removeFromSuperview];
    [_maxLabel removeFromSuperview];
    [_minLabel removeFromSuperview];
    [_tipsLabel removeFromSuperview];
    [self resetSquare];
    [self resetHeight];
    [self showSquareAnimation];
}

@end
