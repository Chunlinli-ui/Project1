import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 500
    height: 420
    property var keys: []
    ColumnLayout{
        anchors.fill: parent
        spacing: 5
        TabBar {
            id: bar
            Layout.preferredWidth: parent.width
            TabButton {
                text: qsTr("文件")
            }
            TabButton {
                text: qsTr("歌词")
            }
            TabButton{
                text: qsTr("播放控制")
            }
            TabButton{
                text: qsTr("播放列表")
            }

            TabButton {
                text: qsTr("工具")
            }
            TabButton {
                text: qsTr("帮助")
            }
        }

        StackLayout {
            id: stack
            width: parent.width
            height: parent.height-bar.height-bott.height-15
            currentIndex: bar.currentIndex
            Item {
                id: fileTab
                width: parent.width
                ColumnLayout{
                    width: parent.width-50
                    RowLayout{
                        width: parent.width-10
                        Layout.margins: 5
                        spacing: 10
                        Label{
                            text: qsTr("打开文件:")
                        }
                        TextField{
                            id: openfileText
                            Layout.fillWidth: true
                            text: actions.openFileAction.shortcut === undefined?"":actions.openFileAction.shortcut
                        }
                    }
                    RowLayout{
                        width: parent.width-10
                        Layout.margins: 5
                        spacing: 10
                        Label{
                            text: qsTr("打开文件夹:")
                        }
                        TextField{
                            id: openfolderText
                            Layout.fillWidth: true
                            text: actions.openFolderAction.shortcut=== undefined?"":actions.openFolderAction.shortcut
                        }
                    }
                    RowLayout{
                        width: parent.width-10
                        Layout.margins: 5
                        spacing: 10
                        Label{
                            text: qsTr("退     出:")
                        }
                        TextField{
                            id: exitText
                            Layout.fillWidth: true
                            text: actions.exitAction.shortcut===undefined?"":actions.exitAction.shortcut
                        }
                    }
                }
            }

            Item {
                id: lyricTab
                width: parent.width
                ColumnLayout{
                    width: parent.width-50
                    RowLayout{
                        width: parent.width-10
                        Layout.margins: 5
                        spacing: 10
                        Label{
                            text: qsTr("复制当前歌词:")
                        }
                        TextField{
                            id: copyText
                            Layout.fillWidth: true
                            text: actions.copyCurrentLyricAction.shortcut===undefined?"":actions.copyCurrentLyricAction.shortcut
                        }
                    }
                    RowLayout{
                        width: parent.width-10
                        Layout.margins: 5
                        spacing: 10
                        Label{
                            text: qsTr("复制所有歌词:")
                        }
                        TextField{
                            id: copyAllText
                            Layout.fillWidth: true
                            text: actions.copyAllLyricAction.shortcut===undefined?"":actions.copyAllLyricAction.shortcut
                        }
                    }
                    RowLayout{
                        width: parent.width-10
                        Layout.margins: 5
                        spacing: 10
                        Label{
                            text: qsTr("编辑歌词:")
                        }
                        TextField{
                            id: editText
                            Layout.fillWidth: true
                            text: actions.editLyricAction.shortcut===undefined?"":actions.editLyricAction.shortcut
                        }
                    }
                    RowLayout{
                        width: parent.width-10
                        Layout.margins: 5
                        spacing: 10
                        Label{
                            text: qsTr("下载歌词:")
                        }
                        TextField{
                            id: downloadText
                            Layout.fillWidth: true
                            text: actions.downloadLyricAction.shortcut===undefined?" ":actions.downloadLyricAction.shortcut
                        }
                    }
                }
            }
            Item {
                id: controlTab
                width: parent.width
                RowLayout{
                    width: parent.width
                    spacing: 10
                    ColumnLayout{
                        width: parent.width/2-5
                        RowLayout{
                            width: parent.width-10
                            Layout.margins: 5
                            spacing: 10
                            Label{
                                text: qsTr("播   放:")
                            }
                            TextField{
                                id: playText
                                Layout.fillWidth: true
                                text: actions.playAction.shortcut===undefined?"":actions.playAction.shortcut
                            }
                        }
                        RowLayout{
                            width: parent.width-10
                            Layout.margins: 5
                            spacing: 10
                            Label{
                                text: qsTr("暂   停:")
                            }
                            TextField{
                                id: pauseText
                                Layout.fillWidth: true
                                text: actions.pauseAction.shortcut===undefined?"":actions.pauseAction.shortcut
                            }
                        }
                        RowLayout{
                            width: parent.width-10
                            Layout.margins: 5
                            spacing: 10
                            Label{
                                text: qsTr("上一曲:")
                            }
                            TextField{
                                id: previousText
                                Layout.fillWidth: true
                                text: actions.previousAction.shortcut===undefined?"":actions.previousAction.shortcut
                            }
                        }
                        RowLayout{
                            width: parent.width-10
                            Layout.margins: 5
                            spacing: 10
                            Label{
                                text: qsTr("下一曲:")
                            }
                            TextField{
                                id: nextText
                                Layout.fillWidth: true
                                text: actions.nextAction.shortcut===undefined?"":actions.nextAction.shortcut
                            }
                        }
                    }
                    ColumnLayout{
                        width: parent.width/2-5
                        RowLayout{
                            width: parent.width-10
                            Layout.margins: 5
                            spacing: 10
                            Label{
                                text: qsTr("快进5秒:")
                            }
                            TextField{
                                id: fastforwardfiveScdText
                                Layout.fillWidth: true
                                text: actions.fastforwardfiveScdAction.shortcut===undefined?"":actions.fastforwardfiveScdAction.shortcut
                            }
                        }
                        RowLayout{
                            width: parent.width-10
                            Layout.margins: 5
                            spacing: 10
                            Label{
                                text: qsTr("快退5秒:")
                            }
                            TextField{
                                id: backfiveScdText
                                Layout.fillWidth: true
                                text: actions.backfiveScdAction.shortcut===undefined?"":actions.backfiveScdAction.shortcut
                            }
                        }
                        RowLayout{
                            width: parent.width-10
                            Layout.margins: 5
                            spacing: 10
                            Label{
                                text: qsTr("顺序播放：")
                            }
                            TextField{
                                id: cycPlayText
                                Layout.fillWidth: true
                                text: actions.cycPlayAction.shortcut===undefined?"":actions.cycPlayAction.shortcut
                            }
                        }
                        RowLayout{
                            width: parent.width-10
                            Layout.margins: 5
                            spacing: 10
                            Label{
                                text: qsTr("列表循环:")
                            }
                            TextField{
                                id: loopPlayText
                                Layout.fillWidth: true
                                text: actions.loopPlayAction.shortcut===undefined?"":actions.loopPlayAction.shortcut
                            }
                        }
                        RowLayout{
                            width: parent.width-10
                            Layout.margins: 5
                            spacing: 10
                            Label{
                                text: qsTr("随机播放:")
                            }
                            TextField{
                                id: ranPlayText
                                Layout.fillWidth: true
                                text: actions.ranPlayAction.shortcut===undefined?"":actions.ranPlayAction.shortcut
                            }
                        }
                    }
                }


            }
            Item {
                id: listTab
                width: parent.width
                RowLayout{
                    width: parent.width-10
                    Layout.margins: 5
                    spacing: 10
                    Label{
                        text: qsTr("删除:")
                    }
                    TextField{
                        id: deleteText
                        Layout.fillWidth: true
                        text: actions.deleteAction.shortcut===undefined?"":actions.deleteAction.shortcut
                    }
                }
            }
            Item {
                id: toolTab
                width: parent.width
                ColumnLayout{
                    width: parent.width-50
                    RowLayout{
                        width: parent.width-10
                        Layout.margins: 5
                        spacing: 10
                        Label{
                            text: qsTr("最近播放:")
                        }
                        TextField{
                            id: recentlyPlayText
                            Layout.fillWidth: true
                            text: actions.recentlyPlayAction.shortcut===undefined?"":actions.recentlyPlayAction.shortcut
                        }
                    }
                    RowLayout{
                        width: parent.width-10
                        Layout.margins: 5
                        spacing: 10
                        Label{
                            text: qsTr("曲目信息:")
                        }
                        TextField{
                            id: trackInfoText
                            Layout.fillWidth: true
                            text: actions.trackInformationAction.shortcut===undefined?"":actions.trackInformationAction.shortcut
                        }
                    }
                    RowLayout{
                        width: parent.width-10
                        Layout.margins: 5
                        spacing: 10
                        Label{
                            text: qsTr("设置快捷键:")
                        }
                        TextField{
                            id: keyMapText
                            Layout.fillWidth: true
                            text: actions.keyMapAction.shortcut===undefined?"":actions.keyMapAction.shortcut
                        }
                    }
                }
            }
            Item {
                id: helpTab
                width: parent.width
                RowLayout{
                    width: parent.width-10
                    Layout.margins: 5
                    spacing: 10
                    Label{
                        text: qsTr("关于:")
                    }
                    TextField{
                        id: aboutText
                        Layout.fillWidth: true
                        text: actions.aboutAction.shortcut===undefined?"":actions.aboutAction.shortcut
                    }
                }
            }
        }
        RowLayout{
            id: bott
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.bottomMargin: 8
            Layout.rightMargin: 5
            Button{
                text: qsTr("保存")
                onClicked: {
                    keys = []
                    actions.openFileAction.shortcut = openfileText.text
                    actions.openFolderAction.shortcut = openfolderText.text
                    actions.exitAction.shortcut = exitText.text
                    actions.playAction.shortcut = playText.text
                    actions.pauseAction.shortcut = pauseText.text
                    actions.previousAction.shortcut = previousText.text
                    actions.nextAction.shortcut = nextText.text
                    actions.fastforwardfiveScdAction.shortcut = fastforwardfiveScdText.text
                    actions.backfiveScdAction.shortcut = backfiveScdText.text
                    actions.cycPlayAction.shortcut = cycPlayText.text
                    actions.loopPlayAction.shortcut = loopPlayText.text
                    actions.ranPlayAction.shortcut = ranPlayText.text
                    actions.deleteAction.shortcut = deleteText.text
                    actions.copyCurrentLyricAction.shortcut = copyText.text
                    actions.copyAllLyricAction.shortcut = copyAllText.text
                    actions.editLyricAction.shortcut = editText.text
                    actions.downloadLyricAction.shortcut = downloadText.text
                    actions.recentlyPlayAction.shortcut = recentlyPlayText.text
                    actions.trackInformationAction.shortcut = trackInfoText.text
                    actions.keyMapAction.shortcut = keyMapText.text
                    actions.aboutAction.shortcut = aboutText.text

                    keys.push(openfileText.text)
                    keys.push(openfolderText.text)
                    keys.push(exitText.text)
                    keys.push(playText.text)
                    keys.push(previousText.text)
                    keys.push(nextText.text)
                    keys.push(fastforwardfiveScdText.text)
                    keys.push(backfiveScdText.text)
                    keys.push(cycPlayText.text)
                    keys.push(loopPlayText.text)
                    keys.push(ranPlayText.text)
                    keys.push(deleteText.text)
                    keys.push(copyText.text)
                    keys.push(copyAllText.text)
                    keys.push(editText.text)
                    keys.push(downloadText.text)
                    keys.push(recentlyPlayText.text)
                    keys.push(trackInfoText.text)
                    keys.push(keyMapText.text)
                    keys.push(aboutText.text)
                    dialogs.lyricDialog.fileIo.saveKeys(keys)
                    dialogs.saveDialog.open()
                }
            }
            Button{
                text: qsTr("取消")
                onClicked: {
                    close()
                }
            }
        }
    }
}
