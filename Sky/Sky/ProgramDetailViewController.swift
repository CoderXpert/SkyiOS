//
//  ProgramDetailViewController.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class ProgramDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView:UIImageView?
    @IBOutlet weak var titleLabel:UILabel?
    @IBOutlet weak var channelNameLabel:UILabel?
    @IBOutlet weak var synopsisTextView:UITextView?
    @IBOutlet weak var titleLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releasedYearLabel: UILabel!
    @IBOutlet weak var certificateLabel: UILabel!
    
    var viewModel : ProgramDetailViewModelType? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViewModelNotifications()
        updateUI()
    }
    
    func updateUI(){
        self.title = viewModel?.broadcastChannelName
        self.titleLabel?.text = viewModel?.title
        // Adjust height of label as per text and font
        if let l = self.titleLabel {
            self.titleLabelHeightConstraint?.constant = l.heightOfLabel(self.view.bounds.size.width - 40)
        }
        self.channelNameLabel?.text = viewModel?.broadcastChannelName
        self.synopsisTextView?.text = viewModel?.synopsis
        self.imageView?.image = viewModel?.image
        self.releasedYearLabel?.text = viewModel?.releaseInfoString
        self.durationLabel?.text = viewModel?.durationString
        self.certificateLabel?.text = viewModel?.certificateString
    }
    deinit {
        unRegisterViewModelNotifications()
    }
}
/**
 * This extension will register view model notification and will provide handler 
 * methods as well
 */
extension ProgramDetailViewController {
    func registerViewModelNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onFinishLoadingImage", name: ProgramDetailViewModelNotifications.DidFinishLoadingImage.rawValue, object: nil)
    }
    func unRegisterViewModelNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ProgramDetailViewModelNotifications.DidFinishLoadingImage.rawValue, object: nil)
    }
    func onFinishLoadingImage(){
        self.imageView?.image = viewModel?.image
    }
}