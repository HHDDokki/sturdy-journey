//
//  ShareTools.m
//  HWDMall
//
//  Created by 肖旋 on 2018/12/15.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import "ShareTools.h"

@implementation ShareTools

+ (instancetype)sharedSingleton {
    static ShareTools *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
    });
    return _sharedSingleton;
}

- (void)shareToXCXWithType:(XCXType)type path:(NSString *)path imageData:(NSData *)imageData title:(NSString *)title description:(NSString *)description {
    WXMiniProgramObject *object = [WXMiniProgramObject object];
    object.webpageUrl = NSStringFormat(@"%@%@", kApiStaticPrefix, kApi_weichat_download);
    if (type == XCXType_Main) {
        object.userName = @"gh_8055109a3a2f";//主程序id z
//        object.userName = @"gh_7254b493cda2";//主程序id c
    } else if (type == XCXType_Pin) {
        object.userName = @"gh_c9e1b8ec112f"; //拼程序id z
//        object.userName = @"gh_6001921a3677"; //拼程序id c
    } else {
        object.userName = @"gh_d98bea7e3b13"; //砍小程序 z
//        object.userName = @"gh_6a3116bda6fd"; //砍小程序 c
    }
    
    object.path = path;//小程序路径
    object.hdImageData = imageData;
    object.withShareTicket = NO;
    object.miniProgramType = WXMiniProgramTypeRelease;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.thumbData = nil;  //兼容旧版本节点的图片，小于32KB，新版本优先
    //使用WXMiniProgramObject的hdImageData属性
    message.mediaObject = object;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;  //目前只支持会话
    BOOL a= [WXApi sendReq:req];
    
}

- (void)shareLongImgToWCTimelineWithImage:(UIImage *)image {
    
    NSData *imageData = [NSData data];
    imageData = UIImageJPEGRepresentation(image, 0.7);
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res5"
                                                         ofType:@"jpg"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
    
}
- (void)shareLongImgToWCWithImage:(UIImage *)image {
    
    NSData *imageData = [NSData data];
    imageData = UIImageJPEGRepresentation(image, 0.7);
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res5"
                                                         ofType:@"jpg"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    
}

@end
