//
//  DashboardVC.swift
//  Assignment_iOS
//
//  Created by apple on 13/04/25.
//

import UIKit

class DashboardVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeManager.applyTheme(ThemeManager.currentTheme)
    }
    
    @IBAction func btnsetting(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let itemVC = storyboard.instantiateViewController(withIdentifier: "SettingVC") as? SettingVC {
            self.navigationController?.pushViewController(itemVC, animated: true)
        }
    }
    
    
    @IBAction func btnpdf(_ sender: UIButton) {
        let pdfVC = PDFViewerViewController()
        pdfVC.pdfURLString = "https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf"
        self.navigationController?.pushViewController(pdfVC, animated: true)
    }
    
    
    @IBAction func btnimage(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let itemVC = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController {
            self.navigationController?.pushViewController(itemVC, animated: true)
        }
    }
    
    @IBAction func btnapicall(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let itemVC = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as? ItemListViewController {
            self.navigationController?.pushViewController(itemVC, animated: true)
        }
    }
}
