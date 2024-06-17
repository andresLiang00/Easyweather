//
//  ViewController.h
//  WeatherApp
//
//  Created by Andres on 2024/4/22.
//

#import <UIKit/UIKit.h>

#define topInset [UIApplication sharedApplication].delegate.window.safeAreaInsets.top
#define botInset [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LaunchVC : UIViewController


@end

