//
//  ViewController.swift
//  Week3Quiz
//
//  Created by JUN LEE on 2017. 7. 19..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

typealias NameList = [String]
typealias fitstLetterOfName = String

class ViewController: UITableViewController {
    // MARK: Properties
    private var nameContainerByfirstLetter : [fitstLetterOfName : NameList] = [fitstLetterOfName: NameList]()
    private var firstLettersOfName : [String] = [] // 연락처 이름의 첫번째 알파벳 배열
    private var nameListSectionTitles : [String] = ["ㄱ","●","ㄷ","●","ㅂ","●","ㅇ","●","ㅊ","●","ㅌ","●","A","●","C","●","E","●","H","●","J","●","L","●","O","●","Q","●","S","●","U","●","X","●","Z","#"]
    // 연락처 이름이 names에 저장됨
    private var names: [String] = []
    private var previousIndex = -1
    
    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 번들 내에 있는 연락처 정보를 가져옴
        guard let url = Bundle.main.url(forResource: "MemberList", withExtension: "rtf") else { return }
        let attString = try? NSAttributedString(url: url, options: [:], documentAttributes: nil)
        guard let names = attString?.string.components(separatedBy: "\n") else { return }
        self.names = names
        
        //names 초기화
        for name in names {
            guard let first = name.uppercased().characters.first else {continue}
            // 연락처 이름의 첫번째 알파벳을 중복되지 않게 memberIndexs 배열에 넣어줘야 합니다
            let firstAlphabet = String(first)
            if let _ = nameContainerByfirstLetter[firstAlphabet] {
                nameContainerByfirstLetter[firstAlphabet]?.append(name)
                continue
            }
            nameContainerByfirstLetter[firstAlphabet] = [name]
        }
        
        firstLettersOfName = nameContainerByfirstLetter.keys.sorted()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstLettersOfName.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = firstLettersOfName[section]
        guard let memberList = nameContainerByfirstLetter[key] else {return 0}
        return memberList.count
    }

    // 연락처 이름을 각 셀에 저장합니다
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableCell", for: indexPath)
        let key = firstLettersOfName[indexPath.section]
        cell.textLabel?.text = nameContainerByfirstLetter[key]?[indexPath.row]
        return cell
    }
    
    // 연락처 이름의 첫번째 알파벳들을 섹션으로 나눠줘야 합니다
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return firstLettersOfName[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nameListSectionTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let memberIndex = firstLettersOfName.index(of: title) else {
            return previousIndex + 1
        }
        previousIndex = memberIndex
        return memberIndex
    }
}

