//
//  AppDelegate.h
//  TestApplication
//
//  Created by Ivaylo Todorov on 6/26/17.
//  Copyright © 2017 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AllRecipesViewController.h"
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) NSString* defaultsUser;
@property (nonatomic, strong) NSString* defaultsPass;

@property (nonatomic, strong) NSMutableArray* userCore;
@property (nonatomic, strong) NSMutableArray* passCore;

@property (nonatomic, strong) NSUserDefaults* defaults;
@property (nonatomic, strong) NSMutableArray* users;

- (void)saveContext;


@end

