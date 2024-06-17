//
//  WindLineView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/24.
//
#define RotateAngle(degrees)  ((M_PI * (degrees))/ 180.f)

#import "WindLineView.h"
#import "LineImgMoveView.h"
#import "UIView+AnimationView.h"

@interface WindLineView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *windSpeedLabel;
@property (nonatomic, strong) LineImgMoveView *lineView;
@property (nonatomic, strong) LineImgMoveView *seclineView;
@property (nonatomic, strong) LineImgMoveView *thrlineView;
@property (nonatomic, strong) LineImgMoveView *botlineView;

@end

@implementation WindLineView

- (void)displayWindStyle {
    _topView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:_topView];
    
    UIImage *image = [UIImage imageNamed:@"WindSpeed"];
    _lineView = [[LineImgMoveView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    _lineView.image = image;
    _lineView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
    [_topView addSubview:_lineView];
    
    _seclineView = [[LineImgMoveView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    _seclineView.image = image;
    _seclineView.transform = CGAffineTransformRotate(_seclineView.transform, RotateAngle(120));
    _seclineView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
    [_topView addSubview:_seclineView];
    
    _thrlineView = [[LineImgMoveView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    _thrlineView.image = image;
    _thrlineView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
    _thrlineView.transform = CGAffineTransformRotate(_thrlineView.transform, RotateAngle(240));
    [_topView addSubview:_thrlineView];
    
    [_lineView showWithDuration:1.5];
    [_seclineView showWithDuration:1.5];
    [_thrlineView showWithDuration:1.5];
    [_topView rotateView:self.windSpeed];
    
    _botlineView = [[LineImgMoveView alloc] initWithFrame:CGRectMake(0, 0, 2.5, 60)];
    _botlineView.image = [UIImage imageNamed:@"Line"];
    _botlineView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
    _botlineView.transform = CGAffineTransformRotate(_botlineView.transform, RotateAngle(180));
    [_botlineView showWithDuration:1.5];
    [self addSubview:_botlineView];
    
    _windSpeedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_botlineView.frame), 60, 30)];
    _windSpeedLabel.center = CGPointMake(self.center.x, CGRectGetMaxY(_botlineView.frame)+15);
    _windSpeedLabel.text = [NSString stringWithFormat:@"%.1f mps",_windSpeed];
    _windSpeedLabel.textColor = [UIColor blackColor];
    _windSpeedLabel.textAlignment = NSTextAlignmentLeft;
    _windSpeedLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15];
    [_windSpeedLabel sizeToFit];
    [self addSubview:_windSpeedLabel];

    
    
    
}

@end
