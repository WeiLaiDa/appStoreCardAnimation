//
//  CardDetailViewController.h
//  APPSTORE
//
//  Created by Xuyiming on 2022/4/29.
//

#import <UIKit/UIKit.h>
#import "TodayTableVIewCell.h"
#import "DetailScrollView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CardDetailViewController : UIViewController

@property (nonatomic ,copy)dispatch_block_t dismissClosure;

@property (nonatomic ,strong)UIPanGestureRecognizer * dismissPanGesture;

@property (nonatomic ,strong)UIScreenEdgePanGestureRecognizer * screenPanGesture;

@property (nonatomic ,assign)CGPoint interactiveStartingPoint;

@property (nonatomic ,assign)BOOL draggingDownToDismiss;

@property (nonatomic ,strong)TodayTableVIewCell * cell;

@property (nonatomic ,strong)DetailScrollView * scrollView;

@property (nonatomic ,strong)UIButton * closeBtn;


- (instancetype)initWithCell:(TodayTableVIewCell *)cell;

@end

NS_ASSUME_NONNULL_END
