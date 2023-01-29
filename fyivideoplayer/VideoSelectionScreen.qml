import QtQuick 2.0

Rectangle {

    property color bgColor: "#03DAC6"
    property color bgColorSelected: "#018786"

    id: bgr
    anchors.centerIn: parent
    width: parent.width * 0.9
    height: parent.height * 0.08
    color: mouseArea.pressed ? bgColorSelected : bgColor
    radius: parent.height / 15

    Text {
        id: text
        anchors.centerIn: parent
        font.pixelSize: parent.height * 0.8
        color: "white"
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "Select video"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            FilePathMessenger.pickVideoFile()
        }
    }
}
