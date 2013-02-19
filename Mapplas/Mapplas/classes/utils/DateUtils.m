//
//  DateUtils.m
//  Mapplas
//
//  Created by Belén  on 19/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

- (NSUInteger)hours:(NSString *)hour {
    int ret = 0;
    NSRange end = [hour rangeOfString:@":"];
    ret = [[hour substringWithRange:NSMakeRange(0, end.location)] intValue];
    return ret;
}

- (NSUInteger)minutes:(NSString *)minutes {
    int ret = 0;
    NSRange end = [minutes rangeOfString:@":"];
    ret = [[minutes substringWithRange:NSMakeRange(end.location + 1, minutes.length)] intValue];
    return ret;
}

- (NSString *)formatSinceDate:(NSString *)date hour:(NSString *)hour {
    NSString *ret = [NSString stringWithFormat:@"%@ %@", date, hour];
    int aux = 0;
    
    NSDate *now = [NSDate date];

    NSDateComponents *componentsNow = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:now];
    NSInteger dayNow = [componentsNow day];
    NSInteger monthNow = [componentsNow month];
    NSInteger yearNow = [componentsNow year];
    NSInteger hourNow = [componentsNow hour];
    NSInteger minuteNow = [componentsNow minute];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *past = [[NSDate alloc] init];
    past = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", date, hour]];
    
    NSDateComponents *componentsPast = [[NSCalendar currentCalendar] components: NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:past];
    NSInteger dayPast = [componentsPast day];
    NSInteger monthPast = [componentsPast month];
    NSInteger yearPast = [componentsPast year];
    NSInteger hourPast = [componentsPast hour];
    NSInteger minutePast = [componentsPast minute];
    
    if (yearNow > yearPast) {
        // Hace x años
        aux = yearNow - yearPast;
        if (aux == 1) {
            ret = [NSString stringWithFormat:@"%d %@", aux, NSLocalizedString(@"notif_screen_year_text", @"Notification cell year text")];
        }
        else {
            ret = [NSString stringWithFormat:@"%d %@", aux, NSLocalizedString(@"notif_screen_years_text", @"Notification cell years text")];
        }
    }
    else if(monthNow > monthPast) {
        // Hace x meses
        aux = monthNow - monthPast;
        if (aux == 1) {
            ret = [NSString stringWithFormat:@"%d %@", aux, NSLocalizedString(@"notif_screen_month_text", @"Notification cell month text")];
        }
        else {
            ret = [NSString stringWithFormat:@"%d %@", aux, NSLocalizedString(@"notif_screen_months_text", @"Notification cell months text")];
        }
    }
    else if(dayNow > dayPast) {
        // Hace x días
        aux = dayNow - dayPast;
        if (aux == 1) {
            ret = [NSString stringWithFormat:@"%d %@", aux, NSLocalizedString(@"notif_screen_day_text", @"Notification cell day text")];
        }
        else {
            ret = [NSString stringWithFormat:@"%d %@", aux, NSLocalizedString(@"notif_screen_days_text", @"Notification cell days text")];
        }
    }
    else if(hourNow > hourPast) {
        // Hace x horas
        aux = hourNow - hourPast;
        if (aux == 1) {
            ret = [NSString stringWithFormat:@"%d %@", aux, NSLocalizedString(@"notif_screen_hour_text", @"Notification cell hour text")];
        }
        else {
            ret = [NSString stringWithFormat:@"%d %@", aux, NSLocalizedString(@"notif_screen_hours_text", @"Notification cell hours text")];
        }
    }
    else {
        // Hace x minutos
        aux = minuteNow - minutePast;
        if (aux == 1) {
            ret = [NSString stringWithFormat:@"%d %@", aux, NSLocalizedString(@"notif_screen_minute_text", @"Notification cell minute text")];
        }
        else {
            ret = [NSString stringWithFormat:@"%d %@", aux, NSLocalizedString(@"notif_screen_minutes_text", @"Notification cell minutes text")];
        }
    }
    
    return ret;
}

@end
