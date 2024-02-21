//
//  DropDownListView.swift
//  BTS
//
//  Created by Pawan Ramteke on 01/12/18.
//  Copyright © 2018 Pawan Ramteke. All rights reserved.
//

import UIKit

class DropDownListView: UIView,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    var doneClosure : ((String)->())?
    var baseView : UIView!
    var tblView : UITableView!
    var tblDataArr = NSArray()
    var arrSearch = NSMutableArray()
    var isFiltered = false
    let BASE_HEIGHT = (UIScreen.main.bounds.size.height * 0.7)
 
    init(frame: CGRect,title: String?, data: [String]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.alpha = 0
        
        tblDataArr = data as NSArray
        
        let btnBG = UIButton(frame: self.frame)
        btnBG.addTarget(self, action: #selector(DropDownListView.btnCloseClicked), for: .touchUpInside)
        self.addSubview(btnBG)
        
        baseView = UIView(frame: CGRect(x: 10, y: self.frame.midY - BASE_HEIGHT/2, width: self.frame.size.width - 20, height: BASE_HEIGHT))
        baseView.layer.cornerRadius = 5
        baseView.layer.masksToBounds = true
        baseView.backgroundColor = .white
        self.addSubview(baseView)
        
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: baseView.frame.size.width, height: 50))
        baseView.addSubview(lblTitle)
        lblTitle.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        lblTitle.textAlignment = .center
        lblTitle.text = title
        lblTitle.textColor = .black
        lblTitle.backgroundColor = UIColor(red: 0.326, green: 0.452, blue: 0.975, alpha: 1)
        lblTitle.layer.cornerRadius = 5
        lblTitle.layer.masksToBounds = true
        
        let txtFieldSearch = UITextField(frame: CGRect(x: 10, y: lblTitle.frame.maxY + 10, width: baseView.frame.size.width - 20, height: 40))
        txtFieldSearch.font = UIFont.systemFont(ofSize: 18)
        txtFieldSearch.placeholder = "Search.."
        txtFieldSearch.borderStyle = .roundedRect
        txtFieldSearch.delegate = self
        baseView.addSubview(txtFieldSearch)
        
        tblView = UITableView(frame: CGRect(x: 0, y: txtFieldSearch.frame.maxY+10, width: baseView.frame.size.width, height: baseView.frame.size.height - txtFieldSearch.frame.maxY - 10))
        tblView.dataSource = self
        tblView.delegate = self
        baseView.addSubview(tblView)
        
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltered ? arrSearch.count : tblDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellId")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "CellId")
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.text = isFiltered ? arrSearch[indexPath.row] as? String :  tblDataArr[indexPath.row] as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if doneClosure != nil {
            doneClosure!((isFiltered ? arrSearch[indexPath.row] as? String :  tblDataArr[indexPath.row] as? String)!)
        }
        btnCloseClicked()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let nsString = textField.text! as NSString
        let resultingString = nsString.replacingCharacters(in: range, with: string)
        applyFilter(text: resultingString)
        return true
    }
    
    func applyFilter(text:String)
    {
        if text.count == 0
        {
            isFiltered = false
            tblView.reloadData()
            return
        }
        else
        {
            isFiltered = true
        }
        
        let terms = text.components(separatedBy: CharacterSet.whitespaces)
        let subpredicates = NSMutableArray()
        
        for term in terms
        {
            if term.count == 0
            {
                continue
            }
            let p = NSPredicate(format:"SELF contains[c] %@",text)
            subpredicates.add(p)
        }
        
        let filter = NSCompoundPredicate(orPredicateWithSubpredicates: subpredicates as! [NSPredicate])
            
        let arr = tblDataArr.filtered(using: filter)
        arrSearch.removeAllObjects()
        arrSearch.addObjects(from: arr)
        tblView.reloadData()
    }
    
    @objc func btnCloseClicked()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { (completion) in
            self.removeFromSuperview()
        }
    }
    
    func onDoneClicked(back : @escaping (String) -> Void)
    {
        doneClosure = back
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
