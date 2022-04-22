! function(e) {
    var t = {};

    function n(o) {
        if (t[o]) return t[o].exports;
        var r = t[o] = {
            i: o,
            l: !1,
            exports: {}
        };
        return e[o].call(r.exports, r, r.exports, n), r.l = !0, r.exports
    }
    n.m = e, n.c = t, n.d = function(e, t, o) {
        n.o(e, t) || Object.defineProperty(e, t, {
            enumerable: !0,
            get: o
        })
    }, n.r = function(e) {
        "undefined" != typeof Symbol && Symbol.toStringTag && Object.defineProperty(e, Symbol.toStringTag, {
            value: "Module"
        }), Object.defineProperty(e, "__esModule", {
            value: !0
        })
    }, n.t = function(e, t) {
        if (1 & t && (e = n(e)), 8 & t) return e;
        if (4 & t && "object" == typeof e && e && e.__esModule) return e;
        var o = Object.create(null);
        if (n.r(o), Object.defineProperty(o, "default", {
                enumerable: !0,
                value: e
            }), 2 & t && "string" != typeof e)
            for (var r in e) n.d(o, r, function(t) {
                return e[t]
            }.bind(null, r));
        return o
    }, n.n = function(e) {
        var t = e && e.__esModule ? function() {
            return e.default
        } : function() {
            return e
        };
        return n.d(t, "a", t), t
    }, n.o = function(e, t) {
        return Object.prototype.hasOwnProperty.call(e, t)
    }, n.p = "", n(n.s = 26)
}([function(e, t, n) {
    "use strict";
    e.exports = function(e) {
        var t = [];
        return t.toString = function() {
            return this.map(function(t) {
                var n = function(e, t) {
                    var n = e[1] || "",
                        o = e[3];
                    if (!o) return n;
                    if (t && "function" == typeof btoa) {
                        var r = (s = o, "/*# sourceMappingURL=data:application/json;charset=utf-8;base64," + btoa(unescape(encodeURIComponent(JSON.stringify(s)))) + " */"),
                            i = o.sources.map(function(e) {
                                return "/*# sourceURL=" + o.sourceRoot + e + " */"
                            });
                        return [n].concat(i).concat([r]).join("\n")
                    }
                    var s;
                    return [n].join("\n")
                }(t, e);
                return t[2] ? "@media " + t[2] + "{" + n + "}" : n
            }).join("")
        }, t.i = function(e, n) {
            "string" == typeof e && (e = [
                [null, e, ""]
            ]);
            for (var o = {}, r = 0; r < this.length; r++) {
                var i = this[r][0];
                null != i && (o[i] = !0)
            }
            for (r = 0; r < e.length; r++) {
                var s = e[r];
                null != s[0] && o[s[0]] || (n && !s[2] ? s[2] = n : n && (s[2] = "(" + s[2] + ") and (" + n + ")"), t.push(s))
            }
        }, t
    }
}, function(e, t, n) {
    var o, r, i = {},
        s = (o = function() {
            return window && document && document.all && !window.atob
        }, function() {
            return void 0 === r && (r = o.apply(this, arguments)), r
        }),
        a = function(e) {
            var t = {};
            return function(e, n) {
                if ("function" == typeof e) return e();
                if (void 0 === t[e]) {
                    var o = function(e, t) {
                        return t ? t.querySelector(e) : document.querySelector(e)
                    }.call(this, e, n);
                    if (window.HTMLIFrameElement && o instanceof window.HTMLIFrameElement) try {
                        o = o.contentDocument.head
                    } catch (e) {
                        o = null
                    }
                    t[e] = o
                }
                return t[e]
            }
        }(),
        c = null,
        l = 0,
        u = [],
        d = n(8);

    function f(e, t) {
        for (var n = 0; n < e.length; n++) {
            var o = e[n],
                r = i[o.id];
            if (r) {
                r.refs++;
                for (var s = 0; s < r.parts.length; s++) r.parts[s](o.parts[s]);
                for (; s < o.parts.length; s++) r.parts.push(I(o.parts[s], t))
            } else {
                var a = [];
                for (s = 0; s < o.parts.length; s++) a.push(I(o.parts[s], t));
                i[o.id] = {
                    id: o.id,
                    refs: 1,
                    parts: a
                }
            }
        }
    }

    function p(e, t) {
        for (var n = [], o = {}, r = 0; r < e.length; r++) {
            var i = e[r],
                s = t.base ? i[0] + t.base : i[0],
                a = {
                    css: i[1],
                    media: i[2],
                    sourceMap: i[3]
                };
            o[s] ? o[s].parts.push(a) : n.push(o[s] = {
                id: s,
                parts: [a]
            })
        }
        return n
    }

    function g(e, t) {
        var n = a(e.insertInto);
        if (!n) throw new Error("Couldn't find a style target. This probably means that the value for the 'insertInto' parameter is invalid.");
        var o = u[u.length - 1];
        if ("top" === e.insertAt) o ? o.nextSibling ? n.insertBefore(t, o.nextSibling) : n.appendChild(t) : n.insertBefore(t, n.firstChild), u.push(t);
        else if ("bottom" === e.insertAt) n.appendChild(t);
        else {
            if ("object" != typeof e.insertAt || !e.insertAt.before) throw new Error("[Style Loader]\n\n Invalid value for parameter 'insertAt' ('options.insertAt') found.\n Must be 'top', 'bottom', or Object.\n (https://github.com/webpack-contrib/style-loader#insertat)\n");
            var r = a(e.insertAt.before, n);
            n.insertBefore(t, r)
        }
    }

    function m(e) {
        if (null === e.parentNode) return !1;
        e.parentNode.removeChild(e);
        var t = u.indexOf(e);
        t >= 0 && u.splice(t, 1)
    }

    function v(e) {
        var t = document.createElement("style");
        if (void 0 === e.attrs.type && (e.attrs.type = "text/css"), void 0 === e.attrs.nonce) {
            var o = function() {
                0;
                return n.nc
            }();
            o && (e.attrs.nonce = o)
        }
        return h(t, e.attrs), g(e, t), t
    }

    function h(e, t) {
        Object.keys(t).forEach(function(n) {
            e.setAttribute(n, t[n])
        })
    }

    function I(e, t) {
        var n, o, r, i;
        if (t.transform && e.css) {
            if (!(i = "function" == typeof t.transform ? t.transform(e.css) : t.transform.default(e.css))) return function() {};
            e.css = i
        }
        if (t.singleton) {
            var s = l++;
            n = c || (c = v(t)), o = x.bind(null, n, s, !1), r = x.bind(null, n, s, !0)
        } else e.sourceMap && "function" == typeof URL && "function" == typeof URL.createObjectURL && "function" == typeof URL.revokeObjectURL && "function" == typeof Blob && "function" == typeof btoa ? (n = function(e) {
            var t = document.createElement("link");
            return void 0 === e.attrs.type && (e.attrs.type = "text/css"), e.attrs.rel = "stylesheet", h(t, e.attrs), g(e, t), t
        }(t), o = function(e, t, n) {
            var o = n.css,
                r = n.sourceMap,
                i = void 0 === t.convertToAbsoluteUrls && r;
            (t.convertToAbsoluteUrls || i) && (o = d(o));
            r && (o += "\n/*# sourceMappingURL=data:application/json;base64," + btoa(unescape(encodeURIComponent(JSON.stringify(r)))) + " */");
            var s = new Blob([o], {
                    type: "text/css"
                }),
                a = e.href;
            e.href = URL.createObjectURL(s), a && URL.revokeObjectURL(a)
        }.bind(null, n, t), r = function() {
            m(n), n.href && URL.revokeObjectURL(n.href)
        }) : (n = v(t), o = function(e, t) {
            var n = t.css,
                o = t.media;
            o && e.setAttribute("media", o);
            if (e.styleSheet) e.styleSheet.cssText = n;
            else {
                for (; e.firstChild;) e.removeChild(e.firstChild);
                e.appendChild(document.createTextNode(n))
            }
        }.bind(null, n), r = function() {
            m(n)
        });
        return o(e),
            function(t) {
                if (t) {
                    if (t.css === e.css && t.media === e.media && t.sourceMap === e.sourceMap) return;
                    o(e = t)
                } else r()
            }
    }
    e.exports = function(e, t) {
        if ("undefined" != typeof DEBUG && DEBUG && "object" != typeof document) throw new Error("The style-loader cannot be used in a non-browser environment");
        (t = t || {}).attrs = "object" == typeof t.attrs ? t.attrs : {}, t.singleton || "boolean" == typeof t.singleton || (t.singleton = s()), t.insertInto || (t.insertInto = "head"), t.insertAt || (t.insertAt = "bottom");
        var n = p(e, t);
        return f(n, t),
            function(e) {
                for (var o = [], r = 0; r < n.length; r++) {
                    var s = n[r];
                    (a = i[s.id]).refs--, o.push(a)
                }
                e && f(p(e, t), t);
                for (r = 0; r < o.length; r++) {
                    var a;
                    if (0 === (a = o[r]).refs) {
                        for (var c = 0; c < a.parts.length; c++) a.parts[c]();
                        delete i[a.id]
                    }
                }
            }
    };
    var b, y = (b = [], function(e, t) {
        return b[e] = t, b.filter(Boolean).join("\n")
    });

    function x(e, t, n, o) {
        var r = n ? "" : o.css;
        if (e.styleSheet) e.styleSheet.cssText = y(t, r);
        else {
            var i = document.createTextNode(r),
                s = e.childNodes;
            s[t] && e.removeChild(s[t]), s.length ? e.insertBefore(i, s[t]) : e.appendChild(i)
        }
    }
}, function(e, t, n) {
    "use strict";
    e.exports = function(e, t) {
        return "string" != typeof e ? e : (/^['"].*['"]$/.test(e) && (e = e.slice(1, -1)), /["'() \t\n]/.test(e) || t ? '"' + e.replace(/"/g, '\\"').replace(/\n/g, "\\n") + '"' : e)
    }
}, function(e, t) {
    e.exports = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHdpZHRoPScxMDAlJyBoZWlnaHQ9JzEwMCUnIHZpZXdCb3g9Jy01IC0yIDUwIDYwJyBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSdub25lJz48cGF0aCBmaWxsPScjZmZmJyBkPSdNMTQuNzU3IDQ2LjAyYTUuNjg4IDUuNjg4IDAgMCAxLTMuOTI5LTEuNTY5IDUuNzA1IDUuNzA1IDAgMCAxLS4yMDQtOC4wNjNMMjMuMzgyIDIyLjk3IDEwLjYzNyA5LjY0NWE1LjcwMyA1LjcwMyAwIDAgMSA4LjI0Mi03Ljg4NGwxNi41MDUgMTcuMjUzYTUuNzA3IDUuNzA3IDAgMCAxIC4wMTMgNy44NzJMMTguODkzIDQ0LjI0N2E1LjY5OSA1LjY5OSAwIDAgMS00LjEzNiAxLjc3M3onLz48L3N2Zz4="
}, function(e, t) {
    e.exports = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMDAgMTAwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWlkWU1pZCIgY2xhc3M9Imxkcy1zdHJpcGUiPjxkZWZzPjxwYXR0ZXJuIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHdpZHRoPSIxMDAiIGhlaWdodD0iMTAwIiBpZD0iYSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMTEuODQyKSI+PHBhdGggZmlsbD0iI2FmNjZmZSIgZD0iTS0yMC0xMGgxMHYxMjBoLTEweiIgdHJhbnNmb3JtPSJyb3RhdGUoMjAgNTAgNTApIHNjYWxlKDEuMikiLz48cGF0aCBmaWxsPSIjNjNlMmZmIiBkPSJNLTEwLTEwSDB2MTIwaC0xMHoiIHRyYW5zZm9ybT0icm90YXRlKDIwIDUwIDUwKSBzY2FsZSgxLjIpIi8+PHBhdGggZmlsbD0iI2FmNjZmZSIgZD0iTTAtMTBoMTB2MTIwSDB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxwYXRoIGZpbGw9IiM2M2UyZmYiIGQ9Ik0xMC0xMGgxMHYxMjBIMTB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxwYXRoIGZpbGw9IiNhZjY2ZmUiIGQ9Ik0yMC0xMGgxMHYxMjBIMjB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxwYXRoIGZpbGw9IiM2M2UyZmYiIGQ9Ik0zMC0xMGgxMHYxMjBIMzB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxwYXRoIGZpbGw9IiNhZjY2ZmUiIGQ9Ik00MC0xMGgxMHYxMjBINDB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxwYXRoIGZpbGw9IiM2M2UyZmYiIGQ9Ik01MC0xMGgxMHYxMjBINTB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxwYXRoIGZpbGw9IiNhZjY2ZmUiIGQ9Ik02MC0xMGgxMHYxMjBINjB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxwYXRoIGZpbGw9IiM2M2UyZmYiIGQ9Ik03MC0xMGgxMHYxMjBINzB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxwYXRoIGZpbGw9IiNhZjY2ZmUiIGQ9Ik04MC0xMGgxMHYxMjBIODB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxwYXRoIGZpbGw9IiM2M2UyZmYiIGQ9Ik05MC0xMGgxMHYxMjBIOTB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxwYXRoIGZpbGw9IiNhZjY2ZmUiIGQ9Ik0xMDAtMTBoMTB2MTIwaC0xMHpNMTEwLTEwaDEwdjEyMGgtMTB6IiB0cmFuc2Zvcm09InJvdGF0ZSgyMCA1MCA1MCkgc2NhbGUoMS4yKSIvPjxhbmltYXRlVHJhbnNmb3JtIGF0dHJpYnV0ZU5hbWU9InRyYW5zZm9ybSIgdHlwZT0idHJhbnNsYXRlIiB2YWx1ZXM9IjAgMDsyNiAwIiBrZXlUaW1lcz0iMDsxIiByZXBlYXRDb3VudD0iaW5kZWZpbml0ZSIgZHVyPSIxLjlzIi8+PC9nPjwvcGF0dGVybj48L2RlZnM+PHJlY3Qgcng9IjEwIiByeT0iMTAiIHg9IjEwIiB5PSI0MCIgc3Ryb2tlPSIjMDQwMzBmIiBzdHJva2Utd2lkdGg9IjQiIHdpZHRoPSI4MCIgaGVpZ2h0PSIyMCIgZmlsbD0idXJsKCNhKSIvPjwvc3ZnPg=="
}, function(e, t, n) {
    var o = n(6);
    "string" == typeof o && (o = [
        [e.i, o, ""]
    ]);
    var r = {
        insertAt: "top",
        singleton: !0,
        hmr: !0,
        transform: void 0,
        insertInto: void 0
    };
    n(1)(o, r);
    o.locals && (e.exports = o.locals)
}, function(e, t, n) {
    t = e.exports = n(0)(!1);
    var o = n(2)(n(7));
    t.push([e.i, "::-webkit-input-placeholder{color:var(--c4)}::-moz-placeholder{color:var(--c4)}:-ms-input-placeholder{color:var(--c4)}::-ms-input-placeholder{color:var(--c4)}::placeholder{color:var(--c4)}.container.svelte-aie5gw{background:var(--c3);width:100%;max-width:400px;min-width:300px;max-height:500px;margin:50px;padding:40px;border-radius:8px;border:3px solid var(--c5);box-shadow:var(--shadow);transition:all .3s cubic-bezier(.455,.03,.515,.955);-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;z-index:100;position:absolute;left:10%;top:39%}h1.svelte-aie5gw{color:#fff;letter-spacing:2px;margin:0 0 20px}input.svelte-aie5gw{background-color:transparent;border:none;outline:none;font-size:1em;font-family:scientifica;font-style:normal;color:#fff;padding:8px;width:100%;z-index:100;position:relative}form.svelte-aie5gw{display:flex;flex-direction:column;margin:0}.form-group.svelte-aie5gw{position:relative;margin-bottom:20px}.form-group.svelte-aie5gw>span.svelte-aie5gw{position:absolute;width:100%;border-radius:6px;top:95%;bottom:0;left:0;background:var(--c1);background:linear-gradient(45deg,var(--c1),var(--c2));transition:all .3s cubic-bezier(.785,.135,.15,.86);z-index:1}.form-group>input:focus+span.svelte-aie5gw{top:0}.error-group.svelte-aie5gw{text-align:center;color:#bf616a;font-style:italic;position:relative;overflow:hidden;transition:all .3s ease-in-out}.error-group.svelte-aie5gw p.svelte-aie5gw{margin:10px 0;position:absolute;left:0;right:0}button.svelte-aie5gw{border-radius:50%;background:var(--c1);background:linear-gradient(45deg,var(--c1),var(--c2));border:none;width:40px;height:40px;box-shadow:0 10px 20px rgba(129,161,193,.19),0 6px 6px rgba(129,161,193,.23);cursor:pointer;padding:10px;margin-left:auto;color:#fff;transition:all .3s cubic-bezier(.39,.575,.565,1)}button.svelte-aie5gw:focus,button.svelte-aie5gw:hover{box-shadow:0 3px 6px rgba(129,161,193,.16),0 3px 6px rgba(129,161,193,.23)}.bottom.svelte-aie5gw{display:flex;margin-top:20px}.session.svelte-aie5gw{display:flex;align-items:flex-end;font-family:scientifica}.session.svelte-aie5gw>span.svelte-aie5gw{color:var(--c4);margin-right:2px}.session-list.svelte-aie5gw{color:var(--c4);box-sizing:border-box;margin:0;padding-left:15px;border:none;-webkit-appearance:none;background-color:transparent;background-image:url(" + o + ");background-repeat:no-repeat;background-position:0;background-size:contain;cursor:pointer;font-family:scientifica}.session-list.svelte-aie5gw option.svelte-aie5gw{background:var(--c3);font-size:1em;font-family:scientifica}", ""])
}, function(e, t) {
    e.exports = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBmaWxsPSIjNTE1MDY1IiBkPSJNOC43MSAxMS43MWwyLjU5IDIuNTljLjM5LjM5IDEuMDIuMzkgMS40MSAwbDIuNTktMi41OWMuNjMtLjYzLjE4LTEuNzEtLjcxLTEuNzFIOS40MWMtLjg5IDAtMS4zMyAxLjA4LS43IDEuNzF6Ii8+PC9zdmc+"
}, function(e, t) {
    e.exports = function(e) {
        var t = "undefined" != typeof window && window.location;
        if (!t) throw new Error("fixUrls requires window.location");
        if (!e || "string" != typeof e) return e;
        var n = t.protocol + "//" + t.host,
            o = n + t.pathname.replace(/\/[^\/]*$/, "/");
        return e.replace(/url\s*\(((?:[^)(]|\((?:[^)(]+|\([^)(]*\))*\))*)\)/gi, function(e, t) {
            var r, i = t.trim().replace(/^"(.*)"$/, function(e, t) {
                return t
            }).replace(/^'(.*)'$/, function(e, t) {
                return t
            });
            return /^(#|data:|http:\/\/|https:\/\/|file:\/\/\/|\s*$)/i.test(i) ? e : (r = 0 === i.indexOf("//") ? i : 0 === i.indexOf("/") ? n + i : o + i.replace(/^\.\//, ""), "url(" + JSON.stringify(r) + ")")
        })
    }
}, function(e, t, n) {
    var o = n(10);
    "string" == typeof o && (o = [
        [e.i, o, ""]
    ]);
    var r = {
        insertAt: "top",
        singleton: !0,
        hmr: !0,
        transform: void 0,
        insertInto: void 0
    };
    n(1)(o, r);
    o.locals && (e.exports = o.locals)
}, function(e, t, n) {
    (e.exports = n(0)(!1)).push([e.i, ".loader.svelte-1gjz2c5{position:absolute;display:flex;flex-direction:column;align-items:center;z-index:100}.loader.svelte-1gjz2c5 img.svelte-1gjz2c5{width:75px}.loader.svelte-1gjz2c5 span.svelte-1gjz2c5{font-size:1.6em;font-style:italic;color:var(--c3)}", ""])
}, function(e, t, n) {
    var o = n(12);
    "string" == typeof o && (o = [
        [e.i, o, ""]
    ]);
    var r = {
        insertAt: "top",
        singleton: !0,
        hmr: !0,
        transform: void 0,
        insertInto: void 0
    };
    n(1)(o, r);
    o.locals && (e.exports = o.locals)
}, function(e, t, n) {
    (e.exports = n(0)(!1)).push([e.i, ".clock.svelte-6cac4v{display:flex}", ""])
}, function(e, t, n) {
    var o = n(14);
    "string" == typeof o && (o = [
        [e.i, o, ""]
    ]);
    var r = {
        insertAt: "top",
        singleton: !0,
        hmr: !0,
        transform: void 0,
        insertInto: void 0
    };
    n(1)(o, r);
    o.locals && (e.exports = o.locals)
}, function(e, t, n) {
    (e.exports = n(0)(!1)).push([e.i, "div.svelte-1bnanxq{display:flex;color:var(--c4);font-family:scientifica;position:absolute;top:0;right:0;padding:20px 20px 0 0;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;z-index:100}.action.svelte-1bnanxq{cursor:pointer;opacity:.5;transition:all .3s ease-in-out}.action.svelte-1bnanxq:hover{opacity:1}.divider.svelte-1bnanxq{margin:0 10px}", ""])
}, function(e, t, n) {
    e.exports = n.p + "assets/background.jpg"
}, function(e, t, n) {
    var o = n(17);
    "string" == typeof o && (o = [
        [e.i, o, ""]
    ]);
    var r = {
        insertAt: "top",
        singleton: !0,
        hmr: !0,
        transform: void 0,
        insertInto: void 0
    };
    n(1)(o, r);
    o.locals && (e.exports = o.locals)
}, function(e, t, n) {
    (e.exports = n(0)(!1)).push([e.i, ":root{--c1:#81a1c1;--c2:#81a1c1;--c3:#2e3440;--c4:#4c566a;--c5:#3b4252;--shadow:0 14px 28px rgba(4,3,15,0.25),0 10px 10px rgba(4,3,15,0.22);--shadow-h:0 19px 38px rgba(4,3,15,0.3),0 15px 12px rgba(4,3,15,0.22)}*{box-sizing:border-box}body,html{margin:0;padding:0;font-family:scientifica;font-size:14px;overflow:hidden;transition:opacity .3s ease-out}main{height:100%;display:flex;flex-direction:column;justify-content:center;align-items:center;position:relative}.container__active{box-shadow:var(--shadow-h)!important}.imageReady{opacity:1!important}.error-show{height:35px}.logged-in{background:#000!important;opacity:0}.show-error{height:35px}.hide-error{height:0}.background.svelte-13zn5s{position:absolute;width:100%;height:100%;opacity:0;transition:opacity .3s ease-in}", ""])
}, function(e, t, n) {
    var o = n(19);
    "string" == typeof o && (o = [
        [e.i, o, ""]
    ]);
    var r = {
        insertAt: "top",
        singleton: !0,
        hmr: !0,
        transform: void 0,
        insertInto: void 0
    };
    n(1)(o, r);
    o.locals && (e.exports = o.locals)
}, function(e, t, n) {
    t = e.exports = n(0)(!1);
    var o = n(2),
        r = o(n(20)),
        i = o(n(21)),
        s = o(n(22)),
        a = o(n(23)),
        c = o(n(24)),
        l = o(n(25));
    t.push([e.i, "@font-face{font-family:scientifica;src:url(" + r + ') format("woff2"),url(' + i + ') format("woff");font-style:normal;font-weight:400}@font-face{font-family:scientifica;src:url(' + s + ') format("woff2"),url(' + a + ') format("woff");font-style:italic;font-weight:400}@font-face{font-family:scientifica;src:url(' + c + ') format("woff2"),url(' + l + ') format("woff");font-style:bold;font-weight:400}', ""])
}, function(e, t, n) {
    e.exports = n.p + "assets/scientifica.woff2"
}, function(e, t, n) {
    e.exports = n.p + "assets/scientifica.woff"
}, function(e, t, n) {
    e.exports = n.p + "assets/scientificaItalic.woff2"
}, function(e, t, n) {
    e.exports = n.p + "assets/scientificaItalic.woff"
}, function(e, t, n) {
    e.exports = n.p + "assets/scientificaBold.woff2"
}, function(e, t, n) {
    e.exports = n.p + "assets/scientificaBold.woff"
}, function(e, t, n) {
    "use strict";

    function o() {}
    n.r(t);
    const r = e => e;

    function i(e) {
        return e()
    }

    function s() {
        return Object.create(null)
    }

    function a(e) {
        e.forEach(i)
    }

    function c(e) {
        return "function" == typeof e
    }

    function l(e, t) {
        return e != e ? t == t : e !== t || e && "object" == typeof e || "function" == typeof e
    }
    const u = new Set;
    let d, f = !1;

    function p() {
        u.forEach(e => {
            e[0](window.performance.now()) || (u.delete(e), e[1]())
        }), (f = u.size > 0) && requestAnimationFrame(p)
    }

    function g(e) {
        let t;
        return f || (f = !0, requestAnimationFrame(p)), {
            promise: new Promise(n => {
                u.add(t = [e, n])
            }),
            abort() {
                u.delete(t)
            }
        }
    }

    function m(e, t) {
        e.appendChild(t)
    }

    function v(e, t, n) {
        e.insertBefore(t, n)
    }

    function h(e) {
        e.parentNode.removeChild(e)
    }

    function I(e, t) {
        for (let n = 0; n < e.length; n += 1) e[n] && e[n].d(t)
    }

    function b(e) {
        return document.createElement(e)
    }

    function y(e) {
        return document.createTextNode(e)
    }

    function x() {
        return y(" ")
    }

    function w() {
        return y("")
    }

    function M(e, t, n, o) {
        return e.addEventListener(t, n, o), () => e.removeEventListener(t, n, o)
    }

    function j(e, t, n) {
        null == n ? e.removeAttribute(t) : e.setAttribute(t, n)
    }

    function $(e, t) {
        t = "" + t, e.data !== t && (e.data = t)
    }

    function S(e, t) {
        for (let n = 0; n < e.options.length; n += 1) {
            const o = e.options[n];
            if (o.__value === t) return void(o.selected = !0)
        }
    }

    function N(e, t) {
        const n = document.createEvent("CustomEvent");
        return n.initCustomEvent(e, !1, !1, t), n
    }
    let C, Z = 0,
        A = {};

    function k(e, t, n, o, r, i, s, a = 0) {
        const c = 16.666 / o;
        let l = "{\n";
        for (let e = 0; e <= 1; e += c) {
            const o = t + (n - t) * i(e);
            l += 100 * e + `%{${s(o,1-o)}}\n`
        }
        const u = l + `100% {${s(n,1-n)}}\n}`,
            f = `__svelte_${function(e){let t=5381,n=e.length;for(;n--;)t=(t<<5)-t^e.charCodeAt(n);return t>>>0}(u)}_${a}`;
        if (!A[f]) {
            if (!d) {
                const e = b("style");
                document.head.appendChild(e), d = e.sheet
            }
            A[f] = !0, d.insertRule(`@keyframes ${f} ${u}`, d.cssRules.length)
        }
        const p = e.style.animation || "";
        return e.style.animation = `${p?`${p}, `:""}${f} ${o}ms linear ${r}ms 1 both`, Z += 1, f
    }

    function G(e, t) {
        e.style.animation = (e.style.animation || "").split(", ").filter(t ? e => e.indexOf(t) < 0 : e => -1 === e.indexOf("__svelte")).join(", "), t && !--Z && requestAnimationFrame(() => {
            if (Z) return;
            let e = d.cssRules.length;
            for (; e--;) d.deleteRule(e);
            A = {}
        })
    }

    function z(e) {
        C = e
    }

    function B() {
        if (!C) throw new Error("Function called outside component initialization");
        return C
    }

    function L(e) {
        B().$$.on_mount.push(e)
    }
    const U = [],
        D = Promise.resolve();
    let _ = !1;
    const T = [],
        Y = [],
        P = [];

    function E() {
        _ || (_ = !0, D.then(R))
    }

    function H(e) {
        Y.push(e)
    }

    function R() {
        const e = new Set;
        do {
            for (; U.length;) {
                const e = U.shift();
                z(e), O(e.$$)
            }
            for (; T.length;) T.shift()();
            for (; Y.length;) {
                const t = Y.pop();
                e.has(t) || (t(), e.add(t))
            }
        } while (U.length);
        for (; P.length;) P.pop()();
        _ = !1
    }

    function O(e) {
        e.fragment && (e.update(e.dirty), a(e.before_render), e.fragment.p(e.dirty, e.ctx), e.dirty = null, e.after_render.forEach(H))
    }
    let J, F;

    function X() {
        return J || (J = Promise.resolve()).then(() => {
            J = null
        }), J
    }

    function W(e, t, n) {
        e.dispatchEvent(N(`${t?"intro":"outro"}${n}`))
    }

    function q() {
        F = {
            remaining: 0,
            callbacks: []
        }
    }

    function Q() {
        F.remaining || a(F.callbacks)
    }

    function K(e) {
        F.callbacks.push(e)
    }

    function V(e, t, n) {
        let i, s, a = t(e, n),
            c = !1,
            l = 0;

        function u() {
            i && G(e, i)
        }

        function d() {
            const {
                delay: t = 0,
                duration: n = 300,
                easing: d = r,
                tick: f = o,
                css: p
            } = a;
            p && (i = k(e, 0, 1, n, t, d, p, l++)), f(0, 1);
            const m = window.performance.now() + t,
                v = m + n;
            s && s.abort(), c = !0, s = g(e => {
                if (c) {
                    if (e >= v) return f(1, 0), u(), c = !1;
                    if (e >= m) {
                        const t = d((e - m) / n);
                        f(t, 1 - t)
                    }
                }
                return c
            })
        }
        let f = !1;
        return {
            start() {
                f || (G(e), "function" == typeof a ? (a = a(), X().then(d)) : d())
            },
            invalidate() {
                f = !1
            },
            end() {
                c && (u(), c = !1)
            }
        }
    }

    function ee(e, t, n) {
        let i, s = t(e, n),
            c = !0;
        const l = F;

        function u() {
            const {
                delay: t = 0,
                duration: n = 300,
                easing: u = r,
                tick: d = o,
                css: f
            } = s;
            f && (i = k(e, 1, 0, n, t, u, f));
            const p = window.performance.now() + t,
                m = p + n;
            g(e => {
                if (c) {
                    if (e >= m) return d(0, 1), --l.remaining || a(l.callbacks), !1;
                    if (e >= p) {
                        const t = u((e - p) / n);
                        d(1 - t, t)
                    }
                }
                return c
            })
        }
        return l.remaining += 1, "function" == typeof s ? X().then(() => {
            s = s(), u()
        }) : u(), {
            end(t) {
                t && s.tick && s.tick(1, 0), c && (i && G(e, i), c = !1)
            }
        }
    }

    function te(e, t, n, i) {
        let s = t(e, n),
            c = i ? 0 : 1,
            l = null,
            u = null,
            d = null;

        function f() {
            d && G(e, d)
        }

        function p(e, t) {
            const n = e.b - c;
            return t *= Math.abs(n), {
                a: c,
                b: e.b,
                d: n,
                duration: t,
                start: e.start,
                end: e.start + t,
                group: e.group
            }
        }

        function m(t) {
            const {
                delay: n = 0,
                duration: i = 300,
                easing: m = r,
                tick: v = o,
                css: h
            } = s, I = {
                start: window.performance.now() + n,
                b: t
            };
            t || (I.group = F, F.remaining += 1), l ? u = I : (h && (f(), d = k(e, c, t, i, n, m, h)), t && v(0, 1), l = p(I, i), H(() => W(e, t, "start")), g(t => {
                if (u && t > u.start && (l = p(u, i), u = null, W(e, l.b, "start"), h && (f(), d = k(e, c, l.b, l.duration, 0, m, s.css))), l)
                    if (t >= l.end) v(c = l.b, 1 - c), W(e, l.b, "end"), u || (l.b ? f() : --l.group.remaining || a(l.group.callbacks)), l = null;
                    else if (t >= l.start) {
                    const e = t - l.start;
                    c = l.a + l.d * m(e / l.duration), v(c, 1 - c)
                }
                return !(!l && !u)
            }))
        }
        return {
            run(e) {
                "function" == typeof s ? X().then(() => {
                    s = s(), m(e)
                }) : m(e)
            },
            end() {
                f(), l = u = null
            }
        }
    }
    let ne;

    function oe(e, t, n) {
        const {
            fragment: o,
            on_mount: r,
            on_destroy: s,
            after_render: l
        } = e.$$;
        o.m(t, n), H(() => {
            const t = r.map(i).filter(c);
            s ? s.push(...t) : a(t), e.$$.on_mount = []
        }), l.forEach(H)
    }

    function re(e, t) {
        e.$$ && (a(e.$$.on_destroy), e.$$.fragment.d(t), e.$$.on_destroy = e.$$.fragment = null, e.$$.ctx = {})
    }

    function ie(e, t, n, r, i, c) {
        const l = C;
        z(e);
        const u = t.props || {},
            d = e.$$ = {
                fragment: null,
                ctx: null,
                props: c,
                update: o,
                not_equal: i,
                bound: s(),
                on_mount: [],
                on_destroy: [],
                before_render: [],
                after_render: [],
                context: new Map(l ? l.$$.context : []),
                callbacks: s(),
                dirty: null
            };
        let f = !1;
        var p;
        d.ctx = n ? n(e, u, (t, n) => {
            d.ctx && i(d.ctx[t], d.ctx[t] = n) && (d.bound[t] && d.bound[t](n), f && function(e, t) {
                e.$$.dirty || (U.push(e), E(), e.$$.dirty = {}), e.$$.dirty[t] = !0
            }(e, t))
        }) : u, d.update(), f = !0, a(d.before_render), d.fragment = r(d.ctx), t.target && (t.hydrate ? d.fragment.l((p = t.target, Array.from(p.childNodes))) : d.fragment.c(), t.intro && e.$$.fragment.i && e.$$.fragment.i(), oe(e, t.target, t.anchor), R()), z(l)
    }
    "undefined" != typeof HTMLElement && (ne = class extends HTMLElement {
        constructor() {
            super(), this.attachShadow({
                mode: "open"
            })
        }
        connectedCallback() {
            for (const e in this.$$.slotted) this.appendChild(this.$$.slotted[e])
        }
        attributeChangedCallback(e, t, n) {
            this[e] = n
        }
        $destroy() {
            re(this, !0), this.$destroy = o
        }
        $on(e, t) {
            const n = this.$$.callbacks[e] || (this.$$.callbacks[e] = []);
            return n.push(t), () => {
                const e = n.indexOf(t); - 1 !== e && n.splice(e, 1)
            }
        }
        $set() {}
    });
    class se {
        $destroy() {
            re(this, !0), this.$destroy = o
        }
        $on(e, t) {
            const n = this.$$.callbacks[e] || (this.$$.callbacks[e] = []);
            return n.push(t), () => {
                const e = n.indexOf(t); - 1 !== e && n.splice(e, 1)
            }
        }
        $set() {}
    }

    function ae(e) {
        var t = e - 1;
        return t * t * t + 1
    }

    function ce(e) {
        return (e /= .5) < 1 ? .5 * e * e : -.5 * (--e * (e - 2) - 1)
    }

    function le(e, {
        delay: t = 0,
        duration: n = 400
    }) {
        const o = +getComputedStyle(e).opacity;
        return {
            delay: t,
            duration: n,
            css: e => `opacity: ${e*o}`
        }
    }

    function ue(e, {
        delay: t = 0,
        duration: n = 400,
        easing: o = ae,
        x: r = 0,
        y: i = 0,
        opacity: s = 0
    }) {
        const a = getComputedStyle(e),
            c = +a.opacity,
            l = "none" === a.transform ? "" : a.transform,
            u = c * (1 - s);
        return {
            delay: t,
            duration: n,
            easing: o,
            css: (e, t) => `\n\t\t\ttransform: ${l} translate(${(1-e)*r}px, ${(1-e)*i}px);\n\t\t\topacity: ${c-u*t}`
        }
    }
    var de = n(3),
        fe = n.n(de);
    n(5);

    function pe(e, t, n) {
        const o = Object.create(e);
        return o.session = t[n], o
    }

    function ge(e) {
        for (var t, n, o, r, i, s, c, l, u, d, f, p, g, w, N, C, Z, A, k, G, z, B, L, U, D, _, T, Y, P, E, R, O, J = e.lightdm.hostname || "welcome", F = e.error || "", X = e.lightdm.sessions, W = [], q = 0; q < X.length; q += 1) W[q] = me(pe(e, X, q));
        return {
            c() {
                t = b("div"), n = b("h1"), o = y(J), r = x(), i = b("form"), s = b("div"), c = b("input"), l = x(), u = b("span"), d = x(), f = b("div"), p = b("input"), g = x(), w = b("span"), N = x(), C = b("div"), Z = b("p"), A = y(F), G = x(), z = b("div"), B = b("div"), (L = b("span")).textContent = "session:", U = x(), D = b("select");
                for (var a = 0; a < W.length; a += 1) W[a].c();
                var m;
                _ = x(), T = b("button"), Y = b("img"), n.className = "svelte-aie5gw", c.id = "user-name", j(c, "type", "text"), c.placeholder = "username", c.value = "barbarossa", c.className = "svelte-aie5gw", u.className = "svelte-aie5gw", s.className = "form-group svelte-aie5gw", p.autofocus = !0, p.id = "user-secret", j(p, "type", "password"), p.placeholder = "password", p.className = "svelte-aie5gw", w.className = "svelte-aie5gw", f.className = "form-group svelte-aie5gw", Z.className = "svelte-aie5gw", C.id = "error-message", C.className = k = "error-group " + (e.error ? "show-error" : "hide-error") + " svelte-aie5gw", L.className = "svelte-aie5gw", void 0 === e.selectedSession && H(() => e.select_change_handler.call(D)), D.className = "session-list svelte-aie5gw", B.className = "session svelte-aie5gw", Y.src = fe.a, Y.alt = "login", Y.className = "svelte-aie5gw", T.id = "login-btn", T.className = "svelte-aie5gw", z.className = "bottom svelte-aie5gw", i.autocomplete = "off", i.className = "svelte-aie5gw", t.className = "container svelte-aie5gw", O = [M(c, "focus", e.clearError), M(p, "focus", e.clearError), M(D, "change", e.select_change_handler), M(i, "submit", (m = e.handleLogin, function(e) {
                    return e.preventDefault(), m.call(this, e)
                })), M(t, "focusin", he), M(t, "focusout", he)]
            },
            m(a, h) {
                v(a, t, h), m(t, n), m(n, o), m(t, r), m(t, i), m(i, s), m(s, c), m(s, l), m(s, u), m(i, d), m(i, f), m(f, p), m(f, g), m(f, w), m(i, N), m(i, C), m(C, Z), m(Z, A), m(i, G), m(i, z), m(z, B), m(B, L), m(B, U), m(B, D);
                for (var I = 0; I < W.length; I += 1) W[I].m(D, null);
                S(D, e.selectedSession), m(z, _), m(z, T), m(T, Y), R = !0, p.focus()
            },
            p(e, t) {
                if (R && !e.error || F === (F = t.error || "") || $(A, F), R && !e.error || k === (k = "error-group " + (t.error ? "show-error" : "hide-error") + " svelte-aie5gw") || (C.className = k), e.lightdm) {
                    X = t.lightdm.sessions;
                    for (var n = 0; n < X.length; n += 1) {
                        const o = pe(t, X, n);
                        W[n] ? W[n].p(e, o) : (W[n] = me(o), W[n].c(), W[n].m(D, null))
                    }
                    for (; n < W.length; n += 1) W[n].d(1);
                    W.length = X.length
                }
                e.selectedSession && S(D, t.selectedSession)
            },
            i(e) {
                R || (H(() => {
                    E && E.end(1), P || (P = V(t, ue, {
                        y: 40,
                        easing: ce
                    })), P.start()
                }), R = !0)
            },
            o(e) {
                P && P.invalidate(), e && (E = ee(t, le, {})), R = !1
            },
            d(e) {
                e && h(t), I(W, e), e && E && E.end(), a(O)
            }
        }
    }

    function me(e) {
        var t, n, o = e.session.name;
        return {
            c() {
                t = b("option"), n = y(o), t.__value = e.session, t.value = t.__value, t.className = "svelte-aie5gw"
            },
            m(e, o) {
                v(e, t, o), m(t, n)
            },
            p(e, n) {
                t.value = t.__value
            },
            d(e) {
                e && h(t)
            }
        }
    }

    function ve(e) {
        var t, n, o = e.isIdle && ge(e);
        return {
            c() {
                o && o.c(), t = w()
            },
            m(e, r) {
                o && o.m(e, r), v(e, t, r), n = !0
            },
            p(e, n) {
                n.isIdle ? o ? (o.p(e, n), o.i(1)) : ((o = ge(n)).c(), o.i(1), o.m(t.parentNode, t)) : o && (q(), K(() => {
                    o.d(1), o = null
                }), o.o(1), Q())
            },
            i(e) {
                n || (o && o.i(), n = !0)
            },
            o(e) {
                o && o.o(), n = !1
            },
            d(e) {
                o && o.d(e), e && h(t)
            }
        }
    }

    function he() {
        document.querySelector(".container").classList.toggle("container__active")
    }

    function Ie(e, t, n) {
        let o, r, {
            isIdle: i,
            toggleIdle: s,
            logIn: a
        } = t;
        const c = window.lightdm || {};
        return L(() => {
            s(), "default" !== c.default_session ? c.sessions.find(e => e.name === c.default_session) : n("selectedSession", r = c.sessions[0])
        }), window.show_prompt = ((e, t) => {
            const {
                value: n
            } = document.querySelector("#user-secret");
            "password" === t && c.respond(n)
        }), window.authentication_complete = (() => {
            c.is_authenticated ? (c.login(c.authentication_user, r.name.toLowerCase()), a()) : (s(), n("error", o = "Invalid username/password"))
        }), window.show_message = (e => {
            n("error", o = e)
        }), e.$set = (e => {
            "isIdle" in e && n("isIdle", i = e.isIdle), "toggleIdle" in e && n("toggleIdle", s = e.toggleIdle), "logIn" in e && n("logIn", a = e.logIn)
        }), {
            isIdle: i,
            toggleIdle: s,
            logIn: a,
            error: o,
            selectedSession: r,
            lightdm: c,
            clearError: function() {
                n("error", o = void 0)
            },
            handleLogin: function() {
                document.querySelector("#login-btn").blur();
                const {
                    value: e
                } = document.querySelector("#user-name"), {
                    value: t
                } = document.querySelector("#user-secret");
                e && t ? (c.authenticate(e), s()) : n("error", o = e || t ? e ? "missing password" : "missing username" : "missing username and password")
            },
            select_change_handler: function() {
                r = function(e) {
                    const t = e.querySelector(":checked") || e.options[0];
                    return t && t.__value
                }(this), n("selectedSession", r), n("lightdm", c)
            }
        }
    }
    var be = class extends se {
            constructor(e) {
                super(), ie(this, e, Ie, ve, l, ["isIdle", "toggleIdle", "logIn"])
            }
        },
        ye = n(4),
        xe = n.n(ye);
    n(9);

    function we(e) {
        var t, n, r, i, s, a, c;
        return {
            c() {
                t = b("div"), n = b("img"), r = x(), i = b("span"), s = y(je), n.src = xe.a, n.alt = "loading", n.className = "svelte-1gjz2c5", i.className = "svelte-1gjz2c5", t.className = "loader svelte-1gjz2c5"
            },
            m(e, o) {
                v(e, t, o), m(t, n), m(t, r), m(t, i), m(i, s), c = !0
            },
            p: o,
            i(e) {
                c || (H(() => {
                    a || (a = te(t, le, {
                        easing: ce
                    }, !0)), a.run(1)
                }), c = !0)
            },
            o(e) {
                a || (a = te(t, le, {
                    easing: ce
                }, !1)), a.run(0), c = !1
            },
            d(e) {
                e && (h(t), a && a.end())
            }
        }
    }

    function Me(e) {
        var t, n, o = !1 === e.isIdle && we();
        return {
            c() {
                o && o.c(), t = w()
            },
            m(e, r) {
                o && o.m(e, r), v(e, t, r), n = !0
            },
            p(e, n) {
                !1 === n.isIdle ? o ? (o.p(e, n), o.i(1)) : ((o = we()).c(), o.i(1), o.m(t.parentNode, t)) : o && (q(), K(() => {
                    o.d(1), o = null
                }), o.o(1), Q())
            },
            i(e) {
                n || (o && o.i(), n = !0)
            },
            o(e) {
                o && o.o(), n = !1
            },
            d(e) {
                o && o.d(e), e && h(t)
            }
        }
    }
    let je = "signing in";

    function $e(e, t, n) {
        let {
            isIdle: o
        } = t;
        return e.$set = (e => {
            "isIdle" in e && n("isIdle", o = e.isIdle)
        }), {
            isIdle: o
        }
    }
    var Se = class extends se {
        constructor(e) {
            super(), ie(this, e, $e, Me, l, ["isIdle"])
        }
    };
    n(11);

    function Ne(e) {
        var t, n, r, i, s, a, c, l;
        return {
            c() {
                t = b("div"), n = b("span"), r = y(e.hours), i = x(), (s = b("span")).textContent = ":", a = x(), c = b("span"), l = y(e.minutes), t.className = "clock svelte-6cac4v"
            },
            m(e, o) {
                v(e, t, o), m(t, n), m(n, r), m(t, i), m(t, s), m(t, a), m(t, c), m(c, l)
            },
            p(e, t) {
                e.hours && $(r, t.hours), e.minutes && $(l, t.minutes)
            },
            i: o,
            o: o,
            d(e) {
                e && h(t)
            }
        }
    }

    function Ce(e, t, n) {
        let o = new Date,
            r = void 0,
            i = "AM";
        var s;
        let a, c;
        return L(() => {
            n("interval", r = setInterval(() => {
                n("time", o = new Date), n("dayOrNight", i = a >= 12 ? "PM" : "AM")
            }, 3e3))
        }), s = (() => clearInterval(r)), B().$$.on_destroy.push(s), e.$$.update = ((e = {
            time: 1
        }) => {
            e.time && n("hours", a = o.getHours()), e.time && n("minutes", c = o.getMinutes() < 10 ? `0${o.getMinutes()}` : o.getMinutes())
        }), {
            hours: a,
            minutes: c
        }
    }
    var Ze = class extends se {
        constructor(e) {
            super(), ie(this, e, Ce, Ne, l, [])
        }
    };
    n(13);

    function Ae(e, t, n) {
        const o = Object.create(e);
        return o.option = t[n], o.index = n, o
    }

    function ke(e) {
        for (var t, n, o, r, i, s = Object.keys(e.userOptions), a = [], c = 0; c < s.length; c += 1) a[c] = ze(Ae(e, s, c));
        var l = new Ze({});
        return {
            c() {
                t = b("div");
                for (var e = 0; e < a.length; e += 1) a[e].c();
                n = x(), l.$$.fragment.c(), t.className = "svelte-1bnanxq"
            },
            m(e, o) {
                v(e, t, o);
                for (var r = 0; r < a.length; r += 1) a[r].m(t, null);
                m(t, n), oe(l, t, null), i = !0
            },
            p(e, o) {
                if (e.userOptions) {
                    s = Object.keys(o.userOptions);
                    for (var r = 0; r < s.length; r += 1) {
                        const i = Ae(o, s, r);
                        a[r] ? a[r].p(e, i) : (a[r] = ze(i), a[r].c(), a[r].m(t, n))
                    }
                    for (; r < a.length; r += 1) a[r].d(1);
                    a.length = s.length
                }
            },
            i(e) {
                i || (l.$$.fragment.i(e), H(() => {
                    r && r.end(1), o || (o = V(t, ue, {
                        delay: 200,
                        y: 20,
                        easing: ce
                    })), o.start()
                }), i = !0)
            },
            o(e) {
                l.$$.fragment.o(e), o && o.invalidate(), e && (r = ee(t, le, {})), i = !1
            },
            d(e) {
                e && h(t), I(a, e), l.$destroy(), e && r && r.end()
            }
        }
    }

    function Ge(e) {
        var t, n, o, r, i, s = Object.keys(e.userOptions)[e.index];

        function a() {
            return e.click_handler(e)
        }
        return {
            c() {
                t = b("span"), n = y(s), o = x(), (r = b("span")).textContent = "—", t.className = "action svelte-1bnanxq", r.className = "divider svelte-1bnanxq", i = M(t, "click", a)
            },
            m(e, i) {
                v(e, t, i), m(t, n), v(e, o, i), v(e, r, i)
            },
            p(t, n) {
                e = n
            },
            d(e) {
                e && (h(t), h(o), h(r)), i()
            }
        }
    }

    function ze(e) {
        var t, n = e.userOptions[e.option] && Ge(e);
        return {
            c() {
                n && n.c(), t = w()
            },
            m(e, o) {
                n && n.m(e, o), v(e, t, o)
            },
            p(e, o) {
                o.userOptions[o.option] ? n ? n.p(e, o) : ((n = Ge(o)).c(), n.m(t.parentNode, t)) : n && (n.d(1), n = null)
            },
            d(e) {
                n && n.d(e), e && h(t)
            }
        }
    }

    function Be(e) {
        var t, n, o = e.isIdle && ke(e);
        return {
            c() {
                o && o.c(), t = w()
            },
            m(e, r) {
                o && o.m(e, r), v(e, t, r), n = !0
            },
            p(e, n) {
                n.isIdle ? o ? (o.p(e, n), o.i(1)) : ((o = ke(n)).c(), o.i(1), o.m(t.parentNode, t)) : o && (q(), K(() => {
                    o.d(1), o = null
                }), o.o(1), Q())
            },
            i(e) {
                n || (o && o.i(), n = !0)
            },
            o(e) {
                o && o.o(), n = !1
            },
            d(e) {
                o && o.d(e), e && h(t)
            }
        }
    }

    function Le(e, t, n) {
        let {
            isIdle: o
        } = t, r = {
            hibernate: lightdm.can_hibernate,
            restart: lightdm.can_restart,
            shutdown: lightdm.can_shutdown,
            suspend: lightdm.can_suspend
        };
        return e.$set = (e => {
            "isIdle" in e && n("isIdle", o = e.isIdle)
        }), {
            isIdle: o,
            userOptions: r,
            click_handler: function({
                index: e
            }) {
                return t = Object.keys(r)[e], void lightdm[t]();
                var t
            }
        }
    }
    var Ue = class extends se {
        constructor(e) {
            super(), ie(this, e, Le, Be, l, ["isIdle"])
        }
    };
    n(15), n(16);

    function De(e) {
        var t, n, o, r, i, s = new be({
                props: {
                    isIdle: e.isIdle,
                    toggleIdle: e.toggleIdle,
                    logIn: _e
                }
            }),
            a = new Se({
                props: {
                    isIdle: e.isIdle
                }
            }),
            c = new Ue({
                props: {
                    isIdle: e.isIdle
                }
            });
        return {
            c() {
                t = b("img"), n = x(), s.$$.fragment.c(), o = x(), a.$$.fragment.c(), r = x(), c.$$.fragment.c(), t.className = "background svelte-13zn5s", t.alt = "background"
            },
            m(e, l) {
                v(e, t, l), v(e, n, l), oe(s, e, l), v(e, o, l), oe(a, e, l), v(e, r, l), oe(c, e, l), i = !0
            },
            p(e, t) {
                var n = {};
                e.isIdle && (n.isIdle = t.isIdle), e.toggleIdle && (n.toggleIdle = t.toggleIdle), e.logIn && (n.logIn = _e), s.$set(n);
                var o = {};
                e.isIdle && (o.isIdle = t.isIdle), a.$set(o);
                var r = {};
                e.isIdle && (r.isIdle = t.isIdle), c.$set(r)
            },
            i(e) {
                i || (s.$$.fragment.i(e), a.$$.fragment.i(e), c.$$.fragment.i(e), i = !0)
            },
            o(e) {
                s.$$.fragment.o(e), a.$$.fragment.o(e), c.$$.fragment.o(e), i = !1
            },
            d(e) {
                e && (h(t), h(n)), s.$destroy(e), e && h(o), a.$destroy(e), e && h(r), c.$destroy(e)
            }
        }
    }

    function _e() {
        document.querySelector("body").classList.add("logged-in")
    }

    function Te(e, t, n) {
        let o = null;
        return L(() => {
            const e = new Image;
            e.onload = (() => {
                const t = document.querySelector(".background");
                t.src = e.src, t.classList.add("imageReady")
            }), e.src = "./assets/background.jpg"
        }), {
            isIdle: o,
            toggleIdle: function() {
                n("isIdle", o = !o)
            }
        }
    }
    var Ye = class extends se {
        constructor(e) {
            super(), ie(this, e, Te, De, l, [])
        }
    };
    n(18);
    new Ye({
        target: document.querySelector("main")
    })
}]);
