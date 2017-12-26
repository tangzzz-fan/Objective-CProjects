//
//  ViewController.m
//  TGRacDemo
//
//  Created by MacPro on 2017/12/26.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"

#import "LoginViewModel.h"

#import "UserModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/** loginViewModel */
@property (nonatomic, strong) LoginViewModel *loginViewModel;
/** userModel */
@property (nonatomic, strong) UserModel *user;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindViewModel];
}

- (void)bindViewModel {
    RAC(self.loginViewModel, userName) = self.userNameText.rac_textSignal;
    RAC(self.loginViewModel, password) = self.passwordText.rac_textSignal;
//    self.loginViewModel.loginBtnEnableSignal = RACObserve(self.loginBtn, enabled);
    RAC(self.loginBtn, enabled) = self.loginViewModel.loginBtnEnableSignal;
}

- (LoginViewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}
@end
