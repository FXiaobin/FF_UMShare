//
//  AppDelegate.m
//  UMShare
//
//  Created by fanxiaobin on 2017/3/21.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "AppDelegate.h"
#import <UMMobClick/MobClick.h>
#import <UMSocialCore/UMSocialDataManager.h>
#import <UMSocialCore/UMSocialCore.h>

#define UM_APP_KEY  @"583b932d76661356dd00042b"


/* QQ Share */
#define QQ_APP_ID @"1105849820"
#define QQ_APP_KEY @"N3f14ioUcXFJlsbo"

/* Wechat Share */
#define WECHAT_APP_ID @"wxee1bd48ed4421c10"
#define WECHAT_APP_SECRET @"bb83a3a413f731db6583b18a7c9cc771"

#define SINA_WEIBO_APP_KEY @"359709779"
#define SINA_WEIBO_SECRET @"e0bd2b8af9806e7963faa94a893f1ae4"

/* AppId */
#define APPSTORE_ID @"1180466183"
#define APPSTORE_URL @"http://itunes.apple.com/app/id1180466183"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self configureUmeng];
    
    return YES;
}

- (void)configureUmeng {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];//设置当前应用版本号
    [MobClick setEncryptEnabled:YES];//设置日志加密
    
    UMConfigInstance.appKey = UM_APP_KEY;
    UMConfigInstance.channelId = nil;
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setLogEnabled:NO];
    
    
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UM_APP_KEY];
    [[UMSocialManager  defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APP_ID appSecret:QQ_APP_KEY redirectURL:APPSTORE_URL];
    [[UMSocialManager  defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:QQ_APP_ID appSecret:QQ_APP_KEY redirectURL:APPSTORE_URL];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_TencentWb appKey:QQ_APP_ID appSecret:QQ_APP_KEY redirectURL:APPSTORE_URL];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APP_ID appSecret:WECHAT_APP_SECRET redirectURL:APPSTORE_URL];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:WECHAT_APP_ID appSecret:WECHAT_APP_SECRET redirectURL:APPSTORE_URL];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINA_WEIBO_APP_KEY appSecret:SINA_WEIBO_SECRET redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    // [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
