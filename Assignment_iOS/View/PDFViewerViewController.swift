//
//  PDFViewerViewController.swift
//  Assignment_iOS
//
//  Created by apple on 10/04/25.
//

import UIKit
import PDFKit

class PDFViewerViewController: UIViewController {
    
    private let viewModel = PDFViewModel()
    private var pdfView: PDFView!
    var pdfURLString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "PDF Viewer"
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.isNavigationBarHidden = true
        setupPDFView()
        setupBackButton()
        loadPDF()
        applyDynamicColors()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeManager.applyTheme(ThemeManager.currentTheme)
    }
    
    private func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = .black
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    @objc private func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func btnnext(_ sender: UIButton) {
        
    }
    
    private func setupPDFView() {
        pdfView = PDFView(frame: .zero)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoScales = true
        view.addSubview(pdfView)
        
        NSLayoutConstraint.activate([
            pdfView.topAnchor.constraint(equalTo: view.topAnchor),
            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
        ])
        
    }
    
    private func setupNextButton() {
        
    }
    
    private func loadPDF() {
        viewModel.fetchPDF(from: pdfURLString) { [weak self] fileURL in
            guard let self = self, let fileURL = fileURL else { return }
            
            DispatchQueue.main.async {
                if let document = PDFDocument(url: fileURL) {
                    self.pdfView.document = document
                }
            }
        }
    }
    private func applyDynamicColors() {
        view.backgroundColor = UIColor.systemBackground
        let backButton = view.subviews.first(where: { $0 is UIButton }) as? UIButton
        backButton?.tintColor = UIColor.label
        pdfView.backgroundColor = UIColor.systemBackground
    }
}
