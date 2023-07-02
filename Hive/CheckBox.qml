// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.CheckBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding,
                             indicator.height + topPadding + bottomPadding)
    padding: 6
    spacing: 6

    indicator: Hexagon {
        implicitWidth: 25 * 1.175
        implicitHeight: 25

        x: control.text ?
               (control.mirrored ?
                    control.width - width - control.rightPadding :
                    control.leftPadding) :
               control.leftPadding + (control.availableWidth - width) / 2

        y: control.topPadding + (control.availableHeight - height) / 2

        radius: 3
        color: 'transparent'
        strokeColor: control.visualFocus ? palette.highlight : palette.button
        strokeWidth: 1

        Hexagon {
            id: ibox
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2


            color: Hive.alpha(palette.button, control.down ? 0.3 : 0.4)
            strokeColor: palette.button
            strokeWidth: 1

            radius: 3

            width: parent.width * 0.75
            height: parent.height * 0.75

            states:[
                State {
                    when: control.checkState === Qt.Checked
                    PropertyChanges { target: ibox }
                },
                State {
                    when: control.checkState === Qt.Unchecked
                    PropertyChanges { target: ibox; width: 0; height: 0 }
                },
                State {
                    when: control.checkState === Qt.PartiallyChecked
                    PropertyChanges {
                        target: ibox
                        rotation: 90
                        width: parent.width * 0.6
                        height: parent.height * 0.6
                        color: 'transparent'
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "*"; to: "*"
                    NumberAnimation { properties: "width,height,rotation"; duration: 150 }
                }
            ]
        }
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font: control.font
        color: palette.windowText
    }
}
