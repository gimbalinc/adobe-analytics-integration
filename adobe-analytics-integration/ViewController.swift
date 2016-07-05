import UIKit

class ViewController: UITableViewController, GMBLPlaceManagerDelegate {
    
    var placeManager: GMBLPlaceManager!
    var placeEvents : [GMBLVisit] = []
    
    override func viewDidLoad() -> Void {
        placeManager = GMBLPlaceManager()
        self.placeManager.delegate = self
    }
    
    func placeManager(manager: GMBLPlaceManager!, didBeginVisit visit: GMBLVisit!) -> Void {
        self.placeEvents.insert(visit, atIndex: 0)
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation:UITableViewRowAnimation.Automatic)
    }
    
    func placeManager(manager: GMBLPlaceManager!, didEndVisit visit: GMBLVisit!) -> Void {
        self.placeEvents.insert(visit, atIndex: 0)
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: NSInteger) -> NSInteger {
        return self.placeEvents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        let visit: GMBLVisit = self.placeEvents[indexPath.row]
        
        if (visit.departureDate == nil) {
            cell.textLabel!.text = NSString(format: "Begin: %@", visit.place.name) as String
            cell.detailTextLabel!.text = NSDateFormatter.localizedStringFromDate(visit.arrivalDate, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
        }
        else {
            cell.textLabel!.text = NSString(format: "End: %@", visit.place.name) as String
            cell.detailTextLabel!.text = NSDateFormatter.localizedStringFromDate(visit.arrivalDate, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
        }
        
        return cell
    }
}

