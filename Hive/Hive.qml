// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

pragma Singleton
import QtQuick 2.15

QtObject {
    function alpha(c, a) { return Qt.rgba(c.r,c.g,c.b,a); }
    function invertColor(c) { return Qt.rgba(1.0 - c.r, 1.0 - c.g, 1.0 - c.b, 1.0); }
    function clamp(x, a, b) { return Math.min(Math.max(x, a), b); }
    function remap(value, low1, high1, low2, high2) {
        return low2 + (high2 - low2) * (value - low1) / (high1 - low1);
    }
    function blend(c1, c2, a = 0.5) {
        const na = 1 - a;
        const r = na * c1.r + a * c2.r,
              g = na * c1.g + a * c2.g,
              b = na * c1.b + a * c2.b;
        return Qt.rgba(r, g, b, 1.0);
    }
}
