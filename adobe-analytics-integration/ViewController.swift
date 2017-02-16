import UIKit

class ViewController: UITableViewController, GMBLPlaceManagerDelegate {
    
    var placeManager: GMBLPlaceManager!
    var placeEvents : [GMBLVisit] = []
    
    override func viewDidLoad() -> Void {
        placeManager = GMBLPlaceManager()
        self.placeManager.delegate = self
    }
    
    func placeManager(_ manager: GMBLPlaceManager!, didBeginVisit visit: GMBLVisit!) -> Void {
        self.placeEvents.insert(visit, atIndex: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with:UITableViewRowAnimation.automatic)
    }
    
    func placeManager(_ manager: GMBLPlaceManager!, didEndVisit visit: GMBLVisit!) -> Void {
        self.placeEvents.insert(visit, atIndex: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: NSInteger) -> NSInteger {
        return self.placeEvents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        let visit: GMBLVisit = self.placeEvents[indexPath.row]
        
        if (visit.departureDate == nil) {
            cell.textLabel!.text = NSString(format: "Begin: %@", visit.place.name) as String
            cell.detailTextLabel!.text = DateFormatter.localizedStringFromDate(visit.arrivalDate, dateStyle: DateFormatter.Style.ShortStyle, timeStyle: DateFormatter.Style.MediumStyle)
        }
        else {
            cell.textLabel!.text = NSString(format: "End: %@", visit.place.name) as String
            cell.detailTextLabel!.text = DateFormatter.localizedStringFromDate(visit.arrivalDate, dateStyle: DateFormatter.Style.ShortStyle, timeStyle: DateFormatter.Style.MediumStyle)
        }
        
        return cell
    }
}

