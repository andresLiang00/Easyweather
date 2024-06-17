//
//  HumidityView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/22.
//

#import "HumidityView.h"
#import "UIView+AnimationView.h"
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;

@interface HumidityView ()

@property (nonatomic, strong) UIImageView *humidtyBg;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *numberView;

@end

@implementation HumidityView

- (void)buildView {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 50)];
    _label.text = @"Humidity";
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont fontWithName:@"Lato-Thin" size:20];
    [self addSubview:_label];
    
    _humidtyBg = [[UIImageView alloc] init];
    _humidtyBg.frame = CGRectMake(105, 20, 30, 30);
    _humidtyBg.image = [UIImage imageNamed:@"Humidity"];
    [_humidtyBg GlowLayerWithColor:[UIColor redColor] glowRadius:1];
    [self addSubview:_humidtyBg];
    
    _numberView = [[UIView alloc] initWithFrame:CGRectMake(25, 25, self.frame.size.width-50, self.frame.size.height-50)];
    _numberView.growNumber = 80.f;
    [_numberView numberGrowAnimation:@"%" color:[UIColor purpleColor]];
    [self addSubview:_numberView];
}

- (void)updateCurrentHumidity:(NSString *)hudString {
    [_numberView removeFromSuperview];
    CGFloat hudNum = [hudString floatValue];
    _numberView = [[UIView alloc] initWithFrame:CGRectMake(25, 25, self.frame.size.width-50, self.frame.size.height-50)];
    _numberView.growNumber = [[NSString stringWithFormat:@"%.1f",hudNum] doubleValue];
    [_numberView numberGrowAnimation:@"%" color:[UIColor purpleColor]];
    [self addSubview:_numberView];
}
@end
