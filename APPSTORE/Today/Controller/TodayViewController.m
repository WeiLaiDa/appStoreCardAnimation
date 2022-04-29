//
//  TodayViewController.m
//  APPSTORE
//
//  Created by Xuyiming on 2022/4/29.
//

#import "TodayViewController.h"
#import "TodayTableVIewCell.h"
#import "CardDetailViewController.h"

@interface TodayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView * tableView;
@property (nonatomic ,assign)BOOL statusBarShouldBeHidden;


@end

static NSString * const TodayTableVIewCellID = @"TodayTableVIewCell";

@implementation TodayViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    
    self.statusBarShouldBeHidden = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 440;
    self.tableView.backgroundColor = UIColor.grayColor;
    [self.tableView registerClass:[TodayTableVIewCell class] forCellReuseIdentifier:TodayTableVIewCellID];

    [self.view addSubview:self.tableView];
}

// 状态栏隐藏/显示
- (void)updateStatusBarAndTabbarFrame:(BOOL)visible{
    self.statusBarShouldBeHidden = !visible;
    [UIView animateWithDuration:0.25 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayTableVIewCell * cell = [tableView dequeueReusableCellWithIdentifier:TodayTableVIewCellID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"cover_%ld",indexPath.row + 1]];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayTableVIewCell * cell = (TodayTableVIewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return;
    }
    self.selectedCell = cell;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.bgBackView.hidden = YES;
    });
    
    CardDetailViewController * detailVC = [[CardDetailViewController alloc]initWithCell:cell];
    __weak typeof(self) weakSelf = self;
    detailVC.dismissClosure = ^{
        [weakSelf updateStatusBarAndTabbarFrame:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.bgBackView.hidden = NO;
        });
       
    };
    [self updateStatusBarAndTabbarFrame:NO];
    
    [self presentViewController:detailVC animated:true completion:nil];
    
}

#pragma mark --- 状态栏相关 ---

- (BOOL)prefersStatusBarHidden{
    return self.statusBarShouldBeHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationSlide;
}

@end
