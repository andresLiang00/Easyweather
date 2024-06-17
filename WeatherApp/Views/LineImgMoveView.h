//
//  AnimatedLineView.h
//  YoCelsius
//
//  Created by XianMingYou on 15/2/18.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>

@interface LineImgMoveView : UIView

@property (nonatomic, strong) UIImage *image;

- (void)showWithDuration:(CGFloat)duration;


@end
