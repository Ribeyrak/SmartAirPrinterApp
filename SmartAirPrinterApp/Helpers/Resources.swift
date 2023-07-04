//
//  Resources.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 15.06.2023.
//

import UIKit

enum R {
    enum Colors {
        static let active = UIColor(hexString: "#3447F6")
        static let inactive = UIColor(hexString: "#C2C2C2")
        static let tabBarBackgroundColor = UIColor(hexString: "#F7F7F7")
        
        static let background = UIColor(hexString: "#EAEAEA")
        static let separator = UIColor(hexString: "#C2C2C2")
        static let secondary = UIColor(hexString: "#F0F3FF")
        
        static let titleBlack = UIColor(hexString: "#000000")
    }
    
    enum Strings {
        enum TabBar {
            static func title(for tab: Tabs) -> String {
                switch tab {
                case .printer: return "Printer"
                case .files: return "Files"
                case .photos: return "Photos"
                case .settings: return "Settings"
                }
            }
        }
        
        enum NavBar {
            static let printer = "Printer"
            static let files = "Files"
            static let photos = "Photo"
            static let settings = "Settings"
        }
    }
    
    enum Images {
        enum TabBar {
            static func icon(for tab: Tabs) -> UIImage? {
                switch tab {
                case .printer: return UIImage(named: "printerT")
                case .files: return UIImage(named: "fileT")
                case .photos: return UIImage(named: "photoT")
                case .settings: return UIImage(named: "settT")
                }
            }
        }
        
        enum Common {
            static let dollarButton = UIImage(named: "dollarButton")
            static let infoButton = UIImage(named: "infoButton")
            static let plusButton = UIImage(named: "plusN")
            static let listButton = UIImage(named: "listN")
            static let squadeButton = UIImage(named: "squadeN")
        }
    }
    
    enum Fonts {
        static func helvelticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
}
