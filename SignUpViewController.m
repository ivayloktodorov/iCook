//
//  SignUpViewController.m
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "SignUpViewController.h"
#import <CoreData/CoreData.h>
#import "AlertView.h"
#import "changeVC.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromCoreData];
   
    //loadDataFromCoreData
    self.userCore = [self.users valueForKey:@"username"];
    self.passCore = [self.users valueForKey:@"password"];
    
    [self checkCamera];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)signUpNewUserButton:(id)sender {
    
    if (self.userCore.count != 0) {
        
        for (int i = 0; i < self.userCore.count; i++) {
            NSString* checkUser = self.userCore[i];
            
            if ([_usernameTextField.text isEqualToString:checkUser]) {
                [AlertView showAlertViewWithTitle:@"Грешка" message:@"Този username е зает." controller:self];
                _usernameTextField.text = @"";
                return;
            }
        }
    }
    
    
    if ([_firstNameTextField.text isEqualToString:@""]) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Моля въведете Име." controller:self];
        return;
    }
    if ([_lastNameTextField.text isEqualToString:@""]) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Моля въведете Фамилия." controller:self];
        return;
    }
    if ([_usernameTextField.text isEqualToString:@""]) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Моля въведете username." controller:self];
        return;
    }
    if (![self isValidEmail:_emailTextField.text]) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Моля въведете валиден email." controller:self];
        return;
    }
    if ([_passwordTextField.text isEqualToString:@""]) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Моля въведете парола." controller:self];
        return;
    }
    if (_passwordTextField.text != _verifyPasswordTextField.text) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Моля въведете коректно паролата." controller:self];
        _passwordTextField.text = @"";
        _verifyPasswordTextField.text = @"";
        return;
    }
    
    else {
      
        NSManagedObjectContext *context = [self managedObjectContext];
        
        // Create a new managed object
        NSManagedObject *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        [newUser setValue:_firstNameTextField.text forKey:@"firstname"];
        [newUser setValue:_lastNameTextField.text forKey:@"lastname"];
        [newUser setValue:_usernameTextField.text forKey:@"username"];
        [newUser setValue:_passwordTextField.text forKey:@"password"];
        [newUser setValue:_emailTextField.text forKey:@"email"];
        [newUser setValue:_coreImage forKey:@"picture"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
     
    }
        

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Успешна регистрация" message:@"Вашият профил е създаден успешно. Моля Log In." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goBackToMain];
    }];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];

        
    }
    

    


- (IBAction)backButton:(id)sender {
    [self goBackToMain];
    }

- (IBAction)profileImage:(id)sender {
    
    UIAlertController* uploadPhotoAlert = [UIAlertController alertControllerWithTitle:@"Профилна Снимка" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction* takePhoto = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
    UIAlertAction* choosePhoto = [UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [uploadPhotoAlert addAction:takePhoto];
    [uploadPhotoAlert addAction:choosePhoto];
    [uploadPhotoAlert addAction:cancel];
    [self presentViewController:uploadPhotoAlert animated:YES completion:nil];
    
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)goBackToMain{
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController* goToMainVC = [VC instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:goToMainVC animated:true completion:nil];

}

-(void)loadDataFromCoreData {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    self.users = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
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
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Device has no camera" controller:self];
    }
}

@end
