//
//  TodayAnimationTransition.h
//  APPSTORE
//
//  Created by Xuyiming on 2022/4/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,AnimationType){
    present,
    dismiss
};

@interface TodayAnimationTransition : NSObject<UIViewControllerAnimatedTransitioning>
//动画类型
@property (nonatomic ,assign)AnimationType animationType;

- (instancetype)initWithAnimationType:(AnimationType)animationType;

@end

NS_ASSUME_NONNULL_END
