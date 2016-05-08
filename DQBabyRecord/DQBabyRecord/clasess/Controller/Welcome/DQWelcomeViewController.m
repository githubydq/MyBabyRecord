//
//  DQWelcomeViewController.m
//  DQBabyRecord
//
//  Created by youdingquan on 16/5/9.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQWelcomeViewController.h"
#import "AppDelegate.h"

@interface DQWelcomeViewController ()
{
    UIImage * _image;
}
@property (weak, nonatomic) IBOutlet UILabel *second;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property(nonatomic,strong)NSTimer * timer;
@end

@implementation DQWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_image) {
        [self.backImage setImage:_image];
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerSelector) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

-(void)dealloc{
    [self timeOver];
}
-(void)timeOver{
    [self.timer invalidate];
    self.timer = nil;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] intoDrawer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mySetBackImage:(UIImage *)image{
    _image = image;
}

- (IBAction)welcomeClick:(id)sender {
    [self timeOver];
}

-(void)timerSelector{
    static NSInteger time = 2;
    if (time >= 0) {
        self.second.text = [NSString stringWithFormat:@"%lds",time];
        time--;
    }else{
        [self timeOver];
    }
}


@end
