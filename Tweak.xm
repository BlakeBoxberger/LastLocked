#import "version.h"

static NSDate *lastLocked; // Static variable that holds the NSDate of the last locked time
static NSTimer *updateEverySecond;
static NSUserDefaults *dontationAlertSettings;
static NSString *language = [[[NSLocale preferredLanguages] objectAtIndex:0] substringToIndex:2];

@interface NZ9TimeFormat : NSObject

+ (NSString *)nz9_lastLockedTimeFormat; // Class method that will be used to format the time string

@end

@interface BSPlatform : NSObject
+ (id)sharedInstance;
- (long long)homeButtonType;
@end

@implementation NZ9TimeFormat : NSObject

+ (NSString *)nz9_lastLockedTimeFormat {
	NSInteger secondCount = 0; // Initialize the secondCount to 0

	if(lastLocked) {
		secondCount = ceil(lastLocked.timeIntervalSinceNow*(-1)); // If the lastLocked date exists, set the secondCount to the total number of seconds passed
	}

	NSInteger minuteCount = floor(secondCount / 60); // Calculate number of minutes
	NSInteger hourCount = floor(minuteCount / 60); // Calculate number of hours
	NSInteger dayCount = floor(hourCount / 24); // Calculate number of days
	NSInteger monthCount = floor(dayCount / 30.42); // Calculate number of months
	NSInteger yearCount = floor(monthCount / 12); // Calculate number of years

	secondCount = secondCount % 60; // Calculate the number of actual seconds (between 0 and 60 seconds)
	minuteCount = minuteCount % 60; // Calculate the number of actual minutes
	hourCount = hourCount % 24; // Calculate the number of actual hours
	dayCount = dayCount % 30; // Calculate the number of actual days
	monthCount = monthCount % 12; // Calculate the number of actual months

  NSString *formattedString = @"LastLocked: Language not supported.";

  if([language isEqualToString: @"nl"]) { // Dutch format
    formattedString = @"Vergrendeld"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld jr", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld jr", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld maand", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mdn", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dg", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dgn", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld uur", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld u", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sec", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sec", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" geleden"]; // Append "ago" to the string
  }
  else if([language isEqualToString: @"he"]) { // Hebrew format
    formattedString = @"ננעל לפני"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
    if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld שנה", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld שנים", (long)yearCount];
  	}
    if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld חודש", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld חודשים", (long)monthCount];
  	}
    if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld יום", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ימים", (long)dayCount];
  	}
    if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld שעה", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld שעות", (long)hourCount];
  	}
    if(minuteCount > 0) {
  		if(minuteCount == 1)
    		formattedString = [formattedString stringByAppendingFormat: @" %ld דקה", (long)minuteCount];
    	else
    		formattedString = [formattedString stringByAppendingFormat: @" %ld דקות", (long)minuteCount];
    }
    if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld שנייה", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld שניות", (long)secondCount];
  }
  else if([language isEqualToString: @"sv"]) { // Swedish format
    formattedString = @"Låst"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld år", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld år", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mån", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld månader", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dag", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dagar", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld tim", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld tim", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  	}
		if(yearCount > 0 || monthCount > 0 || dayCount > 0 || hourCount > 0 || minuteCount > 0) {
			formattedString = [formattedString stringByAppendingFormat: @" och"];
		}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sek", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sek", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" sedan"]; // Append "ago" to the string
  }
  else if([language isEqualToString: @"ja"]) { // Japanese format
    formattedString = @"最後のロック :"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 年", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 年", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ヶ月", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ヶ月", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 日", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 日", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 時間", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 時間", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 分", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 分", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld 秒", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld 秒", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" 前"]; // Append "ago" to the string
  }
  else if([language isEqualToString: @"ar"]) { // Arabic format
    formattedString = @"مغلق منذ"; // Begin formatting string

		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		NSLocale *arLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"ar"] autorelease];
		[formatter setLocale:arLocale];

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %@ سنة", [formatter stringFromNumber:@(yearCount)]];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %@ سنين", [formatter stringFromNumber:@(yearCount)]];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %@ شهر", [formatter stringFromNumber:@(monthCount)]];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %@ شهور", [formatter stringFromNumber:@(monthCount)]];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %@ يوم", [formatter stringFromNumber:@(dayCount)]];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %@ أيام", [formatter stringFromNumber:@(dayCount)]];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %@ ساعة", [formatter stringFromNumber:@(hourCount)]];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %@ ساعات", [formatter stringFromNumber:@(hourCount)]];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %@ دقيقة", [formatter stringFromNumber:@(minuteCount)]];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %@ دقائق", [formatter stringFromNumber:@(minuteCount)]];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %@ ثانية", [formatter stringFromNumber:@(secondCount)]];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %@ ثواني", [formatter stringFromNumber:@(secondCount)]];

  }
  else if([language isEqualToString: @"tr"]) { // Turkish format
    formattedString = @""; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld yıl", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld yıl", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ay", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ay", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld gün", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld gün", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld saat", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld saat", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dakika", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dakika", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld saniye", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld saniye", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" önce kilitlendi"]; // Append "ago" to the string
  }
	else if([language isEqualToString: @"fr"]) { // French format
    formattedString = @"Verrouillé depuis"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld an", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ans", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mois", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mois", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld jour", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld jours", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld heure", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld heures", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld minute", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld minutes", (long)minuteCount];
  	}
		if(yearCount > 0 || monthCount > 0 || dayCount > 0 || hourCount > 0 || minuteCount > 0) {
			formattedString = [formattedString stringByAppendingFormat: @" et"];
		}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld seconde", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld secondes", (long)secondCount];
  }
	else if([language isEqualToString: @"de"]) { // German format
    formattedString = @"Gesperrt vor"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld Jahr", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld Jahren", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld Monat", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld Monaten", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld Tag", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld Tagen", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld Stunde", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld Stunden", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld Minute", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld Minuten", (long)minuteCount];
  	}
		if(yearCount > 0 || monthCount > 0 || dayCount > 0 || hourCount > 0 || minuteCount > 0) {
			formattedString = [formattedString stringByAppendingFormat: @" und"];
		}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld Sekunde", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld Sekunden", (long)secondCount];
  }
	else if([language isEqualToString: @"es"]) { // Spanish format
    formattedString = @"Bloqueado hace"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld año", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld años", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mes", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld meses", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld día", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld días", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld hora", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld horas", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mins", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld seg", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld segs", (long)secondCount];
  }
	else if([language isEqualToString: @"pt"]) { // Portuguese format
    formattedString = @"Bloqueado há"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ano", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld anos", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mês", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld meses", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dia", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dias", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld hora", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld horas", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mins", (long)minuteCount];
  	}
		if(yearCount > 0 || monthCount > 0 || dayCount > 0 || hourCount > 0 || minuteCount > 0) {
			formattedString = [formattedString stringByAppendingFormat: @" e"];
		}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld seg", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld segs", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" atrás"]; // Append "ago" to the string
  }
	else if([language isEqualToString: @"nb"]) { // Norwegian format
    formattedString = @"Låst"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld år", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld år", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mnd", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mnd", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dag", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dager", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld time", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld timer", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sek", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sek", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" siden"]; // Append "ago" to the string
  }
	else if([language isEqualToString: @"zh"]) { // Traditional Chinese format
    formattedString = @"已鎖了"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld年", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld年份", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld月", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld個月", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld天", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld天", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld小時", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld小時", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld分鐘", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld分鐘", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld秒", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld秒", (long)secondCount];
  }
	else if([language isEqualToString: @"cn"]) { // Simplified Chinese format
		formattedString = @"已锁了"; // Begin formatting string

		// Do all of the formatting stuff by appending the string
		if(yearCount > 0) {
			if(yearCount == 1)
				formattedString = [formattedString stringByAppendingFormat: @" %ld年", (long)yearCount];
			else
				formattedString = [formattedString stringByAppendingFormat: @" %ld年", (long)yearCount];
		}
		if(monthCount > 0) {
			if(monthCount == 1)
				formattedString = [formattedString stringByAppendingFormat: @" %ld个月", (long)monthCount];
			else
				formattedString = [formattedString stringByAppendingFormat: @" %ld个月", (long)monthCount];
		}
		if(dayCount > 0) {
			if(dayCount == 1)
				formattedString = [formattedString stringByAppendingFormat: @" %ld天", (long)dayCount];
			else
				formattedString = [formattedString stringByAppendingFormat: @" %ld天", (long)dayCount];
		}
		if(hourCount > 0) {
			if(hourCount == 1)
				formattedString = [formattedString stringByAppendingFormat: @" %ld小时", (long)hourCount];
			else
				formattedString = [formattedString stringByAppendingFormat: @" %ld小时", (long)hourCount];
		}
		if(minuteCount > 0) {
			if(minuteCount == 1)
				formattedString = [formattedString stringByAppendingFormat: @" %ld分", (long)minuteCount];
			else
				formattedString = [formattedString stringByAppendingFormat: @" %ld分", (long)minuteCount];
		}
		if(secondCount == 0 || secondCount == 1)
			formattedString = [formattedString stringByAppendingFormat: @" %ld秒", (long)secondCount];
		else
			formattedString = [formattedString stringByAppendingFormat: @" %ld秒", (long)secondCount];
	}
  else { // English format (default)
    formattedString = @"Locked"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld yr", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld yrs", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mon", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mons", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld day", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld days", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld hr", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld hrs", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mins", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sec", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld secs", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" ago"]; // Append "ago" to the string
  }

	return formattedString; // Return the formatted string
}

@end

%group iOS11X

@interface SBUILegibilityLabel : UIView
@property (nonatomic, assign, readwrite) NSString *string;
@end

@interface SBDashBoardTeachableMomentsContainerView
@property (nonatomic, assign, readwrite) SBUILegibilityLabel *callToActionLabel;
@end

%hook SBDashBoardTeachableMomentsContainerView

- (id)init {
  %orig;
  updateEverySecond = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateLastLocked) userInfo:nil repeats:YES];
  return self;
}

%new
- (void)updateLastLocked {
  NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat];
  self.callToActionLabel.string = newString; //Gang
  CGRect frame = self.callToActionLabel.frame;
  self.callToActionLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, [UIScreen mainScreen].bounds.size.width, frame.size.height); //Set frame so you can actually see stuff
  self.callToActionLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.callToActionLabel.center.y); //Center text
}

%end
%end

%group iOS10
%hook SBUICallToActionLabel // "Hook" the SBUICallToActionLabel class to change pre-existing methods

- (id)init {
	%orig;
	updateEverySecond = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setText:) userInfo:nil repeats:YES];
	return self;
}

- (void)setText:(id)arg1 {
	NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat]; // Get formatted string
	%orig(newString); // Call the original method with the formatted string
}

- (void)setText:(id)arg1 forLanguage:(id)language animated:(BOOL)animated {
	NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat]; // Get formatted string
	%orig(newString, language, animated); // Call the original method with the formatted string
}

%end


@interface SBDashBoardViewController : UIViewController <UIAlertViewDelegate>
@end

%hook SBDashBoardViewController

- (void)viewDidAppear:(BOOL)animated {
	%orig(); // Call original "viewDidAppear:" method
  lastLocked = [[NSDate date] retain]; // Set the lastLocked NSDate to the current date
  if([dontationAlertSettings integerForKey: @"unlockCount"] == 15) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enjoying my tweak, LastLocked?" message:@"Please consider donating so I can continue to develop tweaks like this! -NeinZedd9 <3" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Donate", nil];
    [alert show];
    [alert release];
  }
  [dontationAlertSettings setInteger: ([dontationAlertSettings integerForKey: @"unlockCount"] + 1) forKey: @"unlockCount"];
}

%new - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex != [alertView cancelButtonIndex]) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/neinzedd"]];
    }
}

%end
%end

%group iOS9

@interface SBLockScreenView : UIView <UIAlertViewDelegate>
@end

%hook SBLockScreenView

- (void)didMoveToWindow {
	%orig;
	lastLocked = [[NSDate date] retain]; // Set the lastLocked NSDate to the current date
	updateEverySecond = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setCustomSlideToUnlockText:) userInfo:nil repeats:YES];
  if([dontationAlertSettings integerForKey: @"unlockCount"] == 15) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enjoying my tweak, LastLocked?" message:@"Please consider donating so I can continue to develop tweaks like this! -NeinZedd9 <3" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Donate", nil];
    [alert show];
    [alert release];
  }
  [dontationAlertSettings setInteger: ([dontationAlertSettings integerForKey: @"unlockCount"] + 1) forKey: @"unlockCount"];

}


- (void)setCustomSlideToUnlockText:(NSString *)text {
	NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat]; // Get formatted string
	%orig(newString); // Call the original method with the formatted string
}

- (void)setCustomSlideToUnlockText:(NSString *)text animated:(BOOL)arg2 {
	NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat]; // Get formatted string
  %orig(newString, arg2); // Call the original method with the formatted string
}

%new - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex != [alertView cancelButtonIndex]) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/neinzedd"]];
    }
}


%end
%end



%ctor {
  dontationAlertSettings = [[NSUserDefaults alloc] initWithSuiteName: @"com.neinzedd9.LastLocked"];
  [dontationAlertSettings registerDefaults:@{
    @"unlockCount": @0
  }];
  BSPlatform *platform = [NSClassFromString(@"BSPlatform") sharedInstance];
  if (platform.homeButtonType == 2) {
    %init(iOS11X);
  }
	if(IS_IOS_OR_NEWER(iOS_10_0)) {
		%init(iOS10);
	}
	else {
		%init(iOS9);
	}
}
