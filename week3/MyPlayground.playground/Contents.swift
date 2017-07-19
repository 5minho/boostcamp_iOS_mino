//: Playground - noun: a place where people can play

import Cocoa

var indexArr = ["a","a","a","b","c","d"]
var test = "Aemon"
asd()

func asd() {
    guard let index = indexArr.index(of:"\(test.characters[test.startIndex])".lowercased()) else {
        print(index)
        return
    }
    print("없다")
}



//func makeChoseong(_target: String) ->String{
//    var _out : String = ""
//    for ( var i:Int = 0; i < _target.length; i++) {
//        var oneChar:UniChar = _target.characterAtIndex(i)
//        if (oneChar >= 0xAC00 && oneChar <= 0xD7A3){
//            var firstCodeValue = ((oneChar - 0xAC00)/28)/21
//            firstCodeValue += 0x1100;
//            _out = _out.stringByAppendingFormat( NSString(format:"%C", firstCodeValue) )
//        }
//    }
//    return _out
//}

