import QtQuick 2.0

Rectangle {
    id: seekBar
    height: parent.height
    property int duration: 0
    property int playPosition: 0
    property int seekPosition: 0
    property bool enabled: true
    property bool seeking: false

    color: "#018786"
    opacity: 0.5

    Rectangle {
        id: background
        anchors.fill: parent
        color: "white"
        opacity: 0.3
        radius: parent.height / 15
    }

    Rectangle {
        id: progressBar
        anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
        width: seekBar.duration === 0 ? 0 : background.width * seekBar.playPosition / seekBar.duration
        color: "black"
        opacity: 0.5
    }

    Text {
        width: 90
        anchors { left: parent.left; top: parent.top; bottom: parent.bottom; leftMargin: 10 }
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        color: "white"
        smooth: true
        font.bold: true
        text: formatTime(playPosition)
    }

    Text {
        width: 90
        anchors { right: parent.right; top: parent.top; bottom: parent.bottom; rightMargin: 10 }
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        color: "white"
        smooth: true
        font.bold: true
        text: formatTime(duration)
    }

    Rectangle {
        id: progressHandle
        height: parent.height
        width: parent.height / 2
        color: "white"
        opacity: 1
        anchors.verticalCenter: progressBar.verticalCenter
        x: seekBar.duration === 0 ? 0 : seekBar.playPosition / seekBar.duration * background.width

        MouseArea {
            id: mouseArea
            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom }
            height: parent.height
            width: parent.height * 2
            enabled: seekBar.enabled
            drag {
                target: progressHandle
                axis: Drag.XAxis
                minimumX: 0
                maximumX: background.width
            }
            onPressed: {
                seekBar.seeking = true;
            }
            onCanceled: {
                seekBar.seekPosition = progressHandle.x * seekBar.duration / background.width
                seekBar.seeking = false
            }
            onReleased: {
                seekBar.seekPosition = progressHandle.x * seekBar.duration / background.width
                seekBar.seeking = false
                mouse.accepted = true
            }
        }
    }

    Timer { // Update position also while user is dragging the progress handle
        id: seekTimer
        repeat: true
        interval: 300
        running: seekBar.seeking
        onTriggered: {
            seekBar.seekPosition = progressHandle.x*seekBar.duration / background.width
        }
    }

    function formatTime(timeInMs) {
        if (!timeInMs || timeInMs <= 0) return "0:00"
        var seconds = timeInMs / 1000;
        var minutes = Math.floor(seconds / 60)
        seconds = Math.floor(seconds % 60)
        if (seconds < 10) seconds = "0" + seconds;
        return minutes + ":" + seconds
    }
}

