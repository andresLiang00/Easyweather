//
//  SuntimeView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/24.
//

#import "SuntimeView.h"
#import "UIView+AnimationView.h"

@interface SuntimeView ()

@property (nonatomic, strong) UILabel *sunLabel;
@property (nonatomic, strong) UIView *sunCirView;
@property (nonatomic, strong) UIImageView *sunriseImgView;
@property (nonatomic, strong) UIImageView *sunsetImgView;


@end

@implementation SuntimeView


- (void)buildSunView {
    _sunLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 150, 50)];
    _sunLabel.text = @"Sunrise&Sunset";
    _sunLabel.textColor = [UIColor blackColor];
    _sunLabel.font = [UIFont fontWithName:@"Lato-Thin" size:20];
    [self addSubview:_sunLabel];
    
    _sunCirView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 185, 185)];
    _sunCirView.transform = CGAffineTransformMakeTranslation(0.5 * (self.frame.size.width - 185), 0.5 * (self.frame.size.height - 185));
//    _sunCirView.layer.borderColor = [UIColor blackColor].CGColor;
//    _sunCirView.layer.borderWidth = 1;
    [_sunCirView createCircleLayerWithAngle:-0.75 * M_PI endAngle:-0.25 * M_PI radius:100];
    [self addSubview:_sunCirView];
    
    _sunriseImgView = [[UIImageView alloc] init];
    _sunriseImgView.frame = CGRectMake(15, 0.3 * _sunCirView.frame.size.height, 30, 30);
    _sunriseImgView.image = [UIImage imageNamed:@"Sunrise"];
    [_sunriseImgView upAndDownLoop:4];
    [_sunCirView addSubview:_sunriseImgView];
    
    _sunriseLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _sunCirView.frame.size.height - 60, 50, 20)];
    _sunriseLabel.text = @"06:30";
    _sunriseLabel.textColor = [UIColor blackColor];
    _sunriseLabel.textAlignment = NSTextAlignmentLeft;
    _sunriseLabel.font = [UIFont fontWithName:@"Lato-Thin" size:15];
    [_sunCirView addSubview:_sunriseLabel];
    
    _sunsetImgView = [[UIImageView alloc] init];
    _sunsetImgView.frame = CGRectMake(_sunCirView.frame.size.width - 45, 0.3 * _sunCirView.frame.size.height, 30, 30);
    _sunsetImgView.image = [UIImage imageNamed:@"Sunset"];
    [_sunsetImgView upAndDownLoop:3];
    [_sunCirView addSubview:_sunsetImgView];
    
    _sunsetLabel = [[UILabel alloc] initWithFrame:CGRectMake(_sunCirView.frame.size.width - 65, _sunCirView.frame.size.height - 60, 50, 20)];
    _sunsetLabel.text = @"19:30";
    _sunsetLabel.textColor = [UIColor blackColor];
    _sunsetLabel.textAlignment = NSTextAlignmentRight;
    _sunsetLabel.font = [UIFont fontWithName:@"Lato-Thin" size:15];
    [_sunCirView addSubview:_sunsetLabel];
    
}

- (NSString *)transformTimeStamp:(NSString *)timeStamp timeZone:(NSInteger)timezone{
    NSTimeInterval time=[timeStamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:timezone]];//设置本地时区
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+(NSString *)transToDate:(NSString *)timsp timeZone:(NSInteger)timezone {
    
    NSTimeInterval time=[timsp doubleValue];//如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];

    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:timezone]];//设置本地时区
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM月dd日"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}
@end
