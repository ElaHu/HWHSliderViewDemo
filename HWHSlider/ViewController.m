//
//  ViewController.m
//  HWHSlider
//
//  Created by hu on 2017/12/14.
//  Copyright © 2017年 huweihong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HWHSlider * slider = [[HWHSlider alloc]initWithFrame:CGRectMake(7, 100, 400, 40)];
    slider.backgroundColor = [UIColor clearColor];
    slider.delegate = self;

    slider.maximumTrackImage = [UIImage imageNamed:@"graybar"];
    slider.minimumTrackImage = [UIImage imageNamed:@"goldenbar"];
    [slider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateHighlighted];

    [self.view addSubview:slider];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)sliderValueChanged:(float)value{
    NSLog(@"value ===== %f",value);
}
- (void)sliderTapped:(float)value{
    NSLog(@"tapValue ===== %f",value);
}
@end
