/*
bdays 1.0
by Paul Schreiber
misc at paulschreiber.com
http://paulschreiber.com/

2006-03-12 initial public release

To compile:
gcc -framework Foundation -framework AddressBook bdays.m -o bdays

Licensed under a CreativeCommons-Attribution License:
http://creativecommons.org/licenses/by/2.5/
*/

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

int personSortByBirthday(id person1, id person2, void *context) {
    NSCalendarDate *d1 = [person1 valueForProperty:kABBirthdayProperty];
    NSCalendarDate *d2 = [person2 valueForProperty:kABBirthdayProperty];
	int day1 = [d1 dayOfMonth];
	int day2 = [d2 dayOfMonth];
	int month1 = [d1 monthOfYear];
	int month2 = [d2 monthOfYear];

	if (month1 < month2) {
		return NSOrderedAscending;
	} else if (month1 > month2) {
		return NSOrderedDescending;
	} else {
		if (day1 < day2) {
			return NSOrderedAscending;
		} else if (day1 > day2) {
			return NSOrderedDescending;
		} else {
			return NSOrderedSame;
		}
	}
}

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	int dayIntervalLength = 2;
	int tmpDayIntervalLength;
	ABAddressBook *AB;
	ABPerson *person;
	NSArray *peopleFound;
	NSArray *sortedPeopleFound;
	NSEnumerator *peopleEnumerator;
	ABSearchElement *peopleWithBirthdays;
		
	if (argc > 1) {
		tmpDayIntervalLength = (int)strtol(argv[1], NULL, 10);
		if ((tmpDayIntervalLength > 0) && (tmpDayIntervalLength < 32)) {
			dayIntervalLength = tmpDayIntervalLength;
		}
	}
	
    AB = [ABAddressBook sharedAddressBook];
	
	peopleWithBirthdays = [ABPerson searchElementForProperty:kABBirthdayProperty
														   label:nil
															 key:nil
														   value:[NSNumber numberWithInt:60*60*24*dayIntervalLength]
													  comparison:kABWithinIntervalAroundTodayYearless];
	
    peopleFound = [AB recordsMatchingSearchElement:peopleWithBirthdays];
	sortedPeopleFound = [peopleFound sortedArrayUsingFunction:personSortByBirthday context:NULL];
	peopleEnumerator = [sortedPeopleFound objectEnumerator];

	while (person = [peopleEnumerator nextObject]) {
		printf("%s: %s %s\n",
			   [[[person valueForProperty:kABBirthdayProperty] descriptionWithCalendarFormat:@"%B %d"] UTF8String],
			   [[person valueForProperty:kABFirstNameProperty] UTF8String],
			   [[person valueForProperty:kABLastNameProperty] UTF8String]);
	}
	
	
	[pool release];
    return 0;
}
