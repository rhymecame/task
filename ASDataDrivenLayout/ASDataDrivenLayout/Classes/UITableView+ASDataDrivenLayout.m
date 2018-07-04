//
//  UITableView+UITableView_ASDataDivenLayout.m
//  ASDataDrivenLayout
//
//  Created by Andy on 2017/7/21.
//

#import "UITableView+ASDataDrivenLayout.h"
#import "ASDelegateAndDataSource.h"
#import "ASSectionInfo.h"
#import "ASCellInfo.h"
#import <objc/runtime.h>

@interface _ASTableViewProxy: NSProxy

@property (nonatomic, weak) id<NSObject> target;
@property (nonatomic, weak) id<NSObject> interceptor;

- (instancetype)initWithTarget:(id<NSObject>)target interceptor:(id<NSObject>)interceptor;

@end

@implementation _ASTableViewProxy

- (instancetype)initWithTarget:(id<NSObject>)target interceptor:(id<NSObject>)interceptor {
    if (self) {
        _target = target;
        _interceptor = interceptor;
    }
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_interceptor respondsToSelector:aSelector] || [_target respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([_interceptor respondsToSelector:aSelector]) {
        return _interceptor;
    }
    
    return [_target respondsToSelector:aSelector] ? _target : nil;
}
@end


@implementation UITableView (ASDataDrivenLayout)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originDataSourceSetter = class_getInstanceMethod([self class], @selector(setDataSource:));
        Method swizzleDataSourceSetter = class_getInstanceMethod([self class], @selector(as_setDataSource:));
        method_exchangeImplementations(originDataSourceSetter, swizzleDataSourceSetter);
        
        Method originDelegateSetter = class_getInstanceMethod([self class], @selector(setDelegate:));
        Method swizzleDelegateSetter = class_getInstanceMethod([self class], @selector(as_setDelegate:));
        method_exchangeImplementations(originDelegateSetter, swizzleDelegateSetter);
    });
}

- (void)as_setDelegate:(id<UITableViewDelegate>)delegate {
    if (self.enableDataDrivenLayout) {
        id proxy = [self delegateProxyWithDelegate:delegate interceptor:self.delegateAndDataSource];
        objc_setAssociatedObject(self, @selector(as_setDelegate:), proxy, OBJC_ASSOCIATION_RETAIN);
        [self as_setDelegate:proxy];
    } else {
        [self as_setDelegate:delegate];
    }
}

- (void)as_setDataSource:(id<UITableViewDataSource>)dataSource {
    if (self.enableDataDrivenLayout) {
        id proxy = [self dataSourceProxyWithDataSource:dataSource interceptor:self.delegateAndDataSource];
        objc_setAssociatedObject(self, @selector(as_setDataSource:), proxy, OBJC_ASSOCIATION_RETAIN);
        [self as_setDataSource:proxy];
    } else {
        [self as_setDataSource:dataSource];
    }
}

# pragma mark - Setters and Getters

- (void)setEnableDataDrivenLayout:(BOOL)enableDataDrivenLayout {
    objc_setAssociatedObject(self, @selector(enableDataDrivenLayout), @(enableDataDrivenLayout), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)enableDataDrivenLayout {
    return [objc_getAssociatedObject(self, @selector(enableDataDrivenLayout)) boolValue];
}

- (void)setSectionInfos:(NSArray<ASSectionInfo *> *)sectionInfos {
    objc_setAssociatedObject(self, @selector(sectionInfos), sectionInfos, OBJC_ASSOCIATION_RETAIN);
}

- (NSArray<ASSectionInfo*>*)sectionInfos {
    return objc_getAssociatedObject(self, @selector(sectionInfos));
}

- (_ASTableViewProxy*)dataSourceProxyWithDataSource:(id<UITableViewDataSource>) dataSource
                                        interceptor:(id<UITableViewDataSource>) interceptor{
    _ASTableViewProxy *_dataSourceProxy = objc_getAssociatedObject(self, @selector(dataSourceProxyWithDataSource:interceptor:));
    if (!_dataSourceProxy) {
        _dataSourceProxy = [[_ASTableViewProxy alloc] initWithTarget:dataSource interceptor:interceptor];
        objc_setAssociatedObject(self,
                                 @selector(dataSourceProxyWithDataSource:interceptor:),
                                 _dataSourceProxy,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    return _dataSourceProxy;
}

- (_ASTableViewProxy*)delegateProxyWithDelegate:(id<UITableViewDelegate>)delegate
                                    interceptor:(id<UITableViewDelegate>)interceptor{
    _ASTableViewProxy *_delegateProxy = objc_getAssociatedObject(self, @selector(delegateProxyWithDelegate:interceptor:));
    if (!_delegateProxy) {
        _delegateProxy = [[_ASTableViewProxy alloc] initWithTarget:delegate interceptor:interceptor];
        objc_setAssociatedObject(self,
                                 @selector(delegateProxyWithDelegate:interceptor:),
                                 _delegateProxy,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    return _delegateProxy;
}

- (ASDelegateAndDataSource*)delegateAndDataSource {
    ASDelegateAndDataSource *_delegateAndDataSource = objc_getAssociatedObject(self, @selector(delegateAndDataSource));
    if (!_delegateAndDataSource) {
        _delegateAndDataSource = [ASDelegateAndDataSource new];
        objc_setAssociatedObject(self, @selector(delegateAndDataSource), _delegateAndDataSource, OBJC_ASSOCIATION_RETAIN);
    }
    return _delegateAndDataSource;
}

- (ASCellInfo*)as_cellInfoForIndexPath:(NSIndexPath*)indexpath {
    return self.sectionInfos[indexpath.section].cellInfos[indexpath.row];
}

@end

