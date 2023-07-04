//
//  ImageViewController.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 30.06.2023.
//

import UIKit

class ImageViewController: UIViewController {
    private var imageView: UIImageView!

    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.imageView = UIImageView(image: image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
