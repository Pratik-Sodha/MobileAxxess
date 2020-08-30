//
//  RawDataListController.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import UIKit
import Alamofire

class RawDataListController: BaseController {
   
    
    //-----------------------------------------------------------------
    //MARK: - Class Variable
    private lazy var tableView : UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(RawDataTableCell.self, forCellReuseIdentifier: RawDataTableCell.reuseIdentifier)
        table.tableFooterView = UIView(frame: .zero)
        table.backgroundColor = .clear
        return table
    }()
    
    private var dataSource : [RawDataDM]! = []  {
        didSet {
            operationalDataSource = dataSource
        }
    }
    
    private var operationalDataSource : [RawDataDM]! = []  {
        didSet {
            self.tableView.backgroundView = emptyBackgroundView
            tableView.reloadData()
        }
    }
    
    private var sortedDataSource : [RawDataDM] {

        return operationalDataSource.sorted { (lhs, rhs) -> Bool in
            return lhs.type.caseInsensitiveCompare(rhs.type) == ComparisonResult.orderedAscending
            
        }
    }
    
    private var emptyBackgroundView : EmptyBackGroundView? {

        if dataSource.count == 0 {
            let viewEmptyBackGround = EmptyBackGroundView(message: "No Data Found.\nTap here to retry.")


            viewEmptyBackGround.buttonClickedBlock = { button in
                self.loadRawDataAPI()
            }

            tableView.isScrollEnabled = false
            return viewEmptyBackGround
            
        } else {
            tableView.isScrollEnabled = true
            return nil
        }
    }
    
    //-----------------------------------------------------------------
    //MARK: - Custom Method
    
    func setUpView() {
        
        navigationItem.title = "Raw Data"
        view.backgroundColor = .solidBackgroundColor
        
        //Setup view layout with programtaically constraints
        addSubView()
        makeConstraints()
        
        //api call and store into local storage
        loadRawDataAPI()
        
        //load data from local storage
        loadData()
    }
    
    
    func loadRawDataAPI() {

        APIManager.manager.getAPI(method: "master/challenge.json",
                                  successCompletion: { (data) in
                                        self.dataSource = []
                                    do {

                                        let dataSource = try JSONDecoder().decode([RawDataDM].self, from: data)
                                        RawDataCDM.importMasterData(records: dataSource) { (success, error) in
                                            self.reloadData()
                                        }


                                    } catch {
                                        print("<\(self) : \(error)>")
                                    }
                                    
                                    
        }) { (error) in
            print("<\(self) : \(error)>")
        }
        
        
    }

    func loadData() {

        DispatchQueue.main.async {
            self.dataSource = RawDataCDM.allRecords.rawDataArrayValue
            self.sortDataInvalidate()
        }
    }
    
    func reloadData() {
        loadData()
    }
    
    
    private func sortDataInvalidate() {
        operationalDataSource = self.sortedDataSource
    }
    //-----------------------------------------------------------------
    //MARK: - Action Method
    
    
    //-----------------------------------------------------------------
    //MARK: - Delegate Method
    
    
    //-----------------------------------------------------------------
    //MARK: - Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("DidReceiveMemoryWarning....")
    }
    
    deinit {
        
    }
    
    //-----------------------------------------------------------------
    //MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
        
    }

    //---------------------------------------------------------
    //MARK:- Initializer
    static func loadController() -> RawDataListController { RawDataListController() }
    
}

//---------------------------------------------------------
//MARK:-
extension RawDataListController : PSAutolayoutProgrammable {
    
    func addSubView() {
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview()}
    }
}

//---------------------------------------------------------
//MARK:- UITableView Delegate DataSource

extension RawDataListController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { operationalDataSource.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RawDataTableCell.reuseIdentifier) as! RawDataTableCell
        cell.model = operationalDataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = RawDetailController.loadController(with: operationalDataSource[indexPath.row])
        mobileAxxessPresent(controller: UINavigationController(mobileAxxessNavigationBarController: controller))
    }
}

//---------------------------------------------------------
//MARK:-
extension RawDataListController {
    override var debugDescription: String {
        return "RawDataListController"
    }
}
