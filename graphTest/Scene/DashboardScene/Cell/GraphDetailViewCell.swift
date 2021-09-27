//
//  GraphDetailViewCell.swift
//  graphTest
//
//  Created by Javier Hernandez on 23/09/21.
//

import Foundation
import UIKit
import Charts

class GraphDetailViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    
    var dataSource = [PieChartDataEntry]()
    var itemDetalle = [ChartDataResponse]()
    
    var colors = [UIColor]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pieChart.chartDescription?.text = ""
        pieChart.entryLabelColor = .black
        pieChart.rotationEnabled = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataSource = []
    }
    
    func colorCustom () -> [UIColor] {
        return colors
    }
    
    
    func dataGrahp(){
        itemDetalle.forEach({ (model) in
            let index = PieChartDataEntry(value: Double(model.percetnage), label: model.text)
            dataSource.append(index)
        })
        setup()
    }
    
    func setup() {
        // Do any aditional setup after loading the view ex: View properties, navigation properties, etc.
        let chartDataSet = PieChartDataSet(entries: dataSource, label: "")
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = colorCustom()
        pieChart.data = chartData
    }
}
