//
//  ReverseGeocoderHandler.h
//  Mapplas
//
//  Created by Belén  on 26/06/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@protocol ReverseGeocoderHandler <NSObject>

- (void)geocodedOK:(NSString *)address;
- (void)geocodedNOK;

@end
