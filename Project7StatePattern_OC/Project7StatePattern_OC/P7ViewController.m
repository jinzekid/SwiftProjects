//
//  ViewController.m
//  Project7StatePattern_OC
//
//  Created by apple on 6/13/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

#import "P7ViewController.h"
#import "UserLoginManager.h"
#import "UserState.h"
#import "UserLoginState.h"
#import "UserLogoutState.h"


@interface P7ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation P7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginAction:(id)sender {
    UserLoginState * loginState = [[UserLoginState alloc] init];
    [[UserLoginManager shareInstance] setUserState:loginState];
//    [[UserLoginManager shareInstance] userToScan];
}

- (IBAction)logoutAction:(id)sender {
     UserLogoutState* logoutState = [[UserLogoutState alloc] init];
    [[UserLoginManager shareInstance] setUserState:logoutState];
//    [[UserLoginManager shareInstance] userToScan];
}

- (IBAction)scan:(id)sender {
    [[UserLoginManager shareInstance] userToScan];
}

@end
