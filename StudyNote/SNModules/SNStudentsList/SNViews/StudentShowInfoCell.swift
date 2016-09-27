//
//  StudentShowInfoCell.swift
//  StudyNote
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import UIKit

class StudentShowInfoCell: UITableViewCell {

    
    @IBOutlet weak var studentName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateStudentInfo(oneStudent: Student) {
        studentName.text = oneStudent.name
    }
    
}
