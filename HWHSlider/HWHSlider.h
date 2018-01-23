//
//  HWHSlider.h
//  HWHSlider
//
//  Created by hu on 2017/12/14.
//  Copyright © 2017年 huweihong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HWHSliderViewDelegate <NSObject>

@optional
// 滑块滑动开始
- (void)sliderTouchBegan:(float)value;
// 滑块滑动中
- (void)sliderValueChanged:(float)value;
// 滑块滑动结束
- (void)sliderTouchEnded:(float)value;
// 滑杆点击
- (void)sliderTapped:(float)value;

@end

@interface HWHSlider : UIView
@property (nonatomic, weak) id<HWHSliderViewDelegate> delegate;

/** 默认滑杆的颜色 */
@property (nonatomic, strong) UIColor *maximumTrackTintColor;
/** 滑杆进度颜色 */
@property (nonatomic, strong) UIColor *minimumTrackTintColor;

/** 默认滑杆的图片 */
@property (nonatomic, strong) UIImage *maximumTrackImage;
/** 滑杆进度的图片 */
@property (nonatomic, strong) UIImage *minimumTrackImage;

/** 滑杆进度 */
@property (nonatomic, assign) float value;


// 设置滑块图片
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;
- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state;

@end



@interface UIView (HWHFrame)

@property (nonatomic, assign) CGFloat gk_top;
@property (nonatomic, assign) CGFloat gk_left;
@property (nonatomic, assign) CGFloat gk_right;
@property (nonatomic, assign) CGFloat gk_bottom;
@property (nonatomic, assign) CGFloat gk_width;
@property (nonatomic, assign) CGFloat gk_height;
@property (nonatomic, assign) CGFloat gk_centerX;
@property (nonatomic, assign) CGFloat gk_centerY;

@end
