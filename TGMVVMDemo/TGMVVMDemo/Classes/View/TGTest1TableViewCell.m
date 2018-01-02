//
//  TGTestTableViewCell.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGTest1TableViewCell.h"
#import "TGTest1ViewModel.h"
#import "TGBaseModel.h"

@implementation TGTest1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params {
    TGTest1ViewModel *test1VM = (TGTest1ViewModel *)viewModel;
//    NSIndexPath *indexPath = params[@"DataIndexPath"];
    
    NSInteger indexpathRow = [params[@"DataIndexPath"] integerValue];
    TGBaseModel *model = test1VM.modelArray[indexpathRow];
    self.TestLabel.text = model.description;
}
@end
