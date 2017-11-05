//
//  ViewController.h
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    BOOL logIn;
}

@property (weak, nonatomic) IBOutlet UITextField *logInUsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *logInPassTextField;
- (IBAction)signUpButton:(id)sender;
- (IBAction)logInButton:(id)sender;

- (IBAction)switchMode:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *switchState;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint* bottomConstraint;

@property (nonatomic, strong) NSString* defaultsUser;
@property (nonatomic, strong) NSString* defaultsPass;

@property (nonatomic, strong) NSMutableArray* userCore;
@property (nonatomic, strong) NSMutableArray* passCore;

@property (nonatomic, strong) NSUserDefaults* defaults;
@property (nonatomic, strong) NSMutableArray* users;




@end

