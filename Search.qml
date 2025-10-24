import QtQuick
import QtQuick.Controls
import QtQml
import "./pageQml/"
import "ajax.js" as AJ




TextField {
    id: inputF
    placeholderText: "Search fruits..."
    focusReason: Qt.MouseFocusReason
    validator: RegularExpressionValidator { regularExpression: /[a-zA-Z0-9]{0,22}/ }
    wrapMode: TextInput.WrapAnywhere

    background: Rectangle {
        width: 100
        height: 40
        radius: 10
        border.width: 2
        border.color: "#572920"
    }

    onAccepted: {
        var url = 'http://127.0.0.1:7878/music/songlist?server=wyy&id='
        var id = inputF.displayText
        var request_url = url.concat(id)

        leftBar.thisQml = "pageQml/PageFindMusic.qml"
        leftBar.thisBtnText = "发现音乐"
        window.modelData.clear()

        AJ.get(request_url, null, function(response) {
            var jsonStr = JSON.stringify(response)
            let arr = JSON.parse(jsonStr)
            metaHandle.end = arr.length
            metaHandle.arr = arr
            arr.forEach( x => {
                let temp = JSON.stringify(x)
                let mp = JSON.parse(temp)
                window.modelData.append({ name: mp["title"], author: mp["author"], url: mp["url"], pic: mp["pic"], lrc: mp["lrc"] })
            })
        })

    }


}


