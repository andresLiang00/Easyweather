//
//  LineImgMoveView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/22.
//

#import "LineImgMoveView.h"

@interface LineImgMoveView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;

@end

@implementation LineImgMoveView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initRects];
        self.imageView = [[UIImageView alloc] initWithFrame:self.startRect];
        self.imageView.alpha = 0.f;
        [self addSubview:self.imageView];
    }
    
    return self;
}

- (void)initRects {
    CGRect rect    = self.bounds;
    self.startRect = CGRectMake(0, -10, rect.size.width, rect.size.height / 2.f);
    self.midRect   = CGRectMake(0, 0, rect.size.width, rect.size.height / 2.f);
}

- (void)resetImageView {
    self.imageView.alpha = 0.f;
    self.imageView.frame = self.startRect;
}

- (void)showWithDuration:(CGFloat)duration {
    [self resetImageView];
    [UIView animateWithDuration:duration animations:^{
        self.imageView.frame = self.midRect;
        self.imageView.alpha = 1.f;
    }];
}

@synthesize image = _image;

- (UIImage *)image {
    return _image;
}

- (void)setImage:(UIImage *)image {
    _image               = image;
    self.imageView.image = image;
}

@end
