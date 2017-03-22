//
//  ViewController.m
//  UMShare
//
//  Created by fanxiaobin on 2017/3/21.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ViewController.h"
#import "ShareView.h"
#import "FFCoverPopView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"点我分享" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showShareView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
}

- (void)showShareView:(UIButton *)sender{
    
   
    NSArray *images = @[@"share_wx",@"share_timeLine",@"share_QQ",@"share_QQZone",@"share_timeLine",@"share_timeLine"];
    NSArray *titles = @[@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间",@"新浪微博",@"腾讯微博"];
    
    ShareView *share = [[ShareView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 0) shareTitle:@"分享一下" images:images titles:titles];
    share.targetVC = self;
    [self.view addSubview:share];
    
    CGFloat height = [share heightForShareViewWithCount:images.count];
    
    FFCoverPopView *pop = [[FFCoverPopView alloc] init];
    [pop coverPopViewShowSubView:share subViewHeight:height];
    
    share.imageViewTapActionBlock = ^(NSInteger index){
        NSLog(@"---- index = %ld",index);
        [pop hiddenCoverPopView];
    };
  
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
