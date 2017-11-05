//
//  CountriesViewController.m
//  iCook
//
//  Created by Ivaylo Todorov on 7/2/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "CountriesViewController.h"
#import "AllRecipesViewController.h"
#import "ViewController.h"
#import "CustomCell.h"
#import <CoreData/CoreData.h>
#import "RecipesDetailViewController.h"
#import "NewRecipesViewController.h"
#import "UserProfileViewController.h"
#import "SignUpViewController.h"
#import "AlertView.h"

@interface CountriesViewController ()

@end

@implementation CountriesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAllCountries];
    self.tableViewOutled.delegate = self;
    self.tableViewOutled.dataSource = self;
    countries = [[self getAllCountries] mutableCopy];
    self.countryText = [NSString new];
    searchResult = [[NSMutableArray alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    
    
    
    // searchDisplayController
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResult count];
        
    } else {
        return [countries count];
    }
    //searchDisplayController
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* indetified = @"cell";
    UITableViewCell* cell = [self.tableViewOutled dequeueReusableCellWithIdentifier:indetified];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetified];
    }
    

    
    
    //searchDisplayController
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [searchResult objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [countries objectAtIndex:indexPath.row];
    }
    //searchDisplayController
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _countryText = cell.textLabel.text;
    NSLog(@"%@", [[[tableView cellForRowAtIndexPath:indexPath]textLabel]text]);
    UIStoryboard *newRecipePage = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewRecipesViewController* goToNewRecipeVC = [newRecipePage instantiateViewControllerWithIdentifier:@"newRecipeVC"];
    goToNewRecipeVC.countryText = _countryText;
    goToNewRecipeVC.recipeName = _recipeName;
    goToNewRecipeVC.recipeTime = _recipeTime;
    goToNewRecipeVC.recipeDescript = _recipeDescript;
    goToNewRecipeVC.pickerInfo = _pickerInfo;

    [self presentViewController:goToNewRecipeVC animated:true completion:nil];
    
}

# pragma UISearchBar (searchDisplayController)

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    
    
    searchResult = [countries filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];

    return YES;
}




# pragma Get All Countries
-(NSArray*)getAllCountries {
        NSLocale *locale = [NSLocale currentLocale];
        NSArray *countryArray = [NSLocale ISOCountryCodes];
        NSMutableArray *sortedCountryArray = [[NSMutableArray alloc] init];
        for (NSString *countryCode in countryArray) {
            NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
            [sortedCountryArray addObject:displayNameString];
        }
        [sortedCountryArray sortUsingSelector:@selector(localizedCompare:)];
        return sortedCountryArray;
    }



# pragma Back Button
- (IBAction)backButton:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewRecipesViewController* goToNewRecipeVC = [VC instantiateViewControllerWithIdentifier:@"newRecipeVC"];
    [self presentViewController:goToNewRecipeVC animated:true completion:nil];
    
}

@end
