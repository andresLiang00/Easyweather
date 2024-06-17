//
//  ProcessView.h
//  WeatherApp
//
//  Created by Andres on 2024/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProcessView : UIView

@property (nonatomic, copy) void(^finishBlock)(void);
- (void) showProcess;
- (void)endProcess;
@end

NS_ASSUME_NONNULL_END
