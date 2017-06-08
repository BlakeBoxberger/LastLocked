static NSDate *lastLocked; // Static variable that holds the NSDate of the last locked time



@interface NZ9TimeFormat : NSObject

+ (NSString *)nz9_lastLockedTimeFormat; // Class method that will be used to format the time string

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

	NSString *formattedString = @"Locked"; // Begin formatting string

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

	return formattedString; // Return the formatted string
}

@end


%hook SBUICallToActionLabel // "Hook" the SBUICallToActionLabel class to change pre-existing methods

- (void)setText:(id)arg1 {
	NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat]; // Get formatted string
  %orig(newString); // Call the original method with the formatted string
}

- (void)setText:(id)arg1 forLanguage:(id)language animated:(BOOL)animated {
	NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat]; // Get formatted string
	%orig(newString, language, animated); // Call the original method with the formatted string
}

%end



%hook SBDashBoardViewController

- (void)loadView {
	%orig; // Call original "loadView" method
	lastLocked = [[NSDate date] retain]; // Set the lastLocked NSDate to the current date
}

%end
