import QtQuick 2.0
import QtMultimedia 5.0

VideoOutput {
    id: root
    height: width
    source: mediaPlayer

    property alias duration: mediaPlayer.duration
    property alias mediaSource: mediaPlayer.source
    property alias metaData: mediaPlayer.metaData
    property alias playbackRate: mediaPlayer.playbackRate
    property alias position: mediaPlayer.position
    property alias volume: mediaPlayer.volume

    signal sizeChanged
    signal fatalError

    onHeightChanged: root.sizeChanged()

    MediaPlayer {
        id: mediaPlayer
        autoLoad: false
        loops: Audio.Infinite

        onError: {
            if (MediaPlayer.NoError != error) {
                console.log("[qmlvideo] VideoItem.onError error " + error + " errorString " + errorString)
                root.fatalError()
            }
        }
    }

    function pause() { mediaPlayer.pause()() }
    function start() { mediaPlayer.play() }
    function stop() { mediaPlayer.stop() }
    function seek(position) { mediaPlayer.seek(position); }

    function isPlaying() {
        return mediaPlayer.playbackState === MediaPlayer.PlayingState
    }
}
