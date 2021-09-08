import QtQuick 2.12
import QtQuick.Controls 2.5
Item {
    property alias openFileAction:openFile
    property alias openFolderAction:openFolder
    property alias exitAction:exit
    property alias copyCurrentLyricAction:copyCurrentLyric
    property alias copyAllLyricAction:copyAllLyric
    property alias editLyricAction:editLyric
    property alias downloadLyricAction:downlodLyric
 //   property alias showMenubarAction:showMenubar
    property alias recentlyPlayAction:recentlyPlay
    property alias trackInformationAction:trackInformation
    property alias keyMapAction:keyMap
    property alias aboutAction:about
    property alias playAction:play
    property alias pauseAction:pause
    property alias deleteAction:del
    property alias previousAction: previous
    property alias nextAction: next
    property alias fastforwardfiveScdAction: fastforwardfiveScd
    property alias backfiveScdAction: backfiveScd
    property alias cycPlayAction: cycPlay
    property alias loopPlayAction: loopPlay
    property alias ranPlayAction:ranPlay
    property alias songSearchAction:songSearch

    Action{
        id:openFile
        text: qsTr("打开文件")
        shortcut: StandardKey.Open
        icon.source: "qrc:/image/文件.png"
        onTriggered: {
            dialogs.openMusicFileDialog()
        }
    }
    Action{
        id:songSearch
        icon.source: "qrc:/image/查找.png"
        text: qsTr("搜索歌曲")
        onTriggered: {
            dialogs.songSearchDialog.visible=true
        }
    }

    Action{
        id:openFolder
        text: qsTr("打开文件夹")
        icon.source: "qrc:/image/文件夹.png"
        onTriggered: {
            dialogs.openMusicFolderDialog();
        }
    }

    Action{   //playAction
        id:play
        text: qsTr("播放")
        icon.source: "qrc:/image/播放.png"
        onTriggered: {
            if(content.musicPlayer.fileName!==" ") {
                //音乐播放以及图标的转换
                switchToPlay()

                if(!dialogs.songSearchDialog.networkPlay) {
                    content.spectrogram.speTimer.running=true
                }

                if(dialogs.lyricDialog.lyric_id.lyric!=="") {
                    dialogs.lyricDialog.onClickAudioSlider()
                }
//
            }
        }

    }
    Action{
        id:previous
        text: qsTr("上一曲")
        icon.source:  "qrc:/image/上一曲.png"
        onTriggered: {
            content.spectrogram.speTimer.running = false
            if(dialogs.songSearchDialog.networkPlay){
                var num = dialogs.songSearchDialog.searchlistView.currentIndex
                if(num === 0){
                    num = dialogs.songSearchDialog.songListModel.count-1
                }else{
                    num--
                }
                dialogs.songSearchDialog.searchlistView.currentIndex = num
                dialogs.songSearchDialog.play1.triggered()
            }else{
                if(content.playlistPage.songListView.currentIndex === 0){
                    content.playlistPage.songListView.currentIndex = content.playlistPage.songListModel.count-1
                }else{
                    content.playlistPage.songListView.currentIndex--;
                }
                content.musicPlayer.play(content.playlistPage.songListView.currentIndex)
            }
        }

    }
    Action{
        id:next
        text: qsTr("下一曲")
        icon.source:  "qrc:/image/下一曲.png"
        onTriggered: {
            content.spectrogram.speTimer.running = false
            if(dialogs.songSearchDialog.networkPlay){
                var num = dialogs.songSearchDialog.searchlistView.currentIndex
                if(num === dialogs.songSearchDialog.songListModel.count-1){
                    num = 0
                }else{
                    num++
                }
                dialogs.songSearchDialog.searchlistView.currentIndex = num
                dialogs.songSearchDialog.play1.triggered()
            }else{
                if(content.playlistPage.songListView.currentIndex === content.playlistPage.songListModel.count-1){
                    content.playlistPage.songListView.currentIndex = 0
                }else{
                    content.playlistPage.songListView.currentIndex++;
                    console.log("next in Actions.qml")
                }
                content.musicPlayer.play(content.playlistPage.songListView.currentIndex)
            }

        }
    }

    Action{
        id:pause
        text: qsTr("暂停")
        icon.source:  "qrc:/image/暂停.png"
        onTriggered: {
            if(content.musicPlayer.fileName!==" ") {
                content.musicPlayer.audio.pause()
                content.spectrogram.speTimer.running = false
                content.musicPlayer.start.visible=true
                content.musicPlayer.pause.visible=false

                dialogs.miniDialog.musicStart.visible = true
                dialogs.miniDialog.musicPause.visible = false

                if(dialogs.lyricDialog.timerTest.running) {
                    dialogs.lyricDialog.timerTest.running=false;
                }
            }
        }

    }

    Action{
        id:del
        text: qsTr("删除")
        icon.source:  "qrc:/image/delete.png"
        onTriggered: {
            var index = content.playlistPage.songListView.currentIndex
            console.log(index)
            dialogs.lyricDialog.fileIo.deleteUrls(index, "/tmp/KirinMusic/播放列表.txt")
            content.playlistPage.songListModel.remove(index, 1)
            myMusicArray.splice(index,1)
            if(index===content.playlistPage.songListModel.count){
                index=0
                dialogs.lyricDialog.fileIo.readUrls(index,"/tmp/KirinMusic/播放列表.txt")
            }else{
                dialogs.lyricDialog.fileIo.readUrls(index,"/tmp/KirinMusic/播放列表.txt")
            }

            if(content.playlistPage.songListModel.count!==0) {
                content.musicPlayer.audio.source = "file://"+dialogs.lyricDialog.fileIo.source
                content.spectrogram.getVertices()
                dialogs.songTagDialog.showImage()
                content.playlistPage.songListView.currentIndex=index
                content.fileNameText.text=myMusicArray[index]
                dialogs.miniDialog.miniText.text=content.fileNameText.text
                content.musicPlayer.play(content.playlistPage.songListView.currentIndex)
            }
        }
    }
    Action{
        id:exit
        text: qsTr("退出")
        shortcut: StandardKey.Quit
        icon.source:"qrc:/image/退出.png"
        onTriggered: {
            if(dialogs.recentlyPlayDialog.recUrls.length !== 0){
                dialogs.lyricDialog.fileIo.saveRecentlyUrls(dialogs.recentlyPlayDialog.recUrls)
            }
            appWindow.close()
        }
    }

    Action{
        id:copyCurrentLyric
        text: qsTr("复制当前歌词")
        icon.source: "qrc:/image/copy.png"
        onTriggered: {
             if(dialogs.lyricDialog.lyric_id.lyric!=="") {
                content.lyricRightPage.clipBoard.setText(content.lyricRightPage.lyricListModel.get(content.lyricRightPage.lyricListView.currentIndex).currentLyrics)
             }
        }

    }
    Action{
        id:copyAllLyric
        text: qsTr("复制所有歌词")
        icon.source: "qrc:/image/copy.png"
        onTriggered: {
            if(dialogs.lyricDialog.lyric_id.lyric!=="") {
                var str;
                var num = dialogs.lyricDialog.lyric_id.plainLyric.length
                for(var i = 0; i < num; i++){
                    str  = str+dialogs.lyricDialog.lyric_id.plainLyric[i]+"\n"
                }
                content.lyricRightPage.clipBoard.setText(str)
            }
        }

    }
    Action{
        id:editLyric
        text: qsTr("编辑歌词")
        icon.source: "qrc:/image/编辑.png"
        onTriggered: {
            dialogs.lyricDialog.visible=true
            dialogs.lyricDialog.textArea.text = ""
        }
    }
    Action{
        id:downlodLyric
        text: qsTr("下载歌词")
        icon.source: "qrc:/image/下载.png"
        onTriggered: {
            dialogs.lyricSearchDialog.visible=true
        }
    }

    Action{
        id:recentlyPlay
        text: qsTr("最近播放")
        icon.source: "qrc:/image/最近播放.png"
        onTriggered: {
            getRecentlyPlayed()
            dialogs.recentlyPlayDialog.visible=true
        }

    }
    Action{
        id:trackInformation
        text: qsTr("曲目信息")
        icon.source: "qrc:/image/曲目信息.png"
        onTriggered: {
            var str = content.musicPlayer.audio.source.toString().slice(7)
            dialogs.songTagDialog.song.getTags(str)
            dialogs.songTagDialog.get_Tags_Meta()
            dialogs.songTagDialog.visible=true
        }
    }
    Action{
        id:keyMap
        text: qsTr("设置快捷键")
        onTriggered: {
            dialogs.keyMapDialog.visible=true
        }

    }
    Action{
        id:about
        text: qsTr("关于")
        icon.source: "qrc:/image/帮助.png"
        onTriggered: {
            dialogs.openAboutDialog()
        }
    }

    Action{
        id:fastforwardfiveScd
        text: qsTr("快进5秒")
        icon.source: "qrc:/image/快进.png"
        onTriggered: {
            content.musicPlayer.audio.seek(content.musicPlayer.audio.position + 5000)
            content.spectrogram.pcount+=50
            if(dialogs.lyricDialog.lyric_id.lyric!=="") {
                dialogs.lyricDialog.onClickAudioSlider()
            }

        }
    }

    Action{
        id:backfiveScd
        text: qsTr("快退5秒")
        icon.source: "qrc:/image/快退.png"
        onTriggered: {
            content.musicPlayer.audio.seek(content.musicPlayer.audio.position - 5000)
            if(content.spectrogram.pcount>= 50){
                content.spectrogram.pcount-=50
            }else{
                content.spectrogram.pcount = 0
            }
            if(dialogs.lyricDialog.lyric_id.lyric!=="") {
                dialogs.lyricDialog.onClickAudioSlider()
            }
        }

    }
    Action{
        id:cycPlay
        text: qsTr("单曲循环")
        icon.source: "qrc:/image/单曲循环.png"
        onTriggered: {
            content.musicPlayer.cycPlay.visible = true
            content.musicPlayer.loopPlay.visible = false
            content.musicPlayer.ranPlay.visible = false
        }

    }
    Action{
        id:loopPlay
        text: qsTr("列表循环")
        icon.source: "qrc:/image/列表循环.png"
        onTriggered: {
            content.musicPlayer.cycPlay.visible = false
            content.musicPlayer.loopPlay.visible = true
            content.musicPlayer.ranPlay.visible = false
        }

    }
    Action{
        id:ranPlay
        text: qsTr("随机播放")
        icon.source: "qrc:/image/随机播放.png"
        onTriggered: {
            content.musicPlayer.cycPlay.visible = false
            content.musicPlayer.loopPlay.visible = false
            content.musicPlayer.ranPlay.visible = true
        }

    }

    function getRecentlyPlayed(){
        if(dialogs.recentlyPlayDialog.recUrls.length !== 0){
            dialogs.lyricDialog.fileIo.saveRecentlyUrls(dialogs.recentlyPlayDialog.recUrls)
        }
        dialogs.lyricDialog.fileIo.getRecentlyPlaylist();
        var i = 0;
        var recentlyLength = dialogs.lyricDialog.fileIo.recentlyUrls.length
        dialogs.recentlyPlayDialog.recentlyListModel.clear()
        for(i = 0; i<recentlyLength; i++){
            var name = dialogs.recentlyPlayDialog.getMusicName(dialogs.lyricDialog.fileIo.recentlyUrls[i]);  //得到歌曲名字
            var path = dialogs.lyricDialog.fileIo.recentlyUrls[i]
            dialogs.songTagDialog.song.getTags(path)
            if(dialogs.songTagDialog.song.Tags["艺术家"]===undefined){
                var str = " "
            }else{
                str = dialogs.songTagDialog.song.Tags["艺术家"]
            }
            dialogs.recentlyPlayDialog.recentlyListModel.append({"songName":name, "singer":str})
        }
    }

    function switchToPlay(){
        content.musicPlayer.start.visible=false
        content.musicPlayer.pause.visible=true
        dialogs.miniDialog.musicStart.visible = false
        dialogs.miniDialog.musicPause.visible = true
        content.musicPlayer.audio.play()
        dialogs.recentlyPlayDialog.recUrls.push(content.musicPlayer.audio.source)
    }
}