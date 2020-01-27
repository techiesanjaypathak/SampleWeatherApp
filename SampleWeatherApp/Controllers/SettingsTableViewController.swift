//
//  SettingsTableViewController.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 26/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import UIKit

protocol SettingsDelegate : class {
    func settingsDone(vm:SettingsViewModel)
}

class SettingsTableViewController: UITableViewController {
    
    private var settingsViewModel = SettingsViewModel()
    weak var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return settingsViewModel.units.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)

        // Configure the cell...
        
        let settingsItem = self.settingsViewModel.units[indexPath.row]
        cell.textLabel?.text = settingsItem.displayName
        if settingsItem == self.settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.visibleCells.forEach { (cell) in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            self.settingsViewModel.selectedUnit = Unit.allCases[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneAction(_ sender: Any) {
        self.delegate?.settingsDone(vm: self.settingsViewModel)
        self.dismiss(animated: true, completion: nil)
    }
    
}
