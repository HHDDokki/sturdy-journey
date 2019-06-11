//
//  HHDCountDownManager.m
//  HWDMall
//
//  Created by HandC1 on 2018/12/1.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHDTimeInterval ()

@property (nonatomic, assign) NSInteger timeInterval;

+ (instancetype)timeInterval:(NSInteger)timeInterval;

@end


@interface HHDCountDownManager ()
/// 时间差字典(单位:秒)(使用字典来存放, 支持多列表或多页面使用)
@property (nonatomic, strong) NSMutableDictionary<NSString *, HHDTimeInterval *> *timeIntervalDict;
/// 后台模式使用, 记录进入后台的绝对时间
@property (nonatomic, assign) BOOL backgroudRecord;
@property (nonatomic, assign) CFAbsoluteTime lastTime;

@end

@implementation HHDCountDownManager

+ (instancetype)manager {
    static HHDCountDownManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HHDCountDownManager alloc]init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timer = nil;
        // 监听进入前台与进入后台的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)start {
    
    // 启动定时器
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    //创建定时器
    if (!self.timer) {
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    }else {
        return;
        dispatch_source_cancel(self.timer);
        self.timer = nil;
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    }
    //启动
//    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(0*NSEC_PER_SEC));
    //设置定时器的各种属性（开始时间，相隔时间）
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        [self timerAction];
    });

    dispatch_resume(self.timer);
    
}

- (void)reload {
    // 刷新只要让时间差为0即可
    _timeInterval = 0;
}

- (void)invalidate {
    
    if (self.timer == nil) {
        return;
    }
    dispatch_source_cancel(self.timer);
    self.timer = nil;
    
}

- (void)timerAction {
    // 定时器每次加1
    [self timerActionWithTimeInterval:1];
}

- (void)timerActionWithTimeInterval:(NSInteger)timeInterval {
    // 时间差+
    self.timeInterval += timeInterval;
    if (!self.timeIntervalDict.count) {
        return;
    }
    [self.timeIntervalDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, HHDTimeInterval * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.timeInterval += timeInterval;
    }];
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:HHDCountDownNotification object:nil userInfo:nil];
}

- (void)addSourceWithIdentifier:(NSString *)identifier {
    if (self.timeIntervalDict.count) {
        if ([self.timeIntervalDict objectForKey:identifier]) {
            return;
        }
    }
    HHDTimeInterval *timeInterval = self.timeIntervalDict[identifier];
    if (timeInterval) {
        timeInterval.timeInterval = 0;
    }else {
        [self.timeIntervalDict setObject:[HHDTimeInterval timeInterval:0] forKey:identifier];
    }
    
}

- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier {
    return self.timeIntervalDict[identifier].timeInterval;
}

- (void)reloadSourceWithIdentifier:(NSString *)identifier {
    if (![self.timeIntervalDict objectForKey:identifier]) {
        return ;
    }
    self.timeIntervalDict[identifier].timeInterval = 0;
}

- (void)reloadAllSource {
    [self.timeIntervalDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, HHDTimeInterval * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.timeInterval = 0;
    }];
}

- (void)removeSourceWithIdentifier:(NSString *)identifier {
    if ([self.timeIntervalDict objectForKey:identifier]) {
        [self.timeIntervalDict removeObjectForKey:identifier];
    }
}

- (void)removeAllSource {
    [self.timeIntervalDict removeAllObjects];
}

- (void)applicationDidEnterBackgroundNotification {
    self.backgroudRecord = (_timer != nil);
    if (self.backgroudRecord) {
        self.lastTime = CFAbsoluteTimeGetCurrent();
        [self invalidate];
    }
}

- (void)applicationWillEnterForegroundNotification {
    if (self.backgroudRecord) {
        CFAbsoluteTime timeInterval = CFAbsoluteTimeGetCurrent() - self.lastTime;
        // 取整
        [self timerActionWithTimeInterval:(NSInteger)timeInterval];
        [self start];
    }
}


- (NSMutableDictionary *)timeIntervalDict {
    if (!_timeIntervalDict) {
        _timeIntervalDict = [NSMutableDictionary dictionary];
    }
    return _timeIntervalDict;
}

NSString *const HHDCountDownNotification = @"HHDCountDownNotification";


@end


@implementation HHDTimeInterval

+ (instancetype)timeInterval:(NSInteger)timeInterval {
    HHDTimeInterval *object = [HHDTimeInterval new];
    object.timeInterval = timeInterval;
    return object;
}


@end
