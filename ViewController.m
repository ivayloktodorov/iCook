//
//  ViewController.m
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "NewRecipesViewController.h"
#import "AllRecipesViewController.h"
#import "SignUpViewController.h"
#import "changeVC.h"
#import "allUsersViewController.h"
#import "AlertView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self loadDataFromCoreData];
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.defaultsUser = [self.defaults stringForKey:@"defaultsUser"];
    self.defaultsPass = [self.defaults stringForKey:@"defaultsPass"];
    self.userCore = [self.users valueForKey:@"username"];
    self.passCore = [self.users valueForKey:@"password"];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
  }

- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}


- (IBAction)signUpButton:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignUpViewController* goToSignUpVC = [VC instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self presentViewController:goToSignUpVC animated:true completion:nil];
}


- (IBAction)logInButton:(id)sender {
    
    for (int i = 0; i < [_userCore count]; i++) {
     
        if ([_logInUsernameTextField.text isEqualToString:_userCore[i]] && [_logInPassTextField.text isEqualToString:_passCore[i]]) {
           
            [_defaults setValue:_logInUsernameTextField.text forKey:@"defaultsUser"];
            [_defaults setValue:_logInPassTextField.text forKey:@"defaultsPass"];
            [_defaults synchronize];
            
            NSManagedObjectContext *moc = [self managedObjectContext];
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
            
            NSError *error = nil;
            NSArray *results = [moc executeFetchRequest:request error:&error];
            if (!results) {
                NSLog(@"Error fetching User objects: %@\n%@", [error localizedDescription], [error userInfo]);
                abort();
            }
            [self goToAllRecipesVC];
            }
        else if ([_logInUsernameTextField.text isEqualToString:_userCore[i]] && ![_logInPassTextField.text isEqualToString:_passCore[i]]) {
             [AlertView showAlertViewWithTitle:@"Грешка" message:@"грешна парола" controller:self];
            _logInPassTextField.text = @"";
            }
        else {
            if ([_logInUsernameTextField.text isEqualToString:@""]) {
                [AlertView showAlertViewWithTitle:@"Грешка" message:@"моля попълнете потребителско име" controller:self];
            }
            if ([_logInPassTextField.text isEqualToString:@""]) {
                [AlertView showAlertViewWithTitle:@"Грешка" message:@"моля попълнете парола" controller:self];
           }
        }
    }
}
                     

- (IBAction)switchMode:(id)sender {
    
    if (!_switchState.on) {
        _switchLabel.text = @"Use CoreData";
    }
    else {
        _switchLabel.text = @"Use Server";
    }
}





-(void)goToAllRecipesVC {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AllRecipesViewController* goToAllRecipesVC = [VC instantiateViewControllerWithIdentifier:@"recipesTableVC"];
    [self presentViewController:goToAllRecipesVC animated:NO completion:nil];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)loadDataFromCoreData {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    self.users = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
    [self.view endEditing:YES];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterFromKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.bottomConstraint.constant = 30 + keyboardSize.height;
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    self.bottomConstraint.constant = 30;
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
