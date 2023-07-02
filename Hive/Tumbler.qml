// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Tumbler {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    font.pixelSize: 12
    palette.text: "gray"

    delegate: Text {
        text: modelData
        color: control.visualFocus ? palette.highlightedText : palette.buttonText
        font: control.font
        opacity: 0.4 + Math.max(0, 1 - Math.abs(Tumbler.displacement)) * 0.6
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    contentItem: PathView {
        id: pathview
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
        implicitWidth: 60
        implicitHeight: 80
        clip: true
        model: control.model
        delegate: control.delegate
        pathItemCount: control.visibleItemCount
        path: Path {
            startX: control.availableWidth / 2
            startY: 0
            PathLine {
                x: control.availableWidth / 2
                y: control.availableHeight
            }
        }
    }

    background: Crystal {
        implicitWidth: 60
        implicitHeight: 80
        radius: 5/_min
        color: Hive.alpha(strokeColor, control.down ? 0.3 : control.checked ? 0.4 : 0.2)
        corners: Qt.vector4d(20,10,20,10)
    }
}
