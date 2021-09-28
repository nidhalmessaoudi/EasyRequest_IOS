//
//  ResultsViewController.swift
//  EasyRequest
//
//  Created by Nidhal Messaoudi on 9/28/21.
//  Copyright © 2021 Nidhal Messaoudi. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var results: String?
    var resultsLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        renderResults()
    }
    
    func renderResults() {
        let margins = view.layoutMarginsGuide
        
        //MARK: - Results Label Layout
        let resultsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 92, height: 40))
        self.resultsLabel = resultsLabel
        resultsLabel.text = "Results:"
        resultsLabel.font = UIFont.systemFont(ofSize: 18)
        resultsLabel.textColor = UIColor(named: "TextColor")
        view.addSubview(resultsLabel)
        
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        resultsLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5).isActive = true
        resultsLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
        resultsLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 5).isActive = true
        
        //MARK: - Results TextView Layout
        let resultsView = UITextView(frame: CGRect())
        resultsView.backgroundColor = UIColor(named: "SecondBackgroundColor")
        resultsView.textColor = UIColor(named: "TextColor")
        resultsView.font = UIFont.systemFont(ofSize: 18)
        resultsView.layer.cornerRadius = 5
        resultsView.text = results!
        view.addSubview(resultsView)
        
        resultsView.translatesAutoresizingMaskIntoConstraints = false
        resultsView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 45).isActive = true
        resultsView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -60).isActive = true
        resultsView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
        resultsView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 5).isActive = true
        
        //MARK: - New Request Button Layout
        let newRequestButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        newRequestButton.setTitle("NEW REQUEST", for: .normal)
        newRequestButton.backgroundColor = UIColor(named: "MainColor")
        newRequestButton.setTitleColor(.white, for: .normal)
        newRequestButton.layer.cornerRadius = 5
        view.addSubview(newRequestButton)
        
        newRequestButton.translatesAutoresizingMaskIntoConstraints = false
        newRequestButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        newRequestButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -5).isActive = true
        newRequestButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        newRequestButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        newRequestButton.addTarget(self, action: #selector(newRequestPressed), for: .touchUpInside)
    }
    
    @objc func newRequestPressed(sender: UIButton) {
        sender.isHighlighted = true
        self.resultsLabel?.removeFromSuperview()
        self.dismiss(animated: true)
    }

}
