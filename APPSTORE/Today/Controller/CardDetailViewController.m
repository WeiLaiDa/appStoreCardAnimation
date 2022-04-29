//
//  CardDetailViewController.m
//  APPSTORE
//
//  Created by Xuyiming on 2022/4/29.
//

#import "CardDetailViewController.h"
#import "DetailScrollView.h"
#import "TodayAnimationTransition.h"
#import "CardPresentationController.h"
#import "AppEffectView.h"

@interface CardDetailViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic ,strong)AppEffectView * effectView;

@end

@implementation CardDetailViewController


- (instancetype)initWithCell:(TodayTableVIewCell *)cell{
    
    self.cell = cell;
    self = [super initWithNibName:nil bundle:nil];
    [self setupTranstion];
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getImageFromCell];
}


- (void)handleDismissPan:(UIGestureRecognizer *)gesture{
    CGFloat progress;
    UIPanGestureRecognizer * pan;
    
    if ([gesture isEqual:_dismissPanGesture]) {//长按手势
        pan = (UIPanGestureRecognizer *)gesture;
        if (!_draggingDownToDismiss) {//到达顶部才能触法事件
            return;
        }
        //手势开始位置
        CGPoint startingPoint;
        
        if (self.interactiveStartingPoint.y == 0 && self.interactiveStartingPoint.x == 0) {
            self.interactiveStartingPoint = [pan locationInView:self.view];
        }
        
        startingPoint =  self.interactiveStartingPoint;
        //手势当前位置
        CGPoint currentLocation = [pan locationInView:nil];
        //计算进度
        progress = (currentLocation.y - startingPoint.y)/180;
        
        if (progress < 0) {
            progress = -progress;
        }
        
        if (self.scrollView.contentOffset.y <= 0) {
            if (currentLocation.y <= startingPoint.y) {
                progress = 0;
            }
        }
        if (self.scrollView.contentOffset.y >= self.scrollView.contentSize.height - [UIScreen mainScreen].bounds.size.height) {
            if (currentLocation.y >= startingPoint.y) {
                progress = 0;
            }
        }
        
        
        

    }else{//屏幕边缘长按手势
        
        pan = (UIScreenEdgePanGestureRecognizer *)gesture;
        
        self.dismissPanGesture.enabled = NO;

        CGPoint startingPoint;
        if (self.interactiveStartingPoint.y == 0 && self.interactiveStartingPoint.x == 0) {
            self.interactiveStartingPoint = [pan locationInView:self.view];
        }
        startingPoint =  self.interactiveStartingPoint;
        CGPoint currentLocation = [pan locationInView:nil];
        progress = (currentLocation.x - startingPoint.x)/150;
        if (currentLocation.x <= startingPoint.x) {
            progress = 0;
        }
        
    }
    if (progress >= 1.0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.dismissClosure) {
            self.dismissClosure();
        }
        
        [self stopDismissPanGesture:pan];
        return;
    }
    
    CGFloat targetShrinkScale = 0.86;
    CGFloat currentScale = 1 - (1 - targetShrinkScale) * progress;
    
    if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged) {
        self.scrollView.scrollEnabled = NO;
        pan.view.transform = CGAffineTransformMakeScale(currentScale, currentScale);
        pan.view.layer.cornerRadius = 15 * progress;
        self.scrollView.showsVerticalScrollIndicator = false;

    }else{
        if(pan.state == UIGestureRecognizerStateCancelled ||  pan.state == UIGestureRecognizerStateEnded){
            self.scrollView.scrollEnabled = YES;
            [self stopDismissPanGesture:pan];
        }
    }
    

}

//当下拉Offset超过100或取消下拉手势时，执行此方法
- (void)stopDismissPanGesture:(UIPanGestureRecognizer *)gesture{
    self.draggingDownToDismiss = NO;
    self.interactiveStartingPoint = CGPointZero;
    self.scrollView.showsVerticalScrollIndicator = true;
    [UIView animateWithDuration:0.2 animations:^{
        gesture.view.transform = CGAffineTransformIdentity;
    }];
}

//关闭按钮事件
- (void)closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.scrollView scrollsToTop];
    if (self.dismissClosure) {
        self.dismissClosure();
    }
    
}

//添加transtion
- (void)setupTranstion{
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
}

//添加控件
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.masksToBounds = true;
    _scrollView = [[DetailScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 20, 30, 30)];
    [_closeBtn setImage:[UIImage imageNamed:@"close_button"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeBtn];
    _dismissPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleDismissPan:)];
    _dismissPanGesture.maximumNumberOfTouches = 1;
    _dismissPanGesture.delegate = self;
    
    _screenPanGesture= [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleDismissPan:)];
    _screenPanGesture.maximumNumberOfTouches = 1;
    _screenPanGesture.delegate = self;
    _screenPanGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_dismissPanGesture];
    [self.view addGestureRecognizer:_screenPanGesture];
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}

//获取cell的图片
- (void)getImageFromCell{
    _scrollView.imageView.image = _cell.bgImageView.image;
}


#pragma mark: --UIViewControllerTransitioningDelegate--
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return [[TodayAnimationTransition alloc]initWithAnimationType:present];
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[TodayAnimationTransition alloc]initWithAnimationType:dismiss];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    CardPresentationController * card =  [[CardPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    return card;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
        self.draggingDownToDismiss = YES;
    }
    if (scrollView.contentOffset.y + [UIScreen mainScreen].bounds.size.height > scrollView.contentSize.height) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height - [UIScreen mainScreen].bounds.size.height);
        self.draggingDownToDismiss = YES;
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}




@end
