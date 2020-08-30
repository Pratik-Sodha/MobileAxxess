//
//  RawDetailController.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import UIKit

class RawDetailController: BaseController {
    
    //-----------------------------------------------------------------
    //MARK: - Class Variable
    weak var rawData : RawDataDM?
    
    lazy var scrollView : UIScrollView = {
        return UIScrollView()
    }()
    
    lazy var stackView : UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView,lblDetail])
        view.axis = .vertical
        view.distribution = .fillProportionally
        return view
    }()
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var lblDetail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    lazy var rightBarButtonItem : UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarButtonItemClicked(_:)))
    }()
    
    //-----------------------------------------------------------------
    //MARK: - Custom Method
    
    func setUpView() {
        
        view.backgroundColor = .solidBackgroundColor

        navigationItem.rightBarButtonItems = [rightBarButtonItem]
        
        addSubView()
        makeConstraints()
        loadData()
    }
    
    func loadData() {
        
        guard let model = rawData else {
            print("<RawDetailController : RawData fatal error>")
            return
        }
        navigationItem.title = model.id

        switch model.rawType {
        case .image:
            imageView.set(with: model.data ?? "")
        case .text, .other:
            lblDetail.text = model.data
        case .unknown:
            print("<RawDetailController : Require to handle unknown")
        }
    }
    
    //-----------------------------------------------------------------
    //MARK: - Action Method
    
    @objc func rightBarButtonItemClicked(_ sender : UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
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

    static func loadController(with rawData : RawDataDM) -> RawDetailController {
        let controller = RawDetailController()
        controller.rawData = rawData
        return controller
    }
}

//---------------------------------------------------------
//MARK:-
extension RawDetailController : PSAutolayoutProgrammable {

    func addSubView() {
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
    }
    
    func makeConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().priority(250)
        }
        scrollView.snp.makeConstraints{$0.edges.equalToSuperview()}
    }
}
