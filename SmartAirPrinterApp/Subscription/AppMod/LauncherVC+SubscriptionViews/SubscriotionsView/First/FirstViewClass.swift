//
//  FirstViewClass.swift
//  ModsApp
//
//  Created by David on 15.04.2023.
//

import UIKit

struct SubscriptionCellModel {
    let imageDeselected: String
    let imageSelected: String
    let title: String
}

class FirstViewClass: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var view: UIView!
    
    private var indexes = [Int]()
    private let viewContent: [SubscriptionCellModel] = [
        SubscriptionCellModel(imageDeselected: "newFeatures", imageSelected: "newFeatures", title: NSLocalizedString("newFeatures", comment: "")),
        SubscriptionCellModel(imageDeselected: "a60", imageSelected: "a60", title: NSLocalizedString("a60", comment: "")),
        SubscriptionCellModel(imageDeselected: "over100", imageSelected: "over100", title: NSLocalizedString("roblox doors", comment: "")),
//        SubscriptionCellModel(imageDeselected: "4_0", imageSelected: "4_1", title: NSLocalizedString("tiger ii", comment: "")),
//        SubscriptionCellModel(imageDeselected: "5_0", imageSelected: "5_1", title: NSLocalizedString("Fnaf 1", comment: "")),
//        SubscriptionCellModel(imageDeselected: "6_0", imageSelected: "6_1", title: NSLocalizedString("hotline miami", comment: "")),
//        SubscriptionCellModel(imageDeselected: "7_0", imageSelected: "7_1", title: NSLocalizedString("venom", comment: "")),
//        SubscriptionCellModel(imageDeselected: "8_0", imageSelected: "8_1", title: NSLocalizedString("blade murasama", comment: "")),
//        SubscriptionCellModel(imageDeselected: "9_0", imageSelected: "9_1", title: NSLocalizedString("simon ghost", comment: "")),
//        SubscriptionCellModel(imageDeselected: "10_0", imageSelected: "10_1", title: NSLocalizedString("pirate ship", comment: ""))
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nib_setupka_()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nib_setupka_()
    }
    
    private func loadViewFromNibulon() -> UIView {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    private func nib_setupka_() {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        view = loadViewFromNibulon()
        view.backgroundColor = .clear
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        _setupka_()
    }
    
    private func _setupka_() {
        label.text = NSLocalizedString("textFirst", comment: "").uppercased()
        //label.font = UIFont(name: "Troika", size: 28)
        label.textColor = .white
        label.addShadowddcdc()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SubscriptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubscriptionCollectionViewCell")
    }
}

extension FirstViewClass: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        return viewContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubscriptionCollectionViewCell", for: indexPath) as! SubscriptionCollectionViewCell
        let content = viewContent[indexPath.row]
        cell.cellImage.image = !indexes.contains(indexPath.row) ? UIImage(named: content.imageDeselected) : UIImage(named: content.imageSelected)
        cell.cellLabel.font = !indexes.contains(indexPath.row) ? UIFont(name: "Troika", size: 12) : UIFont(name: "Troika", size: 14)
        cell.cellLabel.textColor = !indexes.contains(indexPath.row) ? UIColor.white.withAlphaComponent(0.5) : UIColor.white
        cell.cellLabel.text = content.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        if indexes.contains(indexPath.row) {
            indexes.removeAll(where: {$0 == indexPath.row})
        } else {
            indexes.append(indexPath.row)
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        return indexes.contains(indexPath.row) ? CGSize(width: collectionView.frame.height * 0.9, height: collectionView.frame.height) : CGSize(width: collectionView.frame.height * 0.9, height: collectionView.frame.height * 0.85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
