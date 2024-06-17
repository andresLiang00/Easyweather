//
//  UIView+AnimationView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/22.
//

#import "UIView+AnimationView.h"
#import "objc/runtime.h"

#define GLOWVIEW_LAYER_NAME     @"GlowAnimationView"
#define CIRCLE_LAYER_FLAG     @"CircleAnimation"
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;

@interface UIView ()

@property (strong, nonatomic) dispatch_source_t  dispatchSource;
@property (strong, nonatomic) NSNumber          *glowViewShowFlag;
@property (strong, nonatomic) NSString          *tempFormat;

@end

@implementation UIView (AnimationView)

#pragma mark - 动态添加了属性
static char dispatchSourceTimerFlag;

- (void)setDispatchSource:(dispatch_source_t)dispatchSource {
    objc_setAssociatedObject(self, &dispatchSourceTimerFlag, dispatchSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (dispatch_source_t)dispatchSource {
    return objc_getAssociatedObject(self, &dispatchSourceTimerFlag);
}

static char charGlowViewShowFlag;

- (void)setGlowViewShowFlag:(NSNumber *)glowViewShowFlag {
    objc_setAssociatedObject(self, &charGlowViewShowFlag, glowViewShowFlag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowViewShowFlag {
    return objc_getAssociatedObject(self, &charGlowViewShowFlag);
}

static char charNumLabel;

- (void)setNumLabel:(UICountingLabel *)numLabel {
    objc_setAssociatedObject(self, &charNumLabel, numLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UICountingLabel *)numLabel {
    return objc_getAssociatedObject(self, &charNumLabel);
}

static char charGrowNumber;

- (void)setGrowNumber:(CGFloat)growNumber {
    objc_setAssociatedObject(self, &charGrowNumber, @(growNumber), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)growNumber {
    return [objc_getAssociatedObject(self, &charGrowNumber) floatValue];
}

static char charFormat;

- (void)setTempFormat:(NSString *)tempFormat {
    objc_setAssociatedObject(self, &charFormat, tempFormat, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)tempFormat {
    return objc_getAssociatedObject(self, &charFormat);
}
#pragma mark - 方法
- (void)GlowLayerWithColor:(UIColor *)color glowRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:(CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, self.bounds.size.height)}];
    [color setFill];
    [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];
    CALayer *glowLayer      = [CALayer layer];
    glowLayer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectZero].CGPath;
    glowLayer.name          = GLOWVIEW_LAYER_NAME;
    glowLayer.frame         = self.bounds;
    glowLayer.contents      = (__bridge id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    glowLayer.shadowOpacity = 1.0f;
    glowLayer.shadowOffset  = CGSizeMake(0, 0);
    glowLayer.shadowColor   = color.CGColor;
    glowLayer.shadowRadius  = radius;
    glowLayer.opacity       = 0.f;
    [self.layer addSublayer:glowLayer];
    [self fadeLoop];
}

#pragma mark - 构造圆弧曲线方法
- (void)createCircleLayerWithAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle radius:(CGFloat)radius{
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.lineWidth = 1;
    // 圆环的颜色
    layer.strokeColor = [UIColor blackColor].CGColor;
    // 背景填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0.5 * self.frame.size.width, 1 * self.frame.size.height) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    layer.path = path.CGPath;
//    self.layer.position = CGPointMake(0.5 * self.frame.size.width, 0.5 * self.frame.size.height);
    [self.layer addSublayer:layer];
}

- (void)GradientLayer{
    CGSize size= [UIScreen mainScreen].bounds.size;
    self.layer.position = CGPointMake(size.width/2, size.height/2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:35 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    CALayer *mainLayer = [CALayer new];
    mainLayer.borderColor = [UIColor blackColor].CGColor;
    mainLayer.borderWidth = 1;
    mainLayer.bounds = CGRectMake(0, 0, 100, 100);
    mainLayer.position = CGPointMake(0.5 * self.layer.bounds.size.width, 0.5 * self.layer.bounds.size.height);
    mainLayer.backgroundColor = [UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1].CGColor;
    mainLayer.name = CIRCLE_LAYER_FLAG;
    [self.layer addSublayer:mainLayer];
    
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.path = path.CGPath;
    layer.lineWidth = 5;
    layer.lineCap = kCALineCapRound;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.strokeStart = 0;
    layer.strokeEnd = 1;
    layer.fillColor = [UIColor clearColor].CGColor;
    [mainLayer setMask:layer];
    
    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1].CGColor,(id)[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = path.CGPath;
    gradientLayer.frame = CGRectMake(0, 0, 100, 50);
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    
    NSMutableArray *colors1 = [NSMutableArray arrayWithObjects:(id)[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor,(id)[[UIColor whiteColor] CGColor], nil];
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.shadowPath = path.CGPath;
    gradientLayer1.frame = CGRectMake(0, 50, 100, 50);
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint = CGPointMake(1, 1);
    [gradientLayer1 setColors:[NSArray arrayWithArray:colors1]];
    [mainLayer addSublayer:gradientLayer]; //设置颜色渐变
    [mainLayer addSublayer:gradientLayer1];
}

- (void)createOwnGradientLayer:(UIColor *)colorStart endColor:(UIColor *)colorEnd {
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)colorStart.CGColor,(id)colorEnd.CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
//    [self.layer addSublayer:gradientLayer];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)rotateCircle {
    [self GradientLayer];
    [self.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:CIRCLE_LAYER_FLAG]) {
            CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
                rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
                rotationAnimation.repeatCount = MAXFLOAT;
                rotationAnimation.duration = 1;
                rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                [obj addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        }
    }];
}

- (void)rotateView:(CGFloat)rotateSpeed {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 1;
    rotationAnimation.speed = rotateSpeed * 1.f /10.f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}



- (void)numberGrowAnimation:(NSString *)format color:(UIColor *)color{
    self.tempFormat = format;
    [self buildViewForLabel:@"%.1f"];
    WeakSelf(weakSelf);
    self.numLabel.completionBlock = ^{
        [UIView animateWithDuration:0.1 animations:^{
            NSDictionary *attributes =
            @{NSFontAttributeName:
                  [UIFont fontWithName:@"Georgia" size:30.f],NSForegroundColorAttributeName: [weakSelf getColor:weakSelf.growNumber/100.f]};
            NSMutableAttributedString *numString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",weakSelf.numLabel.text,weakSelf.tempFormat] attributes:attributes];
            [numString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Georgia" size:10.f] range:NSMakeRange(2, numString.length-2)];
            weakSelf.numLabel.attributedText = numString;
        }];
        [weakSelf GlowLayerWithColor:color glowRadius:2];
    };
}

- (void)fadeLoop {
    if (self.glowViewShowFlag == nil) {
        self.glowViewShowFlag = [NSNumber numberWithBool:NO];
    }
    [self.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:GLOWVIEW_LAYER_NAME]) {
            if (!self.dispatchSource) {
                self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
                dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), 4 * NSEC_PER_SEC, 0);
                dispatch_source_set_event_handler(self.dispatchSource, ^{
                    if (self.glowViewShowFlag.boolValue == NO) {
                        self.glowViewShowFlag = @(YES);
                        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
                        animation.fromValue = @(0.f);
                        animation.toValue   = @(0.8f);
                        animation.duration = 2;
                        obj.opacity  = 0.8f;
                        [obj addAnimation:animation forKey:nil];
                    }
                    else {
                        self.glowViewShowFlag = @(NO);
                        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
                        animation.fromValue = @(0.8f);
                        animation.toValue   = @(0.f);
                        animation.duration = 2;
                        obj.opacity  = 0.f;
                        [obj addAnimation:animation forKey:nil];
                    }
                });
                dispatch_resume(self.dispatchSource);
            }
        }
    }];
}

- (void)upAndDownLoop:(CGFloat)duration {
    if (!self.dispatchSource) {
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), duration * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(self.dispatchSource, ^{
            CGPoint topPoint = self.layer.position;
            topPoint.y -= 10;
            if (self.glowViewShowFlag.boolValue == NO) {
                self.glowViewShowFlag = @(YES);
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                animation.fromValue = [NSValue valueWithCGPoint:self.layer.position];
                animation.toValue   = [NSValue valueWithCGPoint:topPoint];
                animation.duration = 0.5 * duration;
                animation.removedOnCompletion = NO;
                animation.fillMode = kCAFillModeForwards;
                [self.layer addAnimation:animation forKey:nil];
            }
            else {
                self.glowViewShowFlag = @(NO);
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                animation.fromValue = [NSValue valueWithCGPoint:topPoint];
                animation.toValue   = [NSValue valueWithCGPoint:self.layer.position];
                animation.duration = 0.5 * duration;
                animation.removedOnCompletion = NO;
                animation.fillMode = kCAFillModeForwards;
                [self.layer addAnimation:animation forKey:nil];
            }
        });
        dispatch_resume(self.dispatchSource);
    }
}

- (void)buildViewForLabel:(NSString *)format {
    if (!self.numLabel) {
        self.numLabel = [[UICountingLabel alloc] init];
    }
    self.numLabel.frame = CGRectMake(0, 0, 0.5 * self.frame.size.width, 0.5 * self.frame.size.height);
    self.numLabel.format = format;
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.center = CGPointMake(0.5 * self.frame.size.width, 0.5 * self.frame.size.height);
    self.numLabel.font = [UIFont fontWithName:@"Georgia" size:30.f];
    [self.numLabel countFromZeroTo:self.growNumber];
    [UIView animateWithDuration:2 animations:^{
        self.numLabel.transform = CGAffineTransformMakeScale(2, 2);
    }];
    [self addSubview:self.numLabel];
}

- (UIColor *)getColor:(CGFloat)value {
    return [UIColor colorWithRed:value / 4.f green:value / 3.f blue:value / 2.f alpha:value];
}

@end
