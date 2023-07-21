//
//  DetailScrollView.h
//  APPSTORE
//
//  Created by Xuyiming on 2022/5/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic ,strong)UIView * bgBackView;
@property (nonatomic ,strong)UIImageView * imageView;
@property (nonatomic ,strong)UITextView * textView;

@end

NS_ASSUME_NONNULL_END
