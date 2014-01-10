@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
-(UIBarButtonItem *)editButtonItem;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(BOOL)tableView:(UITableView *)arg1 canEditRowAtIndexPath:(NSIndexPath *)arg2;
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
@end