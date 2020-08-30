//
//  EmptyBackGroundView.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import UIKit

class EmptyBackGroundView: UIView {

    //---------------------------------------------------------
    //MARK:-
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var btnAction : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(btnActionClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var lblInfo : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        label.isUserInteractionEnabled = false
        return label
    }()

    typealias ActionButtonClickedBlock = (_ button: UIButton)->()
    var buttonClickedBlock: ActionButtonClickedBlock?
    
    //---------------------------------------------------------
    //MARK:- Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commoInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoInit()
    }
    
    convenience init(message : String) {
        self.init(frame : .zero)
        lblInfo.text = message
    }
    
    private func commoInit() {
        addSubView()
        makeConstraints()
    }

    func update(message : String) {
        lblInfo.text = message
    }
    
    
    //---------------------------------------------------------
    //MARK:-
    @objc  func btnActionClicked(_ sender: UIButton) {
        self.buttonClickedBlock?(sender)
    }

}

//---------------------------------------------------------
//MARK:-
extension EmptyBackGroundView : PSAutolayoutProgrammable {
    
    func addSubView() {
        contentView.addSubview(btnAction)
        contentView.addSubview(lblInfo)
        addSubview(contentView)

    }

    func makeConstraints() {
        lblInfo.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.edges.greaterThanOrEqualToSuperview().inset(10)
        }
        
        btnAction.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(80)
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(10)
        }
        contentView.snp.makeConstraints{$0.edges.equalToSuperview()}
    }
}
