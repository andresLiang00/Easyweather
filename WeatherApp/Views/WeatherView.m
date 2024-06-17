//
//  WeatherView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/23.
//

#import "WeatherView.h"
#import "WeatherRequest.h"
#import "UIView+AnimationView.h"
#import "UIImageView+WebCache.h"
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define typeName @""
//#define partUrl [NSString stringWithFormat:@"http://openweathermap.org/img/wn/%@@2x.png",typeName]
@interface WeatherView ()

@property (nonatomic, strong) UILabel *weatherTitleLabel;

@end
@implementation WeatherView


- (void)buildWeather {
    _baseImgUrlformat = @"https://openweathermap.org/img/wn/%@@2x.png";
    _weatherTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 50)];
    _weatherTitleLabel.text = @"Weather";
    _weatherTitleLabel.textColor = [UIColor blackColor];
    _weatherTitleLabel.font = [UIFont fontWithName:@"Lato-Thin" size:20];
    [self addSubview:_weatherTitleLabel];
    
    _weatherImgView = [[UIImageView alloc] init];
    _weatherImgView.frame = CGRectMake(25, 75, self.frame.size.height-100, self.frame.size.height-100);
    _weatherImgView.image = [UIImage imageNamed:@"Sunrise"];
//    _weatherImgView.layer.borderColor = [UIColor blackColor].CGColor;
//    _weatherImgView.layer.borderWidth = 1;
    
    [UIView animateWithDuration:2 animations:^{
        self.weatherImgView.center = CGPointMake(0.5 * self.frame.size.width, 0.5 * self.frame.size.height);
        self.weatherTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weatherImgView.frame), 150, 50)];
        self.weatherTypeLabel.text = @"Sunny";
        self.weatherTypeLabel.textColor = [UIColor blackColor];
        self.weatherTypeLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15];
        [self.weatherTypeLabel sizeToFit];
        self.weatherTypeLabel.center = CGPointMake(0.5 * self.frame.size.width, self.weatherTypeLabel.center.y);
        [self addSubview:self.weatherTypeLabel];
    }completion:^(BOOL finished) {
        [self.weatherImgView GlowLayerWithColor:[UIColor redColor] glowRadius:1];
    }];
    
    
    [self addSubview:_weatherImgView];
}

- (void)updateImageview:(NSString *)imgID {
    self.weatherImgView.image = nil;
    [self.weatherImgView removeFromSuperview];
    [self.weatherTypeLabel removeFromSuperview];
    // 默认视图
    _weatherImgView = [[UIImageView alloc] init];
    _weatherImgView.frame = CGRectMake(25, 75, self.frame.size.height-100, self.frame.size.height-100);
    [self.weatherImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:_baseImgUrlformat,imgID]] placeholderImage:self.weatherImage];
    [UIView animateWithDuration:2 animations:^{
        self.weatherImgView.center = CGPointMake(0.5 * self.frame.size.width, 0.5 * self.frame.size.height);
//        self.weatherTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weatherImgView.frame), 150, 50)];
//        self.weatherTypeLabel.text = @"Moderate Rain";
        self.weatherTypeLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15];
        self.weatherTypeLabel.textColor = [UIColor blackColor];
        [self.weatherTypeLabel sizeToFit];
        self.weatherTypeLabel.center = CGPointMake(0.5 * self.frame.size.width, self.weatherTypeLabel.center.y);
        [self addSubview:self.weatherTypeLabel];
    }completion:^(BOOL finished) {
        [self.weatherImgView GlowLayerWithColor:[UIColor redColor] glowRadius:1];
    }];
    [self addSubview:self.weatherImgView];
}

@end
