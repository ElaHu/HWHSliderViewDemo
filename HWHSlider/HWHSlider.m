//
//  HWHSlider.m
//  HWHSlider
//
//  Created by hu on 2017/12/14.
//  Copyright © 2017年 huweihong. All rights reserved.
//

#import "HWHSlider.h"

/**左边间距*/
#define Left_X 30
#define progressH 4.0

#define progressH 4.0

#define sliderBtn_width 44.0
@interface HWHSlider()
@property (nonatomic, strong) UIImageView * bgProgressView;
@property (nonatomic, strong) UIImageView * sliderProgressView;
@property (nonatomic, strong) UIButton * sliderBtn;
@end

@implementation HWHSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews{

    UIImageView * bgP = [[UIImageView alloc]initWithFrame:CGRectMake(Left_X, self.gk_height/2.0 - progressH/2.0 , self.gk_width - 2*Left_X, progressH)];
    bgP.userInteractionEnabled = YES;
    [self addSubview:bgP];
    self.bgProgressView  = bgP;


    UIImageView * sliderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, progressH)];
    sliderView.userInteractionEnabled = YES;
    [bgP addSubview:sliderView];
    self.sliderProgressView = sliderView;

    UIButton * sliderBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, sliderBtn_width, sliderBtn_width)];
    sliderBtn.center = CGPointMake(Left_X,self.gk_height/2.0);

    [sliderBtn addTarget:self action:@selector(sliderBtnTouchBegin:) forControlEvents:UIControlEventTouchDown];
    [sliderBtn addTarget:self action:@selector(sliderBtnTouchEnded:) forControlEvents:UIControlEventTouchCancel];
    [sliderBtn addTarget:self action:@selector(sliderBtnTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
    [sliderBtn addTarget:self action:@selector(sliderBtnTouchEnded:) forControlEvents:UIControlEventTouchUpOutside];
    [sliderBtn addTarget:self action:@selector(sliderBtnDragMoving:event:) forControlEvents:UIControlEventTouchDragInside];

    [self addSubview:sliderBtn];
    self.sliderBtn = sliderBtn;


    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tapGesture];


}


#pragma mark - User Action
- (void)sliderBtnTouchBegin:(UIButton *)btn {

    if ([self.delegate respondsToSelector:@selector(sliderTouchBegan:)]) {
        [self.delegate sliderTouchBegan:self.value];
    }
}

- (void)sliderBtnTouchEnded:(UIButton *)btn {

    if ([self.delegate respondsToSelector:@selector(sliderTouchEnded:)]) {
        [self.delegate sliderTouchEnded:self.value];
    }
}

- (void)sliderBtnDragMoving:(UIButton *)btn event:(UIEvent *)event {

    // 点击的位置
    CGPoint point = [event.allTouches.anyObject locationInView:self];

    // 获取进度值 由于btn是从 0-(self.width - btn.width)
    float value = (point.x - Left_X) / self.bgProgressView.gk_width;

    // value的值需在0-1之间
    value = value >= 1.0 ? 1.0 : value <= 0.0 ? 0.0 : value;

    [self setValue:value];

    if ([self.delegate respondsToSelector:@selector(sliderValueChanged:)]) {
        [self.delegate sliderValueChanged:value];
    }
}

- (void)tapped:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];

    // 获取进度
    float value = (point.x - Left_X) / self.bgProgressView.gk_width;
    value = value >= 1.0 ? 1.0 : value <= 0 ? 0 : value;

    [self setValue:value];

    if ([self.delegate respondsToSelector:@selector(sliderTapped:)]) {
        [self.delegate sliderTapped:value];
    }
}


#pragma mark - Setter
- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _maximumTrackTintColor = maximumTrackTintColor;

    self.bgProgressView.backgroundColor = maximumTrackTintColor;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    _minimumTrackTintColor = minimumTrackTintColor;

    self.sliderProgressView.backgroundColor = minimumTrackTintColor;
}

- (void)setMaximumTrackImage:(UIImage *)maximumTrackImage {
    _maximumTrackImage = maximumTrackImage;

    self.bgProgressView.image = maximumTrackImage;
    self.maximumTrackTintColor = [UIColor clearColor];
}

- (void)setMinimumTrackImage:(UIImage *)minimumTrackImage {
    _minimumTrackImage = minimumTrackImage;

    self.sliderProgressView.image = minimumTrackImage;

    self.minimumTrackTintColor = [UIColor clearColor];
}


- (void)setValue:(float)value {
    _value = value;

    CGFloat finishValue  = self.bgProgressView.gk_width * value;
    self.sliderProgressView.gk_width = finishValue;

    self.sliderBtn.gk_left = finishValue + Left_X - sliderBtn_width/2.0;

}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self.sliderBtn setBackgroundImage:image forState:state];
}

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state {
    [self.sliderBtn setImage:image forState:state];

}

@end

@implementation UIView (HWHFrame)
- (void)setGk_left:(CGFloat)gk_left{
    CGRect f = self.frame;
    f.origin.x = gk_left;
    self.frame = f;
}

- (CGFloat)gk_left {
    return self.frame.origin.x;
}

- (void)setGk_top:(CGFloat)gk_top {
    CGRect f = self.frame;
    f.origin.y = gk_top;
    self.frame = f;
}

- (CGFloat)gk_top {
    return self.frame.origin.y;
}

- (void)setGk_right:(CGFloat)gk_right {
    CGRect f = self.frame;
    f.origin.x = gk_right - f.size.width;
    self.frame = f;
}

- (CGFloat)gk_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setGk_bottom:(CGFloat)gk_bottom {
    CGRect f = self.frame;
    f.origin.y = gk_bottom - f.size.height;
    self.frame = f;
}

- (CGFloat)gk_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setGk_width:(CGFloat)gk_width {
    CGRect f = self.frame;
    f.size.width = gk_width;
    self.frame = f;
}

- (CGFloat)gk_width {
    return self.frame.size.width;
}

- (void)setGk_height:(CGFloat)gk_height {
    CGRect f = self.frame;
    f.size.height = gk_height;
    self.frame = f;
}

- (CGFloat)gk_height {
    return self.frame.size.height;
}

- (void)setGk_centerX:(CGFloat)gk_centerX {
    CGPoint c = self.center;
    c.x = gk_centerX;
    self.center = c;
}

- (CGFloat)gk_centerX {
    return self.center.x;
}

- (void)setGk_centerY:(CGFloat)gk_centerY {
    CGPoint c = self.center;
    c.y = gk_centerY;
    self.center = c;
}

- (CGFloat)gk_centerY {
    return self.center.y;
}
@end
