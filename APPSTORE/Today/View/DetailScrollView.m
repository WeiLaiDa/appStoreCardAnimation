//
//  DetailScrollView.m
//  APPSTORE
//
//  Created by Xuyiming on 2022/5/5.
//

#import "DetailScrollView.h"

@implementation DetailScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    NSString * textViewText = @"Thank you. I'm honored to be with you today for your commencement from one of the finest universities in the world. Truth be told, i never graduated from college and this is the closest I've ever gotten to a college gradution. \n\nToday i want to tell you three stories from my life. That's it. No big deal. Just three stories. The first story is about connecting the dots. \n\ndropped out of Reed College after the first 6 months, but then stayed around as a drop-in for another 18 months or so before I really quit. So why did I drop out? \n\nIt started before I was born. My biological mother was a young,unwed college graduate student, and she decided to put me up for adoption. She felt very strongly that I should be adopted by college graduates, so everything was all set for me to be adopted at birth by a lawyer and his wife. Except that when I popped out they decided at the last minute that they really wanted a girl. So my parents, who were on a waiting list, got a call in the middle of the night asking: 'We got an unexpected baby boy; do you want him?' They said: 'Of course.' My biological mother found out later that my mother had never graduated from college and  my father had never graduated from high school. She refused to sign the final adoption papers. She only relented a few months later when my parents promised that I would  go to college.from one of the finest universities in the world. Truth be told, i never graduated from college and this is the closest I've ever gotten to a college gradution. \n\nToday i want to tell you three stories from my life. That's it. No big deal. Just three stories. The first story is about connecting the dots. \n\ndropped out of Reed College after the first 6 months, but then stayed around as a drop-in for another 18 months or so before I® really quit. So why did I drop out? \n\nIt started before I was born. My biological mother was a young,unwed college graduate student, and she decided to put me up for adoption. She felt very strongly that I should be adopted by college graduates, so everything was all set for me to be adopted at birth by a lawyer and his wife. Except that when I popped out they decided at the last minute that they really wanted a girl. So my parents, who were on a waiting list, got a call in the middle of the night asking: 'We got an unexpected baby boy; do you want him?' They said: 'Of course.' My biological mother found out later that my mother had never graduated from college and  my father had never graduated from high school. She refused to sign the final adoption papers. She only relented a few months later when my parents promised that I would  go to college";
    self.delegate = self;
    _bgBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,500)];
    _bgBackView.layer.masksToBounds = YES;
    
    _imageView = [[UIImageView alloc]initWithFrame:_bgBackView.frame];
    _imageView.userInteractionEnabled = true;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    CGFloat textViewWidth = [UIScreen mainScreen].bounds.size.width - 40;
    CGSize maxSize = CGSizeMake(textViewWidth, CGFLOAT_MAX);
    CGFloat textHeight = [textViewText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15 weight:UIFontWeightBold]} context:nil].size.height;
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(20, _bgBackView.frame.size.height + 40, textViewWidth, textHeight + 50)];
    _textView.backgroundColor = UIColor.whiteColor;
    _textView.text= textViewText;
    _textView.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    _textView.textColor = [UIColor grayColor];
    _textView.scrollEnabled = NO;
    [_bgBackView addSubview:_imageView];
    [self addSubview:_textView];
    [self addSubview:_bgBackView];
    
    self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, +_bgBackView.frame.size.height + 40 + _textView.frame.size.height + 50);
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if(scrollView.contentOffset.y > 500){
//        CGRect frame = [self crect]
//        self.bgBackView.frame =
//    }
//}


@end
