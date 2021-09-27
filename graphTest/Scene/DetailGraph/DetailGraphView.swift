//
//  DetailGraphView.swift
//  graphTest
//
//  Created by Javier Hernandez on 24/09/21.
//  
//

import Foundation
import UIKit

/*
 View: displays what it is told to by the Presenter and relays user input back to the Presenter, the View is passive. It waits for the Presenter to give it content to display.
 
 Use the data sent by the presenter, and display it. Can also pass touch events, but will simply notify the presenter of this, where the work to process the touch takes place. In practice the view sets up the presenter (owns it), and sends messages to the same.
 */

class DetailGraphView: UIViewController {
    /*
     Replace UIViewController to UITableViewController or UICollectionViewController if needed
     */
        @IBOutlet var tableView: UITableView!
        
        

    // MARK: Properties
    var presenter: DetailGraphViewToPresenterProtocol?
    var source = [QuestionsResponse]()
    var colors = [String]()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.fetchData()
    }
    
    func setup() {
        // Do any aditional setup after loading the view ex: View properties, navigation properties, etc.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension DetailGraphView: DetailGraphPresenterToViewProtocol {
    func showData(_ model: ServiceResponse) {
        source = model.questions
        colors = model.colors
        tableView.reloadData()
    }
}

extension DetailGraphView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 580
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GraphDetailViewCell") as! GraphDetailViewCell
        colors.forEach({ (model) in
            let color = UIColor(hex: model)
            cell.colors.append(color)
        })
        cell.itemDetalle = source[indexPath.row].chartData
        cell.titleLabel .text = source[indexPath.row].text
        cell.dataGrahp()
        return cell
    }
}
