//
//  NewRecipesViewController.m
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "NewRecipesViewController.h"
#import "allUsersViewController.h"
#import "CountriesViewController.h"
#import "AlertView.h"
#import <CoreData/CoreData.h>

@interface NewRecipesViewController ()

@end

@implementation NewRecipesViewController  {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromCoreData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _recipeID = [defaults stringForKey:@"defaultsUser"];
    
    self.objPickerView.delegate = self;
    self.objPickerView.dataSource = self;
    _objPickerView.showsSelectionIndicator = YES;
    [self.view addSubview:_objPickerView];
   
    
    [self.objPickerView selectRow:1 inComponent:0 animated:NO];
    self.pickerInfo = @"1";
    
    if (_countryText) {
        [self setTitle];
    }

    [self checkCamera];

    


}
-(void)setTitle{
    [_countryName setTitle:_countryText forState:UIControlStateNormal];
    self.recipeNameTextField.text = _recipeName;
    self.cookTimeTextField.text = _recipeTime;
    self.recipeTextView.text = _recipeDescript;
    [self.objPickerView selectRow:[_pickerInfo intValue] inComponent:0 animated:YES];
  //  self.photo = _photo;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return 11;
}



- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    return [NSString stringWithFormat:@"%ld",row];//Or, your suitable title; like Choice-a, etc.
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
            self.pickerInfo = [NSString stringWithFormat:@"%li",(long)row];
                NSLog(@"%@", _pickerInfo);
    
}


- (IBAction)selectCountryButton:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CountriesViewController* goToCountriVC = [VC instantiateViewControllerWithIdentifier:@"countriesVC"];
    goToCountriVC.recipeName = self.recipeNameTextField.text;
    goToCountriVC.recipeTime = self.cookTimeTextField.text;
    goToCountriVC.recipeDescript = self.recipeTextView.text;
    goToCountriVC.pickerInfo = self.pickerInfo;
   // goToCountriVC.photo = _photo;
    
    [self presentViewController:goToCountriVC animated:true completion:nil];

}

- (IBAction)uploadPhotoButoon:(id)sender {
    
    UIAlertController* uploadPhotoAlert = [UIAlertController alertControllerWithTitle:@"Снимка на рецептата" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
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


- (IBAction)saveNewRecipeButton:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newRecipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    
    if ([_recipeNameTextField.text isEqualToString:@""]) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Моля въведете Име на рецепта" controller:self];
        return;
    }
    else {
        [newRecipe setValue:_recipeNameTextField.text forKey:@"name"];
    }
    if ([_cookTimeTextField.text isEqualToString:@""]) {
        [newRecipe setValue:@"-" forKey:@"time"];
    }
    else {
        [newRecipe setValue:_cookTimeTextField.text forKey:@"time"];
    }
    if ([_recipeTextView.text isEqualToString:@""]) {
        [newRecipe setValue:@"-" forKey:@"descript"];
    }
    else {
        [newRecipe setValue:_recipeTextView.text forKey:@"descript"];
    }
    if ([_pickerInfo intValue] == 0) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Моля посочете за колко души е" controller:self];
        return;
    }
    else {
        [newRecipe setValue:_pickerInfo forKey:@"howmanypeople"];
    }
    if ([_countryName.currentTitle isEqualToString:@"държава"]) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Моля изберете държава" controller:self];
        return;
    }
    else {
        [newRecipe setValue:_countryText forKey:@"country"];
    }
    
    [newRecipe setValue:_coreImage forKey:@"picture"];
    [newRecipe setValue:_recipeID forKey:@"id"];
    
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    UIAlertController* newRecipeSavedAlert = [UIAlertController alertControllerWithTitle:@"Успешно създадена рецепта!" message:@"Желаете ли да продължите с създаване на нова ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* New = [UIAlertAction actionWithTitle:@"Нова" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.recipeNameTextField.text = @"";
        self.cookTimeTextField.text = @"";
        self.recipeTextView.text = @"";
        [_pickerInfo intValue];
        [_countryName setTitle:@"Държава" forState:UIControlStateNormal];
    }];
    
    UIAlertAction* goBack = [UIAlertAction actionWithTitle:@"Към Всички" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goBackToAllRecipesVC];
    }];
    
    [newRecipeSavedAlert addAction:goBack];
    [newRecipeSavedAlert addAction:New];
    [self presentViewController:newRecipeSavedAlert animated:YES completion:nil];
}


- (IBAction)backButton:(id)sender {
    [self goBackToAllRecipesVC];
}

-(void)loadDataFromCoreData {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Recipe"];
    self.recipes = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)goBackToAllRecipesVC {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AllRecipesViewController* goToAllRecipesVC = [VC instantiateViewControllerWithIdentifier:@"recipesTableVC"];
    [self presentViewController:goToAllRecipesVC animated:true completion:nil];
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
