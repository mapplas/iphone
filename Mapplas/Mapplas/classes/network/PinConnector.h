//
//  PinConnector.h
//  Mapplas
//
//  Created by Belén  on 28/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "ReverseGeocoder.h"
#import "ReverseGeocoderHandler.h"

@interface PinConnector : GenericConnector {
    ReverseGeocoder *geocoder;
}

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses;

- (void)requestWithAppId:(NSString *)app_id userId:(NSNumber *)user_id action:(NSString *)_action reverseGeocodedAddress:(NSString *)address andLocation:(NSString *)currentLocation;

@end
