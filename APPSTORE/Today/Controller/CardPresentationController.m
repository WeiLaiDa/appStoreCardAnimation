//
//  CardPresentationController.m
//  APPSTORE
//
//  Created by Xuyiming on 2022/5/5.
//

#import "CardPresentationController.h"

@interface CardPresentationController()

@property (nonatomic ,strong)UIVisualEffectView * blurView;


@end

@implementation CardPresentationController

- (BOOL)shouldRemovePresentersView{
    return NO;
}


- (void)presentationTransitionWillBegin{
    UIView * container = self.containerView;
    self.blurView = [[UIVisualEffectView alloc]initWithEffect:nil];
    self.blurView.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:self.blurView];
    self.blurView.frame = CGRectMake(0, 0, container.bounds.size.width, container.bounds.size.height);
    self.blurView.alpha = 0.0;
    [self.presentingViewController beginAppearanceTransition:NO animated:NO];
    
    //动画block
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        self.blurView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.blurView.alpha =1;
    } completion:nil];
    
}

- (void)presentationTransitionDidEnd:(BOOL)completed{
    [self.presentingViewController endAppearanceTransition];
}

- (void)dismissalTransitionWillBegin{
    [self.presentingViewController beginAppearanceTransition:YES animated:YES];
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.blurView.alpha = 0;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (completed) {
        [self.blurView removeFromSuperview];
    }
}


@end
