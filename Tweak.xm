#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MSCMoreOptionTableViewCell/MSCMoreOptionTableViewCell.h"
#import "MSCMoreOptionTableViewCell/MSCMoreOptionTableViewCellDelegate.h"

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
-(UIBarButtonItem *)editButtonItem;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(BOOL)tableView:(UITableView *)arg1 canEditRowAtIndexPath:(NSIndexPath *)arg2;
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface TableViewController (EditAlarms) <MSCMoreOptionTableViewCellDelegate>
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView moreOptionButtonPressedInRowAtIndexPath:(NSIndexPath *)indexPath;
-(NSString *)tableView:(UITableView *)tableView titleForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation TableViewController (EditAlarms)
/*-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Called when "DELETE" button is pushed.
    NSLog(@"DELETE button pushed in row at: %@", indexPath.description);
}*/

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete";
}

-(void)tableView:(UITableView *)tableView moreOptionButtonPressedInRowAtIndexPath:(NSIndexPath *)indexPath {
    // Called when "MORE" button is pushed.
    /*[self tableView:tableView didSelectRowAtIndexPath:indexPath];
	//	[self performSelector:(SEL)originalEdit.action];
	*/
    NSLog(@"MORE button pushed in row at: %@", indexPath.description);
}

-(NSString *)tableView:(UITableView *)tableView titleForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Edit";
}
@end

%hook TableViewController
-(UIBarButtonItem *)editButtonItem{
	return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MSCMoreOptionTableViewCell *cell = (MSCMoreOptionTableViewCell *) %orig;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
	return cell;
}

-(BOOL)tableView:(UITableView *)arg1 canEditRowAtIndexPath:(NSIndexPath *)arg2{
	return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
%end