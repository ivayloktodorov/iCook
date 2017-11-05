//
//  allUsersViewController.m
//  iCook
//
//  Created by Ivaylo Todorov on 7/1/17.
//  Copyright © 2017 Ivaylo Todorov. All rights reserved.
//

#import "allUsersViewController.h"
#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "UserProfileViewController.h"

@interface allUsersViewController ()

@end

@implementation allUsersViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataFromCoreData];
    self.tableViewOutled.delegate = self;
    self.tableViewOutled.dataSource = self;
    searchbar.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [self.tableViewOutled setContentOffset:CGPointMake(0, 44)];
}


#pragma SendEmail
-(void)sendEmail{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        mailVC.mailComposeDelegate = self;
        [mailVC setSubject:@"subject"];
        [mailVC setMessageBody:@"test" isHTML:NO];
        [mailVC setToRecipients:[NSArray arrayWithObjects:_emailArray, nil]];
        [self presentViewController:mailVC animated:YES completion:nil];
    } else {
        NSLog(@"this device cannot send email");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            //Email sent
            break;
        case MFMailComposeResultSaved:
            //Email saved
            break;
        case MFMailComposeResultCancelled:
            //Handle cancelling of the email
            break;
        case MFMailComposeResultFailed:
            //Handle failure to send.
            break;
        default:
            //A failure occurred while completing the email
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma TableView
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSManagedObject *usersEmail = [self.users objectAtIndex:indexPath.row];
    _emailArray = [usersEmail valueForKey:@"email"];
    
    [self sendEmail];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
   
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        [managedObjectContext deleteObject:self.users[indexPath.row]];
    
        NSError * error = nil;
        if (![managedObjectContext save:&error])
        {
            NSLog(@"Error ! %@", error);
        }
        
        [self loadDataFromCoreData];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if (isSearched) {
//        
//        return self.searchedResults.count;
//    
//    }
//    
//    else {
//        
//    }
    
    return self.users.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* indetified = @"cellID";
    
    CustomCell* cell = [self.tableViewOutled dequeueReusableCellWithIdentifier:indetified];
    
    if(!cell) {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetified];
    }
    
    NSManagedObject *user = [self.users objectAtIndex:indexPath.row];
    

    cell.nameLabel.text = [user valueForKey:@"firstname"];
    cell.timeLabel.text = [user valueForKey:@"lastname"];
   _image = [UIImage imageWithData:[user valueForKey:@"picture"]];
    [[cell imageView] setImage:_image];
    
    return cell;
}

#pragma LoadDataFromCoreData
-(void)loadDataFromCoreData {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    self.users = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableViewOutled reloadData];
    
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

#pragma SearchBar
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    isSearched = YES;
//    self.searchedResults = [NSMutableArray new];
//    
//    if ([searchText isEqualToString:@""]) {
//        isSearched = NO;
//    }
//    
//    
//    for (int i = 0; i < self.users.count; i++) {
//        NSString* ime = self.users[i];
//        NSString* firstLetter = [ime substringFromIndex:1];
//        
//        if ([[ime lowercaseString] containsString:[searchText lowercaseString]] && [[searchText lowercaseString] containsString:[firstLetter lowercaseString]]) {
//            [self.searchedResults addObject:ime];
//        }
//    }
//    
//    [self.tableViewOutled reloadData];
//}

#pragma BackButton
- (IBAction)backButton:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserProfileViewController* goToUserProfileVC = [VC instantiateViewControllerWithIdentifier:@"userProfileVC"];
    [self presentViewController:goToUserProfileVC animated:true completion:nil];
    
}


@end
