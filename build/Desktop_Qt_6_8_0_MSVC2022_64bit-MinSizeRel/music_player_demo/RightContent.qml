import QtQuick

Rectangle {
    id: rightContent

    property string thisQml: ""

    width: parent.width - leftBar.width
    height: parent.height


    Loader {
        id: rightContentLoader
        source: rightContent.thisQml
        onLoaded: {
            if(status === Loader.Ready) {
                item.parent = parent

                console.log("当前加载页面: " + thisQml + " item.parent: " + item.parent)
            }
        }
    }
}
