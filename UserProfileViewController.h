//
//  UserProfileViewController.h
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"

@interface UserProfileViewController : ViewController 

@property (retain, nonatomic) IBOutlet UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;



@property (weak, nonatomic) IBOutlet UITextField *changePassTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyNewPassTextField;
@property (weak, nonatomic) IBOutlet UILabel *firstLast;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (nonatomic, strong) NSMutableArray* users;
@property (nonatomic, strong) NSUserDefaults* defaults;

@property (nonatomic, strong) NSString* defaultsUser;
@property (nonatomic, strong) NSString* defaultsPass;
@property (nonatomic, strong) NSString* first;
@property (nonatomic, strong) NSString* last;
@property (nonatomic, strong) NSString* email;

@property (nonatomic, strong) NSMutableArray* userCore;
@property (nonatomic, strong) NSMutableArray* passCore;
@property (nonatomic, strong) NSData *coreImage;
@property (nonatomic, retain) UIImage *chosenImage;

@property(nonatomic, assign) id<UINavigationControllerDelegate,
UIImagePickerControllerDelegate> delegate;

- (IBAction)saveNewPassButton:(id)sender;
- (IBAction)allUsersButton:(id)sender;
- (IBAction)logOutButton:(id)sender;

- (IBAction)backButton:(id)sender;
- (IBAction)newImage:(id)sender;
@end
