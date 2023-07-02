// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                implicitContentHeight + topPadding + bottomPadding)

    property alias radius: background.radius

    padding: 6
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: palette.buttonText

    display: T.Button.TextOnly

    contentItem: Item {
        Grid {
            anchors.centerIn: parent
            spacing: control.display == T.Button.TextOnly ||
                     control.display == T.Button.IconOnly ? 0 : control.spacing

            flow: control.display == T.Button.TextUnderIcon ?
                      Grid.TopToBottom : Grid.LeftToRight
            layoutDirection: control.mirrored ? Qt.RightToLeft : Qt.LeftToRight

            opacity: control.down ? 0.8 : 1.0

            Image {
                visible: control.display != T.Button.TextOnly
                source: control.icon.source
                width: control.icon.width
                height: control.icon.height
                cache: control.icon.cache
            }

            Text {
                visible: control.display != T.Button.IconOnly
                text: control.text
                font: control.font
                color: !control.enabled ? 'gray' :
                    control.highlighted ? palette.highlightedText :
                                          palette.buttonText
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    background: Crystal {
        id: background

        property real _ycorner: Math.min(_min * 0.5, 25)
        property real _xcorner: Math.min(control.checked? _ycorner : _min * 0.2, 25)
        visible: control.enabled

        implicitWidth: 45
        implicitHeight: 45

        radius: 7/_min
        strokeWidth: control.flat ? 0 : 1
        corners: Qt.vector4d(_ycorner, _xcorner, _ycorner, _xcorner)

        color: Hive.alpha(strokeColor, control.down ? 0.3 : control.checked ? 0.4 : 0.2)
        strokeColor: {
            const  _color =  control.highlighted ? palette.highlight : palette.button
            control.down ? Qt.lighter(_color, 1.1) : _color
        }

        Behavior on _xcorner { NumberAnimation {duration: 150} }
    }
}
