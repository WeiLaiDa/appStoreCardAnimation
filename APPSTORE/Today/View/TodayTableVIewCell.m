//
//  TodayTableVIewCell.m
//  APPSTORE
//
//  Created by Xuyiming on 2022/4/29.
//

#import "TodayTableVIewCell.h"

@interface TodayTableVIewCell ()
@property (nonatomic, strong) UIViewPropertyAnimator *animator;
@end

@implementation TodayTableVIewCell

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _animator = [[UIViewPropertyAnimator alloc] initWithDuration:0.2 curve:UIViewAnimationCurveEaseInOut animations:^{
            self.transform = CGAffineTransformMakeScale(0.95, 0.95);
        }];
        [self setupUI];
    }
    return self;
}



- (void)setupUI{
    self.backgroundColor = UIColor.grayColor;
    self.bgBackView = [[UIView alloc]initWithFrame:CGRectMake(20, 0,  [UIScreen mainScreen].bounds.size.width - 2 * 20, 410)];
    self.bgBackView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgBackView.layer.shadowOpacity = 0.2;
    self.bgBackView.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.bgImageView = [[UIImageView alloc]init];
    self.bgImageView.frame = self.bgBackView.bounds;
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImageView.layer.cornerRadius = 15.0;
    self.bgImageView.layer.masksToBounds = true;
    
    self.emptyView = [UIView alloc];
//    self.emptyView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    self.emptyView.frame = CGRectMake(0, self.bgImageView.frame.size.height, [UIScreen mainScreen].bounds.size.width - 2 * 20, 30);
    
    [self.bgBackView addSubview:self.bgImageView];
    [self.contentView addSubview:self.bgBackView];
//    [self.contentView addSubview:self.emptyView];
//    UILongPressGestureRecognizer * tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
//    [self.bgBackView addGestureRecognizer:tap];
//    self.multipleTouchEnabled = YES;

  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self jn_animate:YES];
}
 
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self jn_animate:NO];
}
 
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self jn_animate:NO];
}


- (void)jn_animate:(BOOL)highlight
{
    if (highlight) {
        [UIView animateWithDuration:0.45 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        [UIView animateWithDuration:0.45 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
 
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
        if ([view isKindOfClass:[UIButton class]]) {
            return view;
        }
        if ([view isDescendantOfView:self]) {
            return self;
        }
        return self;
}


@end
