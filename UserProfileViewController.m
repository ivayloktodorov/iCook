//
//  UserProfileViewController.m
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "UserProfileViewController.h"
#import <CoreData/CoreData.h>
#import "CustomCell.h"
#import "ViewController.h"
#import "RecipesDetailViewController.h"
#import "NewRecipesViewController.h"
#import "AllRecipesViewController.h"
#import "SignUpViewController.h"
#import "AlertView.h"
#import "allUsersViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromCoreData];
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.defaultsUser = [self.defaults stringForKey:@"defaultsUser"];
    self.defaultsPass = [self.defaults stringForKey:@"defaultsPass"];
    self.userCore = [self.users valueForKey:@"username"];
    self.passCore = [self.users valueForKey:@"password"];
    
    
    self.usernameLabel.text = self.defaultsUser;
    
    
    for (int i = 0; i < [self.users count]; i++) {
        
        
        if ([[self.users[i]valueForKey:@"username"] isEqualToString:self.defaultsUser]) {
            NSString* first = [self.users[i]valueForKey:@"firstname"];
            NSString* last = [self.users[i]valueForKey:@"lastname"];
            
            self.firstLast.text = [NSString stringWithFormat:@"Здравейте, %@ %@", first, last];
            self.emailLabel.text = [self.users[i]valueForKey:@"email"];
            
            _image = [UIImage imageWithData:[self.users[i]valueForKey:@"picture"]];
            
//            _image = [UIImage imageWithData:[userInfo valueForKey:@"picture"]];
            
            [_profileImage setImage:self.image];
            [self.view addSubview:_profileImage];
            
            if (!_image) {
                _image = [UIImage imageNamed: @"user_male_circle_filled1600"];
                [_profileImage setImage:self.image];
                [self.view addSubview:_profileImage];
            }
//            [[_profileImage imageView] setImage:_image];

        }
    }
//
//    
//     for (int i = 0; i < [_userCore count]; i++) {
//    NSManagedObject *usersEmail = [self.users objectAtIndex:indexPath.row];
//    _emailArray = [usersEmail valueForKey:@"email"];
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma Save New Pass
- (IBAction)saveNewPassButton:(id)sender {

    
    for (int i = 0; i < [self.users count]; i++) {
        
    if ([[self.users[i]valueForKey:@"username"] isEqualToString:self.defaultsUser]) {
        // Update existing CoreData
        if (_changePassTextField.text != _verifyNewPassTextField.text) {
            [AlertView showAlertViewWithTitle:@"Грешка" message:@"Моля въведете коректно паролата." controller:self];
            _changePassTextField.text = @"";
            _verifyNewPassTextField.text = @"";
            return;
        }
        else {
           
            [self.users[i]setValue:self.verifyNewPassTextField.text forKey:@"password"];
            
             [AlertView showAlertViewWithTitle:@"Поздравления" message:@"Вие успешно променихте паролата си." controller:self];
            _changePassTextField.text = @"";
            _verifyNewPassTextField.text = @"";
            return;
            }
        }
    }
}
#pragma All Users Button
- (IBAction)allUsersButton:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    allUsersViewController* goToAllUsers = [VC instantiateViewControllerWithIdentifier:@"usersTableVC"];
    [self presentViewController:goToAllUsers animated:true completion:nil];
    
}
#pragma LogOutButton
- (IBAction)logOutButton:(id)sender {
    UIAlertController* logOutAlert = [UIAlertController alertControllerWithTitle:@"Are you sure you want to logout?" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* logOutAgree = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.defaults removeObjectForKey:@"defaultsUser"];
        [self.defaults removeObjectForKey:@"defaultsPass"];
        [self.defaults synchronize];


        UIStoryboard *logOut = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController* goToFirstVC = [logOut instantiateViewControllerWithIdentifier:@"ViewController"];
        [self presentViewController:goToFirstVC animated:true completion:nil];
        
    }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [logOutAlert addAction:logOutAgree];
    [logOutAlert addAction:cancel];
    [self presentViewController:logOutAlert animated:YES completion:nil];
    
}

#pragma BackButton
- (IBAction)backButton:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AllRecipesViewController* goToAllRecipesVC = [VC instantiateViewControllerWithIdentifier:@"recipesTableVC"];
    [self presentViewController:goToAllRecipesVC animated:true completion:nil];

}

#pragma NewImage
//under construction
- (IBAction)newImage:(id)sender {
    UIAlertController* uploadPhotoAlert = [UIAlertController alertControllerWithTitle:@"Нова Профилна снимка" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction* takePhoto = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = _delegate;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self changeProfileImage];
        [self presentViewController:picker animated:YES completion:NULL];

                    return;
            }];
    
    UIAlertAction* choosePhoto = [UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = _delegate;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [uploadPhotoAlert addAction:takePhoto];
    [uploadPhotoAlert addAction:choosePhoto];
    [uploadPhotoAlert addAction:cancel];
    [self presentViewController:uploadPhotoAlert animated:YES completion:nil];
    
}


-(void)loadDataFromCoreData {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    self.users = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.users enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
    }];
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _chosenImage = info[UIImagePickerControllerEditedImage];
    _coreImage = UIImagePNGRepresentation(_chosenImage);
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)checkCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //      [UIAlertView showAlertViewWithTitle:@"Грешка" message:@"Device has no camera" controller:self];
    }
}

-(void)changeProfileImage {
    for (int i = 0; i < [self.users count]; i++) {
        NSLog(@"%@", self.users[i]);
        if ([[self.users[i]valueForKey:@"username"] isEqualToString:self.defaultsUser]) {
            [self.users[i]setValue:self.coreImage forKey:@"picture"];
            [AlertView showAlertViewWithTitle:@"Поздравления" message:@"Вие успешно променихте профилната снимка." controller:self];
        }
    }
}

@end
    
