//
//  TGBaseObject.m
//  TGTestProtocol
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGBaseObject.h"

@interface TGBaseObject()<UITableViewDelegate, UITableViewDataSource, TGBaseProtocol>

@property (strong, nonatomic) NSMutableArray<id<TGBaseProtocol>> *childDelegates;

@end

@implementation TGBaseObject
- (instancetype)initWithIndex:(NSInteger)index ChildDelegates:(NSMutableArray<id<TGBaseProtocol>> *)childDelegates TableView:(UITableView *)tableView {
    if (self = [super init]) {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        // 初始化 childDelegates
        [self validateChildDelegates:childDelegates];
        
    }
    return self;
}

#pragma mark - Functions
- (void)objectName {
    NSLog(@"this is called in baseObject objectname");
}



#pragma mark - Private Functions
- (void)validateChildDelegates:(NSMutableArray<id<TGBaseProtocol>> *)childDelegates {
    if (!childDelegates.count) {
        return;
    }
    self.childDelegates = childDelegates;
    [self.childDelegates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj changedName:[NSString stringWithFormat:@"this is changed name %zd", idx]];
    }];
}


#pragma mark - DataSource
#pragma mark TGBaseProtocol
- (void)name {
    NSLog(@"my name is tgBaseName");
}

- (void)changedName:(NSString *)name {
    NSLog(@"this is called in changed name");
}


#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
