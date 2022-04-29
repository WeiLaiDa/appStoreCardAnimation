//
//  TodayAnimationTransition.m
//  APPSTORE
//
//  Created by Xuyiming on 2022/4/29.
//

#import "TodayAnimationTransition.h"
#import "TodayViewController.h"
#import "CardDetailViewController.h"
#import "TodayTableVIewCell.h"

@interface TodayAnimationTransition ()



@end

@implementation TodayAnimationTransition

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

//初始化方法
- (instancetype)initWithAnimationType:(AnimationType)animationType{

    _animationType = animationType;
    
    return self;
}

//动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}

//动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (self.animationType == present) {
        [self animationForPresent:transitionContext];
    }else{
        [self animationForDismiss:transitionContext];
    }
}

- (void)animationForPresent:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView * containerView = transitionContext.containerView;
    TodayViewController * fromVC = (TodayViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    CardDetailViewController * toVC = (CardDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    TodayTableVIewCell * selectedCell = fromVC.selectedCell;

    
    CGRect frame = [selectedCell convertRect:selectedCell.bgBackView.frame toView:fromVC.view];
    toVC.view.frame = frame;
    toVC.scrollView.imageView.frame = CGRectMake(toVC.scrollView.imageView.frame.origin.x, toVC.scrollView.imageView.frame.origin.y, [UIScreen mainScreen].bounds.size.width - 40, 410);
    [containerView addSubview:toVC.view];

    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionNone animations:^{
        toVC.view.frame = [UIScreen mainScreen].bounds;
        toVC.scrollView.imageView.frame = CGRectMake(toVC.scrollView.imageView.frame.origin.x, toVC.scrollView.imageView.frame.origin.y,[UIScreen mainScreen].bounds.size.width, 500);
        toVC.closeBtn.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}



- (void)animationForDismiss:(id<UIViewControllerContextTransitioning>)transitionContext{

    //此vc
    CardDetailViewController * fromVC = (CardDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //目标vc
    TodayViewController * toVC = (TodayViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //选择的cell
    TodayTableVIewCell * selectedCell = toVC.selectedCell;

    //执行动画缩进
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionNone animations:^{
        CGRect frame = [selectedCell convertRect:selectedCell.bgBackView.frame toView:toVC.view];
        fromVC.view.frame = frame;
        fromVC.view.layer.cornerRadius = 15;
        fromVC.scrollView.imageView.frame = CGRectMake(fromVC.scrollView.imageView.frame.origin.x, fromVC.scrollView.imageView.frame.origin.y, [UIScreen mainScreen].bounds.size.width - 40, 410);
        fromVC.closeBtn.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        //动画结束
        [transitionContext completeTransition:finished];
    }];
    
    //让滑动中的scrollView停止滑动
    [fromVC.scrollView setContentOffset:fromVC.scrollView.contentOffset animated:NO];
    //让scrollView回到顶部
    [UIView animateWithDuration:0.35 animations:^{
        fromVC.scrollView.contentOffset = CGPointMake(0, 0);
    }];
    
}


@end
