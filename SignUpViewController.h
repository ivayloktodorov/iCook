//
//  SignUpViewController.h
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"

@interface SignUpViewController : ViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
    
}

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTextField;
@property (nonatomic,strong) NSMutableArray* users;
@property (nonatomic, strong) NSMutableArray* userCore;
@property (nonatomic, strong) NSMutableArray* passCore;


@property (nonatomic, strong) UIImagePickerController* picker;
@property (nonatomic, strong) NSData *coreImage;
@property (nonatomic, retain) UIImage *chosenImage;
@property(nonatomic, assign) id<UINavigationControllerDelegate,
UIImagePickerControllerDelegate> delegate;


- (IBAction)signUpNewUserButton:(id)sender;
- (IBAction)backButton:(id)sender;

- (IBAction)profileImage:(id)sender;

@end
