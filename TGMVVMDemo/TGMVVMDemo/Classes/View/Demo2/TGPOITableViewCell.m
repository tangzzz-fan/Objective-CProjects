//
//  TGPOITableViewCell.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGPOITableViewCell.h"
#import "TGPOICellViewModel.h"

@interface TGPOITableViewCell()
/** viewModel */
@property (nonatomic, strong) TGPOICellViewModel *viewModel;
@end

@implementation TGPOITableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

// 重载父类方法
- (void)bindViewModel:(TGPOICellViewModel *)viewModel {
    RAC(_titleLabel, text) = [viewModel.titleSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_priceLabel, attributedText) = [viewModel.priceSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_rightFooterLabel, text) = [viewModel.rightFooterSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_campaignLabel, text) = [viewModel.campaignSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_campaignView, hidden) = [viewModel.campaignHiddenSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_frontImageView, image) = [viewModel.frontImageSignal takeUntil:self.rac_prepareForReuseSignal];
    _viewModel = viewModel;
}

// 执行将 UI 中的 UI 属性和 viewModel 中的信号变量绑定
- (void)bindViewModel:(TGPOICellViewModel *)viewModel withParams:(NSDictionary *)params {
    
    RAC(_titleLabel, text) = [viewModel.titleSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_priceLabel, attributedText) = [viewModel.priceSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_rightFooterLabel, text) = [viewModel.rightFooterSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_campaignLabel, text) = [viewModel.campaignSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_campaignView, hidden) = [viewModel.campaignHiddenSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_frontImageView, image) = [viewModel.frontImageSignal takeUntil:self.rac_prepareForReuseSignal];
    _viewModel = viewModel;
}
@end
