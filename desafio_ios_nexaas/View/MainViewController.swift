//
//  MainViewController.swift
//  desafio_ios_nexaas
//
//  Created by Denis Janoto on 06/07/20.
//  Copyright © 2020 Denis Janoto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var btnDarkMode: UIBarButtonItem!
    
    var responseTotal:[Item]=[]
    var pageNumber = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table_view.delegate = self
        table_view.dataSource = self
        
        
        callApi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnSwipe = true
        
    }
    
    func callApi(){
        pageNumber+=1
        network.loadData(page: pageNumber) { (response) in
            
            self.responseTotal+=response!.items
            
            DispatchQueue.main.async {
                self.table_view.reloadData()
                
            }
        }
    }
    
    
    //MARK: - DARK MODE BUTTON
    @IBAction func btnDarkMode(_ sender: Any) {
        if btnDarkMode.title == "Dark"{
            btnDarkMode.title = "Light"
            overrideUserInterfaceStyle = .dark
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barTintColor = .black
            navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        }else{
            btnDarkMode.title = "Dark"
            overrideUserInterfaceStyle = .light
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.barTintColor = .white
            navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

            
        }
    }
    
    // MARK: - BUILD TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseTotal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_view.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as! CustomTableViewCell
        cell.prepareCell(information: responseTotal[indexPath.row])
        
        return cell
    }
    
    //infinity scroll
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == responseTotal.count - 20{
            callApi()
        }
        
    }
    
    
    
}




