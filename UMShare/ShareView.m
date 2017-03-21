//
//  ShareView.m
//  UMShare
//
//  Created by fanxiaobin on 2017/3/21.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ShareView.h"
#import <Masonry.h>

#import <UMSocialCore/UMSocialDataManager.h>
#import <UMSocialCore/UMSocialCore.h>


#define PlatformIcon_Tag    8238924

@interface ShareView ()

@property (nonatomic) BOOL hasTitle;

@end

@implementation ShareView

-(instancetype)initWithFrame:(CGRect)frame shareTitle:(NSString *)shareTitle images:(NSArray *)images titles:(NSArray *)titles{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        
        CGFloat wRate = [UIScreen mainScreen].bounds.size.width / 375.0;
        
        ///标题
        if (shareTitle) {
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.text = shareTitle;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(15*wRate);
                make.left.equalTo(self).offset(30);
                make.right.equalTo(self.mas_right).offset(-30);
                make.height.mas_equalTo(25*wRate);
            }];
        }
        
        //底图
        UIImageView *bgImage = [UIImageView new];
        bgImage.userInteractionEnabled = YES;
        //bgImage.backgroundColor = [UIColor cyanColor];
        [self addSubview:bgImage];
        
        CGFloat topMargin = 0;
        if (shareTitle && shareTitle.length) {
            self.hasTitle = YES;
            topMargin = 60*wRate;
        }
        
        UIEdgeInsets insets = UIEdgeInsetsMake(topMargin, 30*wRate, 0, 30*wRate);
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(insets);
        }];
        
        //底图的宽度
        CGFloat bgImageWidth = CGRectGetWidth(self.frame) -  insets.left - insets.right;
        
        //6个平台
        for (int i = 0; i < images.count; i++) {
            NSInteger row = i / 3, cloum = i % 3;
            CGFloat itemWidth = 80 * wRate, itemHerSpace = (bgImageWidth - 3 * itemWidth) / 2.0, itemVerSpace = 20*wRate ;
            
            UIImageView *platformIcon = [UIImageView new];
            platformIcon.image = [UIImage imageNamed:images[i]];
            platformIcon.userInteractionEnabled = YES;
            platformIcon.frame = CGRectMake((itemWidth + itemHerSpace) * cloum, (itemWidth + 30*wRate + itemVerSpace) * row , itemWidth, itemWidth);
            //platformIcon.backgroundColor = [UIColor blueColor];
            platformIcon.tag = PlatformIcon_Tag + i;
            [bgImage addSubview:platformIcon];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction:)];
            [platformIcon addGestureRecognizer:tap];
            
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:16*wRate];
            //label.backgroundColor = [UIColor yellowColor];
            label.text = titles[i];
            
            
            [bgImage addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(platformIcon.mas_bottom).offset(10*wRate);
                make.centerX.equalTo(platformIcon.mas_centerX);
                make.height.mas_equalTo(20*wRate);
            }];
      
        }
   
    }
    return self;
}

///更新视图frame
- (void)updateShareViewHeightWithCount:(NSInteger)count{
  
    CGFloat height = [self heightForShareViewWithCount:count];

    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}

///计算视图总高度
- (CGFloat)heightForShareViewWithCount:(NSInteger)count{
    
    NSInteger row = (count % 3 == 0) ? count / 3 : count / 3 + 1;
    CGFloat wRate = [UIScreen mainScreen].bounds.size.width / 375.0;

    CGFloat itemHeight = 80 * wRate, itemVerSpace = 20*wRate, topMargin = self.hasTitle ? 60*wRate : 0.0;
    
    return (itemHeight + 30*wRate + itemVerSpace) * row + topMargin;
    
}

- (void)imageViewTapAction:(UITapGestureRecognizer *)sender{
    NSInteger index = sender.view.tag - PlatformIcon_Tag;
    if (self.imageViewTapActionBlock) {
        self.imageViewTapActionBlock(index);
    }
    
    switch (index) {
        case 0: {
            [self shareWithPlatformType:UMSocialPlatformType_WechatSession];
            
        } break;
        case 1: {
            [self shareWithPlatformType:UMSocialPlatformType_WechatTimeLine];
            
        } break;
        case 2: {
            [self shareWithPlatformType:UMSocialPlatformType_QQ];
            
        } break;
        case 3: {
            [self shareWithPlatformType:UMSocialPlatformType_Qzone];
            
        } break;
        case 4: {
            [self shareWithPlatformType:UMSocialPlatformType_Sina];
            
        } break;
        case 5: {
            [self shareWithPlatformType:UMSocialPlatformType_TencentWb];
            
        } break;
            
        default:
            break;
    }
}

- (void)handleShareData{
    
    _shareTitle =  @"分享标题";
    _shareContent =  @"发生龙卷风拉萨的发生的接发的是房间来看的房间爱离开京东方";
    _shareUrl = @"http://www.baidu.com";
    _shareImage = @"http://img06.tooopen.com/images/20170321/tooopen_sl_202706843723.jpg";
    
}


- (void)shareWithPlatformType:(UMSocialPlatformType)platformType{
    [self handleShareData];
    

    //注意 新浪要强制加上thumImage缩略图 腾讯微博不支持web分享 可在
    //http://dev.umeng.com/social/ios/进阶文档#2 (2.1  第三方平台支持的分享类型总览)中查看支持类型
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (platformType == UMSocialPlatformType_TencentWb) {   //腾讯微博 图片分享
        
        //messageObject.text = @"分享文本绝地反击;阿里斯顿";
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = [UIImage imageNamed:@"placeholder_image"];
        [shareObject setShareImage:_shareImage];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
    }else{
        
        if (![[UMSocialManager defaultManager] isInstall:platformType]) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未安装对应app" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [av show];
            return;
        }

        
        //web链接分享
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_shareTitle descr:_shareContent thumImage:[UIImage imageNamed:@"placeholder_image"]];
        shareObject.webpageUrl = _shareUrl;
        messageObject.shareObject = shareObject;
    }
   
    
    UMSocialManager *socialManager = [UMSocialManager defaultManager];
    
    [socialManager shareToPlatform:platformType messageObject:messageObject currentViewController:self.targetVC completion:^(id result, NSError *error) {
        
        if (error) {
            NSLog(@"--- error = %@",error);
        }else{
            NSLog(@"----- 分享成功 -------");
            if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = result;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",result);
            }
        }
    }];
}



@end
