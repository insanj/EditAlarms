#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CydiaSubstrate.h"

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
}
@end

@interface EditAlarmViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
-(id)initWithAlarm:(id)arg1;    //returns some kind of dict
@end

%hook TableViewController
-(TableViewController *)init{
    TableViewController *original = %orig;
    [original setEditing:YES animated:NO]; 
    return original;
}

-(void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3{
    UITableViewCell *modified = arg2;
    modified.accessoryType = UITableViewCellAccessoryNone;
    modified.editingAccessoryType = UITableViewCellAccessoryNone;
    %orig(arg1, modified, arg3);
}

-(UIBarButtonItem *)editButtonItem{
	//return nil;
    return %orig;
}

-(BOOL)tableView:(UITableView *)arg1 canEditRowAtIndexPath:(NSIndexPath *)arg2{
	return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

%end