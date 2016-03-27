//
//  ViewController.swift
//  Sky
//
//  Created by Adnan Aftab on 3/10/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class ProgramListViewController: UIViewController {
    
    var viewModel:ProgramListViewModelType = ProgramListViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = UITableViewAutomaticDimension
        title = self.viewModel.title
        registerViewModelNotifications()
    }
    @IBAction func onTapRefreshButton(sender: AnyObject) {
        self.tableView.hidden = true
        viewModel.refreshContent()
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func viewControllerWithIdentifier(identifier:String) -> UIViewController? {
        let sb = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return sb.instantiateViewControllerWithIdentifier(identifier)
    }
    
    func presentProgramDetailVC(program:ProgramType){
        guard let vc = viewControllerWithIdentifier("ProgramDetailViewController") as? ProgramDetailViewController else { return }
        let vm = ProgramDetailViewModel(program: program)
        vm.program = program
        vc.viewModel = vm;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        unRegisterViewModelNotifications()
    }
}
/**
 * This extension will register ViewModel notificaitons and will implment methods
 * to handel those notifications
 */
extension ProgramListViewController {
    /**
     * This method will register to view model notifications
     */
    internal func registerViewModelNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onVMStartLoadingData", name: ProgramListViewModelNotification.StartLoadingData.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onVMFinishLoadingWithSuccess", name: ProgramListViewModelNotification.FinishLoadingDataWithSuccess.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onVMFinishLoadingWithFailure", name: ProgramListViewModelNotification.FinishLoadingDataWithFailure.rawValue, object: nil)
    }
    /** 
     * Unregister view model notifications
     */
    internal func unRegisterViewModelNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ProgramListViewModelNotification.StartLoadingData.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ProgramListViewModelNotification.FinishLoadingDataWithSuccess.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ProgramListViewModelNotification.FinishLoadingDataWithFailure.rawValue, object: nil)
    }
    
    func onVMStartLoadingData() {
        self.errorLabel.hidden = true
        self.tableView.hidden = true
        spinner.startAnimating()
    }
    
    func onVMFinishLoadingWithSuccess() {
        self.tableView.hidden = false
        self.errorLabel.hidden = true
        self.spinner.stopAnimating()
        self.tableView.reloadData()
    }
    
    func onVMFinishLoadingWithFailure() {
        spinner.stopAnimating()
        self.tableView.hidden = true
        self.errorLabel.hidden = false
    }
}
/**
 * This extension will implement UITableView Delegate and data source, and will give 
 * implemention for mandatory methods
 */
extension ProgramListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalNumberOfPrograms
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = viewModel.programTitleForIndex(indexPath.row)
        cell.detailTextLabel?.text = viewModel.programDescriptionForIndex(indexPath.row)
        viewModel.smallImageForIndex(indexPath.row) { (image, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                if let img = image {
                    cell.imageView?.image = img
                }
                else {
                    cell.imageView?.image = UIImage(named: "placeholder")
                }
            })
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let pr = viewModel.programForIndex(indexPath.row) else {return}
        presentProgramDetailVC(pr)
    }
}
