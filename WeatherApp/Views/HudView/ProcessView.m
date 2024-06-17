//
//  ProcessView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/23.
//

#import "ProcessView.h"
#import "UIView+AnimationView.h"

@interface ProcessView ()

@property (nonatomic, strong) UIView *backView;

@end
@implementation ProcessView


- (void)showProcess {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    _backView.center = CGPointMake(0.5 * [UIScreen mainScreen].bounds.size.width, 0.5 * [UIScreen mainScreen].bounds.size.height);
    [self addSubview:_backView];
    [self.backView rotateCircle];
}

- (void)endProcess {
    if(self.finishBlock) {
        self.finishBlock();
    }
}

@end
