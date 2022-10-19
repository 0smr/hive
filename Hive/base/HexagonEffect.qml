// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15

ShaderEffect {
    id: effect

    property int size: Math.min(width, height)/8
    property bool flatSide: !false
    property real strokeWidth: 0.1
    property color strokeColor: '#000'
    property color color: '#fff'
    property var source: stmask
    property var strokeSource: bmask
    property bool mask: true
    property bool strokeMask: true
    readonly property vector2d s: flatSide ? Qt.vector2d(1, 1.7320508):
                                             Qt.vector2d(1.7320508, 1);
    readonly property vector2d ratio:{
        const max = Math.max(width, height);
        return Qt.vector2d(width/max, height/max);
    }

    fragmentShader: "qrc:/test-shader.glsl"
}
