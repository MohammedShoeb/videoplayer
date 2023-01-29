import QtQuick 2.15
import QtQuick.Window 2.15

Rectangle {
    id: videoScreen
    anchors.fill: parent

    Flickable {
        anchors.fill: parent

        PinchArea {
            anchors.fill: parent
            pinch.target: videoContainer
            pinch.maximumScale: 2.0
            pinch.minimumScale: 0.5
            pinch.dragAxis: Pinch.XAndYAxis
        }

        Rectangle {
            id: videoContainer
            anchors.fill: parent

            FyiVideoPlayer {
                id: videoPlayer
                anchors.centerIn: parent
                width: parent.width
                mediaSource: "file://" + FilePathMessenger.videoUrl

            }
        }

    }

    Item {
        width: parent.width
        height: Math.min(parent.width, parent.height) / 20
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        anchors.bottomMargin: 10

        Image {
            id: playPause
            source: "qrc:/play-pause.png"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.rightMargin: 10


            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(videoPlayer.isPlaying()) {
                        videoPlayer.pause()
                    } else {
                        videoPlayer.start()
                    }
                }
            }
        }

        SeekBar {
            width: parent.width - playPause.width
            anchors.left: playPause.right
            duration: videoPlayer.duration
            playPosition: videoPlayer.position
            onSeekPositionChanged: videoPlayer.seek(seekPosition);
        }

    }

    Component.onCompleted: {
        videoPlayer.start()
    }
}
