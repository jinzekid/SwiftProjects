//
//  SNSudentsListVC.swift
//  StudyNote
//
//  Created by YangLu on 16/1/3.
//  Copyright © 2016年 YangLu. All rights reserved.
//



import UIKit

class SNSudentsListVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    // MARK: - IBOutlets
    @IBOutlet weak var contentTableView: UITableView!
    
    
    // MARK: - Properties
    var studentsList: NSArray!
    
    let CellIdentifierID: String = "StudentShowInfoCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let rightBarItem = UIBarButtonItem(title: "添加", style: .Plain, target: self, action: Selector("addNewStudentAction"))
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        // Do any additional setup after loading the view.
        
        initContentTableView()
        initStudentListArr()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Protocol Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return studentCellAtIndexPath(tableView, indexPath: indexPath)
    }
    
    
    
    // MARK: - Utility Methods
    func initContentTableView() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.registerNib(UINib(nibName: CellIdentifierID, bundle: nil), forCellReuseIdentifier: CellIdentifierID)
    }
    
    func initStudentListArr() {
        // 读取本地学生列表
        if let arr =  arrayFromlocalPlistWithName(plist: "StudentsList") {
            studentsList = NSArray(array: arr)
            print("student list =\(studentsList)")
        }
    }
    
    func studentCellAtIndexPath(tableView:UITableView, indexPath: NSIndexPath) -> StudentShowInfoCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifierID, forIndexPath: indexPath) as? StudentShowInfoCell
        let oneStudent = Student.init(name: "YangLu", age: 32, gender: true)
        cell!.updateStudentInfo(oneStudent)
        return cell!
    }
    
    func addNewStudentAction() {
        
    }
}
