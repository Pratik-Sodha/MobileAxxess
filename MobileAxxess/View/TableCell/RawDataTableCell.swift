//
//  RawDataTableCell.swift
//  MobileAxxess
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import UIKit
import SnapKit
class RawDataTableCell: UITableViewCell {

    //---------------------------------------------------------
    //MARK:-
    private lazy var containerView : UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var lblID : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()

    private lazy var lblDate : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.italicSystemFont(ofSize: 12.0)
        return label
    }()
    
    private lazy var lblDesription : UILabel = {
        let label = UILabel()
        label.textAlignment = .left

        /**
         To display consistance cell change number of line to 2.
         For now it's displaying all text
         */
        // label.numberOfLines = 2

        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
     required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    
    func commonInit() {
        backgroundColor = .clear
        addSubView()
        makeConstraints()
    }

    var model : RawDataDM! {
        didSet {
            lblID.text = "\(model.id) (\(model.rawType.title))"
            lblDate.text = model.date
            lblDesription.text = model.data
        }
    }
    
}
//---------------------------------------------------------
//MARK:-
extension RawDataTableCell : PSAutolayoutProgrammable {

    func addSubView() {
        containerView.addSubview(lblID)
        containerView.addSubview(lblDate)
        containerView.addSubview(lblDesription)
        contentView.addSubview(containerView)
    }
    
    func makeConstraints() {
        let defaultInset : CGFloat = 5.0
        
        
        var relatedView = lblDate
        lblID.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().inset(UIEdgeInsets(top: defaultInset, left: 20, bottom: 0, right: defaultInset))
            make.trailing.equalTo(relatedView.snp.leading)
        }


        relatedView = lblID
        lblDate.snp.makeConstraints { (make) in
            make.top.equalTo(relatedView)
            make.trailing.equalToSuperview().inset(defaultInset)

        }
        lblDate.snp.contentCompressionResistanceHorizontalPriority = 751

        
        relatedView = lblID
        lblDesription.snp.makeConstraints { (make) in
            make.leading.equalTo(relatedView)
            make.top.equalTo(relatedView.snp.bottom).inset(-defaultInset)
            make.bottom.trailing.equalToSuperview().inset(defaultInset)
        }
        

        containerView.snp.makeConstraints{$0.edges.equalToSuperview()}
    }
}
