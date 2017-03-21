//
//  ShareView.h
//  UMShare
//
//  Created by fanxiaobin on 2017/3/21.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

///点击回调
@property (nonatomic,copy) void (^imageViewTapActionBlock) (NSInteger index);

///初始化方法
-(instancetype)initWithFrame:(CGRect)frame shareTitle:(NSString *)shareTitle images:(NSArray *)images titles:(NSArray *)titles;

///计算高度 更新高度
- (void)updateShareViewHeightWithCount:(NSInteger)count;

///计算视图总高度
- (CGFloat)heightForShareViewWithCount:(NSInteger)count;


///分享数据
@property (nonatomic,copy) NSString *shareTitle;
@property (nonatomic,copy) NSString *shareUrl;
@property (nonatomic,copy) NSString *shareImage;
@property (nonatomic,copy) NSString *shareContent;
@property (nonatomic)            id targetVC;

@end
