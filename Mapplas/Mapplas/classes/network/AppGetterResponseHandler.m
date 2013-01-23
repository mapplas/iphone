//
//  AppGetterResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppGetterResponseHandler.h"
#import "AppsViewController.h"

@implementation AppGetterResponseHandler

- (id)initWithModel:(SuperModel *)_model mainController:(AppsViewController *)main_controller {
    self = [super init];
    if (self) {
        model = _model;
        mainController = main_controller;
    }
    return self;
}
- (void)requestFinished:(id)JSON {
    // Parse apps
    NSArray *jsonObjects = JSON;
    JSONToAppMapper *appMapper = [[JSONToAppMapper alloc] init];
    
    App *app = nil;
    AppOrderedList *list = [[AppOrderedList alloc] init];
    for (int i=0; i < jsonObjects.count; i++) {
        app = [appMapper map:[jsonObjects objectAtIndex:i]];
        [list addObject:app];
    }
    
    [model setAppList:list];
    
    // Set adapter to tableView
    [mainController appsDataParsedFromServer];
    
//    // Get first X applications
//    ArrayList<App> appList = new ArrayList<App>();
//    int maxIndex = InfiniteScrollManager.NUMBER_OF_APPS;
//    
//    if(this.model.appList().size() < InfiniteScrollManager.NUMBER_OF_APPS) {
//        maxIndex = this.model.appList().size();
//    }
//    for(int i = 0; i < maxIndex; i++) {
//        appList.add(this.model.appList().get(i));
//    }
//    
//    this.listViewAdapter = new AppAdapter(this.context, this.listView, this.model, appList);
//    this.listView.setAdapter(this.listViewAdapter);
//    AppAdapterSingleton.appAdapter = this.listViewAdapter;
//    this.listView.setVisibility(View.VISIBLE);
//    
//    RelativeLayout radarLayout = (RelativeLayout)((MapplasActivity)this.context).findViewById(R.id.radar_layout);
//    radarLayout.setVisibility(View.GONE);
//    
//    
//    if(this.listViewAdapter != null) {
//        
//        // Get app list from telf.
//        final PackageManager pm = this.context.getPackageManager();
//        this.applicationList = pm.getInstalledApplications(PackageManager.GET_ACTIVITIES);
//        
//        for(int i = 0; i < maxIndex; i++) {
//            ApplicationInfo ai = findApplicationInfo(this.model.appList().get(i).getAppName());
//            if(ai != null) {
//                this.model.appList().get(i).setInternalApplicationInfo(ai);
//            }
//        }
//        
//        this.listViewAdapter.notifyDataSetChanged();
//        
//        this.listView.finishRefresing();
//    }
//    
//    // Insert notifications into database
//    new NotificationDatabaseInserterTask(this.model, this.context, this.notificationsButton).execute();
//    
//    // Send app info to server
//    new AppInfoSenderTask(this.applicationList, location, this.activityManager, this.model.currentUser()).execute();
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    NSLog(@"Response delegate error, %@, %@", [error description], JSON);
}

@end
