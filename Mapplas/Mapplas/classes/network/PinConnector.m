//
//  PinConnector.m
//  Mapplas
//
//  Created by Belén  on 28/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "PinConnector.h"
#import "Constants.h"

@implementation PinConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses {
    geocoder = [[ReverseGeocoder alloc] init];
    return [super initWithAddresses:_addresses responseHandler:nil];
}

- (void)requestWithAppId:(NSString *)app_id userId:(NSNumber *)user_id action:(NSString *)_action andLocation:(NSString *)currentLocation {
    NSArray *splitedLocation = [currentLocation componentsSeparatedByString:@","];
    
    [parameters setValue:app_id forKey:@"app"];
    [parameters setValue:user_id forKey:@"uid"];
    [parameters setValue:_action forKey:@"s"];
    
    if ([_action isEqualToString:ACTION_PIN_REQUEST_PIN]) {
        
        [geocoder doReverseGeocodingFromLat:[splitedLocation objectAtIndex:0] andLong:[splitedLocation objectAtIndex:1] handler:self];
        
        [parameters setValue:[splitedLocation objectAtIndex:0] forKey:@"lat"];
        [parameters setValue:[splitedLocation objectAtIndex:1] forKey:@"lon"];
    }
}

- (NSString *)getUrl {
    return [adresses pinApp];
}

# pragma mark - Reverse geooder handler
- (void)geocodedOK:(NSString *)address {
    NSData *newdata = [address dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *mystring = [[NSString alloc] initWithData:newdata encoding:NSNonLossyASCIIStringEncoding];
    
    
    NSLog(@"%@", address);
    NSLog(@"%@", mystring);
    [parameters setValue:mystring forKey:@"a"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (void)geocodedNOK {
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

@end
