//
//  HHDWebView.m
//  HWDMall
//
//  Created by HandC1 on 2019/2/28.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "HHDWebView.h"
#import "LoginViewController.h"
#import "BFMallGoodsDetailController.h"
#import "WebMemberController.h"

@interface HHDWebView() <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler, UIScrollViewDelegate>

@property (nonatomic) BOOL isFirstLoading;
@property (nonatomic) BOOL isFinishLoading;
@property (nonatomic, strong) NSString *currentUrl;
@property (nonatomic, strong) NSString *notificationTag;
@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation HHDWebView

- (instancetype)initWithFrame:(CGRect)frame Url:(NSString *)url
{
    self = [super initWithFrame:frame];
    if (self) {
        self.url = url;
        NSURL *urlurl = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [self addSubview:self.mainWebView];
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 2)];
        self.progressView.progressTintColor = [UIColor blackColor];
        self.progressView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.progressView];
        NSURLRequest *request = [NSURLRequest requestWithURL:urlurl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
        [self.mainWebView loadRequest:request];
    }
    return self;
}

- (WKWebView *)mainWebView {
    if (!_mainWebView) {
        NSError *error;
        NSURL *URLBase = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString *URLAgreement = [[NSBundle mainBundle] pathForResource:@"agreement" ofType:@"html"];
        NSString *html = [NSString stringWithContentsOfFile:URLAgreement
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
        
        WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
        webConfig.preferences = [[WKPreferences alloc] init];
        webConfig.preferences.javaScriptEnabled = YES;
        webConfig.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
        WKUserContentController* userContent = [[WKUserContentController alloc] init];
        webConfig.suppressesIncrementalRendering = YES;
        webConfig.userContentController = userContent;
        [userContent addScriptMessageHandler:self name:@"goArticleList"];
        [userContent addScriptMessageHandler:self name:@"goArticleInfo"];
        [userContent addScriptMessageHandler:self name:@"goPay"];
        [userContent addScriptMessageHandler:self name:@"goLogin"];
        [userContent addScriptMessageHandler:self name:@"goAllComments"];
        [userContent addScriptMessageHandler:self name:@"goGoodsDetail"];
        webConfig.userContentController = userContent;
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - kTabbarHeight-kSafeAreaTopHeight)
                                                configuration:webConfig];
        webView.scrollView.delegate = self;
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        webView.allowsBackForwardNavigationGestures = YES;
        if (@available(iOS 11.0, *)) {
            webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {

        }
        
        [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
#pragma mark - 本地 html 文件加载方式
        //        [webView loadHTMLString:html baseURL:URLBase];
#pragma mark - 网络请求加载方式
        
//        NSString *webUrl = NSStringFormat(@"http://172.16.4.40:8080/#/test?token=%@&vipCode=%lu", [GVUserDefaults standardUserDefaults].token, (unsigned long)self.vipType);
        _mainWebView = webView;
//
    }
    return _mainWebView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.mainWebView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.mainWebView.estimatedProgress animated:YES];
        if (self.mainWebView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
    [self.mainWebView reload];
    
}

- (void)reload {
    
    [self.mainWebView stopLoading];
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
    }];
    NSURL *urlurl = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlurl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];

    [self.mainWebView loadRequest:request];
    [self.mainWebView reload];

}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([@"goArticleList" isEqualToString:message.name]) {
        
        NSLog(@"_+_+_+_+_+_+_+_++_+_%@", message.body);
        if ([message.body isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = message.body;
            NSString *value = [dic objectForKey:@"keyword"];
            NSString *url = NSStringFormat(@"http://39.106.97.82:8107/%@/%@", @"articleCate",value);
            WebMemberController *vc = [[WebMemberController alloc] init];
            vc.webUrl = url;
            vc.type = BFMALL_LIST;
            vc.title = value;
            [[ToolsManage getCurrentVC].navigationController pushViewController:vc animated:NO];
        }
       
    }
    
    if ([@"goArticleInfo" isEqualToString:message.name]) {
        
        if ([message.body isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = message.body;
            NSString *value = [dic objectForKey:@"id"];
            NSString *url = NSStringFormat(@"http://39.106.97.82:8107/%@/%@", @"articleDetail",value);
            WebMemberController *vc = [[WebMemberController alloc] init];
            vc.webUrl = url;
            vc.type = BAMALL_NORMAL;
            [[ToolsManage getCurrentVC].navigationController pushViewController:vc animated:NO];
        }
        NSLog(@"_+_+_+_+_+_+_+_++_+_%@", message.body);
        
    }
    
    if ([@"goPay" isEqualToString:message.name]) {
        
        if ([message.body isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = message.body;
            NSString *paymentMethod = [dic objectForKey:@"paymentMethod"];
            NSString *orderId = [dic objectForKey:@"orderId"];
            if (self.payblock) {
                self.payblock(orderId, paymentMethod);
            }
            
        }
        NSLog(@"_+_+_+_+_+_+_+_++_+_%@", message.body);
        
    }
    
    if ([@"goLogin" isEqualToString:message.name]) {
        
        if ([message.body isKindOfClass:[NSDictionary class]]) {
            LoginViewController *vc =  [[LoginViewController alloc] init];
            [[ToolsManage getCurrentVC].navigationController pushViewController:vc animated:NO];
        }
        NSLog(@"_+_+_+_+_+_+_+_++_+_%@", message.body);
        
    }
    
    if ([@"goAllComments" isEqualToString:message.name]) {
        
        if ([message.body isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = message.body;
            NSString *value = [dic objectForKey:@"articleId"];
            NSString *url = NSStringFormat(@"http://39.106.97.82:8107/%@/%@", @"allComment",value);
            WebMemberController *vc = [[WebMemberController alloc] init];
            vc.webUrl = url;
            vc.type = BFMALL_COMMON;
            vc.title = value;
            [[ToolsManage getCurrentVC].navigationController pushViewController:vc animated:NO];
        }
        NSLog(@"_+_+_+_+_+_+_+_++_+_%@", message.body);
        
    }
    
    if ([@"goGoodsDetail" isEqualToString:message.name]) {
        
        if ([message.body isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = message.body;
            NSNumber *value = [dic objectForKey:@"goodsId"];
            BFMallGoodsDetailController *vc = [[BFMallGoodsDetailController alloc] init];
            vc.goodsId = [value integerValue];
            [[ToolsManage getCurrentVC].navigationController pushViewController:vc animated:NO];
        }
        NSLog(@"_+_+_+_+_+_+_+_++_+_%@", message.body);
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return nil;
    
}

////设置头部标题
//- (void)getTitleWithFinishLoading {
//    NSString *title_text = [self.mainWebview stringByEvaluatingJavaScriptFromString:@"document.title"];
//    self.baseController.titleLabel.text = title_text;
//}

/* 页面开始加载 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
/* 开始返回内容 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self.mainWebView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
//    NSString *title_text = [self :@"document.title"];
//    if (self.finishblock) {
//        self.finishblock(title_text);
//    }

}
/* 页面加载失败 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

- (void)evaluateJs:(NSString *)js {
    
    [self.mainWebView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
    
}

- (void)dealloc{
    [self.mainWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end
