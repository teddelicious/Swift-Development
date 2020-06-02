

import UIKit;

class EmployeeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var employees : [Employee] = [Employee]();
    
    
    //returns the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.employees.count;
    }
    
    
    //this returns the cell to put on the tablew view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeDataCell");
        
        cell?.textLabel?.text = "\(self.employees[indexPath.row].firstName) \(self.employees[indexPath.row].lastName)";
        
        return cell!;
        
    }
    
    
    var db = DAO();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        employees = db.getAllEmployees();
        
        

        // Do any additional setup after loading the view.
    }
    



}
