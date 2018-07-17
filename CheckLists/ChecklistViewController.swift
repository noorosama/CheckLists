//
//  ViewController.swift
//  CheckLists
//
//  Created by Nour Abukhaled on 2/20/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController,AddItemViewControllerDelegate{
    
    var items: [ChecklistItem] = []

    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem) {
        
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    
//        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishEditing item: ChecklistItem) {
        
        if let index = items.index(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
            }
        }
      navigationController?.popViewController(animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
    // NSCoder to save data to disc and read it back again

        items = [ChecklistItem]()

        let row0Item = ChecklistItem() // Create obj to use proprities
        row0Item.text = "Walk the dog"
        row0Item.checked = false
        items.append(row0Item)

        let row1Item = ChecklistItem()
        row1Item.text = "Brush my teeth"
        row1Item.checked = false
        items.append(row1Item)

        let row2Item = ChecklistItem()
        row2Item.text = "Learn ios development"
        row2Item.checked = false
        items.append(row2Item)

        let row3Item = ChecklistItem()
        row3Item.text = "Soccer practice"
        row3Item.checked = false
        items.append(row3Item)

        let row4Item = ChecklistItem()
        row4Item.text = "Eat ice cream"
        row4Item.checked = false
        items.append(row4Item)

        let row5Item = ChecklistItem()
        row5Item.text = "eat burger"
        row5Item.checked = true
        items.append(row5Item)

        let row6Item = ChecklistItem()
        row6Item.text = "swimming"
        row6Item.checked = true
        items.append(row6Item)

        let row7Item = ChecklistItem()
        row7Item.text = "dance salsa"
        row7Item.checked = false
        items.append(row7Item)

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let controller = segue.destination as! AddItemTableViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem"{
            let controller = segue.destination as! AddItemTableViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemToEdit = items[indexPath.row]
            }
           
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
//        // OR
//        tableView.reloadData()
        }
//    @IBAction func addItem(_ sender: Any) {
//
//       let newRowIndex = items.count  // calculate the rows num to add new item at the end of it
//       let item = ChecklistItem() // Create obj to use proprities(text,check,toggleCheck)
//
//        //Generate random text
//        var titles = ["Empty todo item","Generic todo","First todo: fill me out","I need something todo", "Much todo about nothing"]
//        let randomNumber = arc4random_uniform(UInt32(titles.count))
//        let title = titles[Int(randomNumber)]
//       item.text = title
//
//       item.checked = true
//       items.append(item)
//
//       let indexPath = IndexPath(row: newRowIndex, section: 0) // we have one section
//       let indexPaths = [indexPath]
//       tableView.insertRows(at: indexPaths, with: .automatic)
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // num of the cells on table view // num of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Asks the data source for a cell to insert in a particular location of the table view.
        if let cell = tableView.cellForRow(at: indexPath) {

            let item = items[indexPath.row]
            item.toggelChecked()

            configureCheckmark(for: cell, with: item)
           tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    // Adding cell content // cellForRow- cell - label
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //The identifier tells dequeueReusableCell(withIdentifier:for:) which type of cell it should create or reuse.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]

        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    func configureText(for cell:UITableViewCell, with item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel // label tag
         label.text = item.text
    }
    
    func configureCheckmark(for cell:UITableViewCell, with item: ChecklistItem){
      
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        }else{
            label.text = ""
        }
    }
}

