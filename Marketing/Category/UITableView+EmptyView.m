//
//  UITableView+EmptyView.m
//  Marketing
//
//  Created by 王帅 on 2021/4/20.
//

#import "UITableView+EmptyView.h"
#import <objc/message.h>

static NSString *const NoDataEmptyViewKey = @"NoDataEmptyViewKey";

@implementation UITableView (EmptyView)

+ (void)load {
    Method originMethod = class_getInstanceMethod(self, @selector(reloadData));
    Method currentMethod = class_getInstanceMethod(self, @selector(new_reloadData));
    method_exchangeImplementations(originMethod, currentMethod);
}

#pragma mark - 刷新数据
- (void)new_reloadData {
    [self new_reloadData];
    [self loadEmptyView];
}

#pragma mark - 填充空白页
- (void)loadEmptyView {
    NSInteger sections = 0;
    NSInteger rows = 0;
    id <UITableViewDataSource> dataSource = self.dataSource;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self];
        if ([dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (int i=0; i<sections; i++) {
                rows += [dataSource tableView:self numberOfRowsInSection:i];
            }
        }
    }else if ([dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]){
        rows += [dataSource tableView:self numberOfRowsInSection:1];
    }
    
    if (rows == 0) {
        if (![self.subviews containsObject:self.emptyView]) {
            self.emptyView = [[NoDataEmptyView alloc] initWithFrame:self.bounds];
            [self addSubview:self.emptyView];
        }else{
            self.emptyView.hidden = NO;
        }
    }else{
        [self.emptyView removeFromSuperview];
    }
}


#pragma mark - 关联对象
- (void)setEmptyView:(NoDataEmptyView *)emptyView {
    objc_setAssociatedObject(self, &NoDataEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NoDataEmptyView *)emptyView {
    return objc_getAssociatedObject(self, &NoDataEmptyViewKey);
}

@end
