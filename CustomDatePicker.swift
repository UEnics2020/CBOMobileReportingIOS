//
//  CustomDatePicker.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 30/04/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

protocol CustomDatePickerDelegate  : class {
    func onClickListner (sender : CustomDatePicker)
    func onDateChangeListner(sender: CustomDatePicker, date: Date)
}

class CustomDatePicker : UIView{
    
    
    public static var ShowFirstDayOfMonthFormat = "01-MMM-yyyy";
    public static var CommitFirstDayOfMonthFormat = "MM-01-yyyy";
    public static var ShowFormat = "dd-MMM-yyyy";
    public static var CommitFormat = "MM/dd/yyyy";
    
    private var vc  : CustomUIViewController!
    func setVC(vc   : CustomUIViewController){
        self.vc  = vc
    }
    
    private var listener : CustomDatePickerDelegate? = nil
    func setListener(listener : CustomDatePickerDelegate?) -> CustomDatePicker {
        self.listener = listener
        return self
    }
    
    public static func currentDate(dateFormat : String ) -> String{
        
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        let currentDate = dateFormatter.string(from: date)
        
        
        return currentDate;
    }
    
    
    func getVC() -> CustomUIViewController{
        return vc
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBInspectable public var headerBackgroundColor: UIColor = .white {
        didSet {
            label.backgroundColor = headerBackgroundColor
        }
    }
    
    @IBInspectable var slashColor : UIColor = .black
        {
        didSet{
            setup()
        }
    }
    
    
    @IBInspectable public var headerTextBoldFontSize: CGFloat = 15{
        didSet{
            label.font = label.font.withSize(headerTextBoldFontSize)
            label.font = label.font.bold()
        }
    }
    
    @IBInspectable public var headerTitle: String = "Header" {
        didSet {
            label.text = headerTitle
        }
    }
    
    @IBInspectable public var minimumDate : Date? = nil {
        didSet {
//            if  (minimumDate = ""){
//                minimumDate = nil
//            }
            //label.text = headerTitle
        }
    }
    
    @IBInspectable public var maximumDate : Date? = nil {
                didSet {
//                    if  (maximumDate = ""){
//                        maximumDate = nil
//                    }
                    //label.text = headerTitle
                }
    }
    
//    yourDatePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())
    @IBInspectable public var headerTextColor: UIColor = AppColorClass.colorPrimary! {
        didSet {
            label.textColor = headerTextColor
        }
    }
    
    fileprivate var label: UILabel! {
        didSet {
            label.translatesAutoresizingMaskIntoConstraints = false
            label.backgroundColor = headerBackgroundColor
            label.font = label.font.withSize(CGFloat(headerTextBoldFontSize))
            label.textColor = headerTextColor
            label.textAlignment = .center
            label.text = headerTitle
            label.numberOfLines = 0
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    fileprivate var button: UIButton! {
        didSet {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(didSelectedButton(_:)), for: .touchUpInside)
        }
    }
    
    @IBInspectable var boarderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = boarderWidth
        }
    }
    
    private func setup() {
    
        label = UILabel()
        self.backgroundColor = .white
        
        if cornerRadius == 0{
            self.layer.cornerRadius =  CGFloat(2)
        }else {
            self.layer.cornerRadius =  CGFloat(cornerRadius)
        }
        
        
        if boarderWidth == 0{
            self.layer.borderWidth =  CGFloat(2)
        }else {
            self.layer.borderWidth =  CGFloat(boarderWidth)
        }
        
        
        
        
        self.layer.borderColor = AppColorClass.colorPrimaryDark?.cgColor
        button = UIButton(type: .custom)
        addSubview(button)
        addSubview(label)
        let imageView = UIImageView()
        imageView.image =  UIImage(named: "calendar.png")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let widht = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: NSLayoutRelation.equal , toItem:nil, attribute: .notAnAttribute , multiplier: 1, constant: 30)
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant : 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant : 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor , constant : -5).isActive = true
        widht.isActive = true
        
        
        let slash = UIView()
        slash.backgroundColor = slashColor
        slash.translatesAutoresizingMaskIntoConstraints = false
        let widht1 = NSLayoutConstraint(item: slash, attribute: .width, relatedBy: NSLayoutRelation.equal , toItem:nil, attribute: .notAnAttribute , multiplier: 1, constant: 2)
        addSubview(slash)
        slash.topAnchor.constraint(equalTo: self.topAnchor , constant : 5).isActive = true
        slash.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant : -5).isActive = true
        slash.rightAnchor.constraint(equalTo: imageView.leftAnchor, constant : -5).isActive = true
        widht1.isActive = true
        
        
        var heightConstraint : NSLayoutConstraint!
        heightConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 0)
        heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
        heightConstraint.isActive =  true
        
        
        label.topAnchor.constraint(equalTo: self.topAnchor ,  constant : 5).isActive =  true
        label.rightAnchor.constraint(equalTo: slash.leftAnchor ,  constant : -5).isActive =  true
        label.leftAnchor.constraint(equalTo: self.leftAnchor ,  constant : 5).isActive =  true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant : -5).isActive = true
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[b]|", options: [], metrics: [:], views: ["b": button]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[b]|", options: [], metrics: [:], views: ["b": button]))
        
        
    }
    
    @objc private func didSelectedButton(_ sender: UIButton) {
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM-dd-yyyy"
//        dateFormatter.dateStyle = DateFormatter.Style.short
        
        if listener != nil {
            listener?.onClickListner(sender: self)
        }
        
        
        let datePicker : UIDatePicker = UIDatePicker()
        // setting properties of the datePicker
        //datePicker.timeZone = NSTimeZone.local
        //datePicker.frame = CGRect(0, 15, 270, 200)
        datePicker.frame = CGRect(x: 0, y: 0, width: 270, height: 260)
       
        datePicker.setDate(getDate(), animated: false)
        
        let alertController = UIAlertController(title: "", message:" " , preferredStyle: UIAlertControllerStyle.alert)
        
        //let datePicker = UIDatePicker(frame: CGRect(x: 5, y: 0, width: self.frame.size.width , height: 260))
        
        //datePicker.contentMode = UIViewContentMode.scaleAspectFill
        datePicker.datePickerMode = UIDatePickerMode.date
        
        
        //add target
        datePicker.addTarget(self, action: #selector(dateSelected(datePicker:)), for: UIControlEvents.valueChanged)
        
        //add to actionsheetview
        
        if  maximumDate != nil{
            datePicker.maximumDate = maximumDate!
        }

        if  minimumDate != nil{
            datePicker.minimumDate = minimumDate!
        }
        
        
        
        
        alertController.view.addSubview(datePicker)//add subview

        let cancelAction = UIAlertAction(title: "Done", style: .cancel) { (action) in
            self.dateSelected(datePicker: datePicker)
        }
      
        //add button to action sheet
        alertController.addAction(cancelAction)
        
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        
        alertController.view.addConstraint(height)

        vc.present(alertController, animated: true, completion: nil)
        
    }
    
    
    @objc func dateSelected(datePicker:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = CustomDatePicker.ShowFormat
        let selectedDate = dateFormatter.string(from: datePicker.date)
        label.text = selectedDate
    }
    
    func getDate(dateFormat : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: getDate())
    }
    
    func getDate() -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//         return dateFormatter.date(from: label.text!)!
        return CustomDatePicker.getDate(date: label.text!,format: CustomDatePicker.ShowFormat)!
    }
    
    public static func getDate(date : String? , format : String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        if  date != nil && date != "" {
            
            return dateFormatter.date(from: date!)!
        }else{
            return nil
        }
        

    }
    
    
    func getDateInString() -> String{
        return label.text!
    }
}

