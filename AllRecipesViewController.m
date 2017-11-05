//
//  AllRecipesViewController.m
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "AllRecipesViewController.h"
#import "ViewController.h"
#import "CustomCell.h"
#import <CoreData/CoreData.h>
#import "RecipesDetailViewController.h"
#import "NewRecipesViewController.h"
#import "UserProfileViewController.h"
#import "SignUpViewController.h"
#import "AlertView.h"
#import "RecipesObject.h"
#import "RecipesObject.h"

@interface AllRecipesViewController ()

@end

@implementation AllRecipesViewController

@synthesize segmentedControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    _myRecipeNumber = 0;
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.defaultsUser = [self.defaults stringForKey:@"defaultsUser"];
    self.tableViewOutled.delegate = self;
    self.tableViewOutled.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableViewOutled setContentOffset:CGPointMake(0, 44)];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        [managedObjectContext deleteObject:self.allRecipes[indexPath.row]];
        
        NSError * error = nil;
        if (![managedObjectContext save:&error])
        {
            NSLog(@"Error ! %@", error);
        }
        [self loadDataFromCoreData];
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        
        if (self.allRecipes.count == 0) {
            // [AlertView showAlertViewWithTitle:@"Внимание!" message:@"До момента няма създадени рецепти, моля добавете своята." controller:self];
            [self goToNewRecipes];
        }
        else {
            
            return [_allRecipes count];
        }
    }
    if (segmentedControl.selectedSegmentIndex == 1) {
        
        return [_myRecipes count];
    }
    
    
    return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        
        NSManagedObject *recipe = [self.allRecipes objectAtIndex:indexPath.row];
        
        UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RecipesDetailViewController* goToDetailVC = [VC instantiateViewControllerWithIdentifier:@"detailRecipeVC"];
        goToDetailVC.reciName = [recipe valueForKey:@"name"];
        goToDetailVC.userLabel = [recipe valueForKey:@"id"];
        goToDetailVC.timeLab = [recipe valueForKey:@"time"];
        goToDetailVC.descript = [recipe valueForKey:@"descript"];
        goToDetailVC.country = [recipe valueForKey:@"country"];
        goToDetailVC.people = [recipe valueForKey:@"howmanypeople"];
        goToDetailVC.image = [UIImage imageWithData:[recipe valueForKey:@"picture"]];
        [self presentViewController:goToDetailVC animated:true completion:nil];
    }
    
    if (segmentedControl.selectedSegmentIndex == 1) {
        
        NSManagedObject *recipe = [self.myRecipes objectAtIndex:indexPath.row];
        
        UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RecipesDetailViewController* goToDetailVC = [VC instantiateViewControllerWithIdentifier:@"detailRecipeVC"];
        goToDetailVC.reciName = [recipe valueForKey:@"name"];
        goToDetailVC.userLabel = [recipe valueForKey:@"id"];
        goToDetailVC.timeLab = [recipe valueForKey:@"time"];
        goToDetailVC.descript = [recipe valueForKey:@"descript"];
        goToDetailVC.country = [recipe valueForKey:@"country"];
        goToDetailVC.people = [recipe valueForKey:@"howmanypeople"];
        goToDetailVC.image = [UIImage imageWithData:[recipe valueForKey:@"picture"]];
        [self presentViewController:goToDetailVC animated:true completion:nil];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* indetified = @"cellID";
    CustomCell* cell = [self.tableViewOutled dequeueReusableCellWithIdentifier:indetified];
    if(!cell) {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetified];
    }
    
    //    if (tableView == self.searchDisplayController.searchResultsTableView) {
    //        cell.textLabel.text = [searchResult objectAtIndex:indexPath.row];
    //    }
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        
        NSManagedObject *recipe = [self.allRecipes objectAtIndex:indexPath.row];
        
        _image = [UIImage imageWithData:[recipe valueForKey:@"picture"]];
        cell.nameLabel.text = [recipe valueForKey:@"name"];
        cell.timeLabel.text = [recipe valueForKey:@"time"];
        [[cell imageView] setImage:_image];
        
    }
    
    if (segmentedControl.selectedSegmentIndex == 1) {
        
        NSManagedObject *myRecipe = [self.myRecipes objectAtIndex:indexPath.row];
        NSLog(@"%li index", (long)indexPath.row);
        _image = [UIImage imageWithData:[myRecipe valueForKey:@"picture"]];
        cell.nameLabel.text = [myRecipe valueForKey:@"name"];
        cell.timeLabel.text = [myRecipe valueForKey:@"time"];
        [[cell imageView] setImage:_image];
        
    }
    return cell;
}

-(void)loadDataFromCoreData {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Recipe"];
    self.allRecipes = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.allRecipes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self myRecipesFunc];
    }];
    
    [self.tableViewOutled reloadData];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)profileButton:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserProfileViewController* goToUserProfileVC = [VC instantiateViewControllerWithIdentifier:@"userProfileVC"];
    [self presentViewController:goToUserProfileVC animated:true completion:nil];
}

- (IBAction)newRecipeButton:(id)sender {
    [self goToNewRecipes];
}

- (IBAction)segmentedChange:(id)sender {
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        //        self.myRecipes = [[self allRecipes] mutableCopy];
        [self loadDataFromCoreData];
        
    } else if(segmentedControl.selectedSegmentIndex == 1) {
        [self getMyRecipesFunc];
        //[self.tableViewOutled reloadData];
    }
}

-(void)goToNewRecipes{
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewRecipesViewController* goToNewRecipeVC = [VC instantiateViewControllerWithIdentifier:@"newRecipeVC"];
    [self presentViewController:goToNewRecipeVC animated:true completion:nil];
}

-(void)myRecipesFunc{
    self.recipeID = [self.allRecipes valueForKey:@"id"];
    self.recipeName = [self.allRecipes valueForKey:@"name"];
    self.recipeCountry = [self.allRecipes valueForKey:@"country"];
    self.recipeDescript = [self.allRecipes valueForKey:@"descript"];
    self.recipeHowMany = [self.allRecipes valueForKey:@"howmanypeople"];
    self.recipeTime = [self.allRecipes valueForKey:@"time"];
    //   self.image = [UIImage imageWithData:[self.myRecipes valueForKey:@"picture"]];
    
}

-(void)getMyRecipesFunc{
    self.myRecipes = [NSMutableArray new];
    [self.allRecipes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[self.allRecipes[idx]valueForKey:@"id"] isEqualToString:self.defaultsUser]) {
            [self.myRecipes addObject:obj];
        }
        NSLog(@"%lu my", (unsigned long)self.myRecipes.count);
    }];
    [self.tableViewOutled reloadData];
}

@end
