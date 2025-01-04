/**
 * jquery.mask.js
 * @version: v1.6.2
 * @author: Igor Escobar
 *
 * Created by Igor Escobar on 2012-03-10. Please report any bug at http://blog.igorescobar.com
 *
 * Copyright (c) 2012 Igor Escobar http://blog.igorescobar.com
 *
 * The MIT License (http://www.opensource.org/licenses/mit-license.php)
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
/*jshint laxbreak: true */
/* global define */

// UMD (Universal Module Definition) patterns for JavaScript modules that work everywhere.
// https://github.com/umdjs/umd/blob/master/jqueryPlugin.js
//<editor-fold desc="plugins">
(function (factory) {
    if (typeof define === "function" && define.amd) {
        // AMD. Register as an anonymous module.
        define(["jquery"], factory);
    } else {
        // Browser globals
        factory(window.jQuery || window.Zepto);
    }
}(function ($) {
    "use strict";
    var Mask = function (el, mask, options) {
        var jMask = this, old_value;
        el = $(el);

        mask = typeof mask === "function" ? mask(el.val(), undefined, el, options) : mask;

        jMask.init = function () {
            options = options || {};

            jMask.byPassKeys = [9, 16, 17, 18, 36, 37, 38, 39, 40, 91];
            jMask.translation = {
                '0': {pattern: /\d/},
                '9': {pattern: /\d/, optional: true},
                '#': {pattern: /\d/, recursive: true},
                'A': {pattern: /[a-zA-Z0-9]/},
                'S': {pattern: /[a-zA-Z]/}
            };

            jMask.translation = $.extend({}, jMask.translation, options.translation);
            jMask = $.extend(true, {}, jMask, options);

            el.each(function () {
                if (options.maxlength !== false) {
                    el.attr('maxlength', mask.length);
                }

                if (options.placeholder) {
                    el.attr('placeholder', options.placeholder);
                }

                el.attr('autocomplete', 'off');
                p.destroyEvents();
                p.events();

                var caret = p.getCaret();

                p.val(p.getMasked());
                p.setCaret(caret + p.getMaskCharactersBeforeCount(caret, true));
            });
        };

        var p = {
            getCaret: function () {
                var sel,
                    pos = 0,
                    ctrl = el.get(0),
                    dSel = document.selection,
                    cSelStart = ctrl.selectionStart;

                // IE Support
                if (dSel && !~navigator.appVersion.indexOf("MSIE 10")) {
                    sel = dSel.createRange();
                    sel.moveStart('character', el.is("input") ? -el.val().length : -el.text().length);
                    pos = sel.text.length;
                }
                // Firefox support
                else if (cSelStart || cSelStart === '0') {
                    pos = cSelStart;
                }

                return pos;
            },
            setCaret: function (pos) {
                if (el.is(":focus")) {
                    var range, ctrl = el.get(0);

                    if (ctrl.setSelectionRange) {
                        ctrl.setSelectionRange(pos, pos);
                    } else if (ctrl.createTextRange) {
                        range = ctrl.createTextRange();
                        range.collapse(true);
                        range.moveEnd('character', pos);
                        range.moveStart('character', pos);
                        range.select();
                    }
                }
            },
            events: function () {
                el.on('keydown.mask', function () {
                    old_value = p.val();
                });
                el.on('keyup.mask', p.behaviour);
                el.on("paste.mask drop.mask", function () {
                    setTimeout(function () {
                        el.keydown().keyup();
                    }, 100);
                });
                el.on("change.mask", function () {
                    el.data("changeCalled", true);
                });
                el.on("blur.mask", function (e) {
                    var el = $(e.target);
                    if (el.prop("defaultValue") !== el.val()) {
                        el.prop("defaultValue", el.val());
                        if (!el.data("changeCalled")) {
                            el.trigger("change");
                        }
                    }
                    el.data("changeCalled", false);
                });

                // clear the value if it not complete the mask
                el.on("focusout.mask", function () {
                    if (options.clearIfNotMatch && p.val().length < mask.length) {
                        p.val('');
                    }
                });
            },
            destroyEvents: function () {
                el.off('keydown.mask keyup.mask paste.mask drop.mask change.mask blur.mask focusout.mask').removeData("changeCalled");
            },
            val: function (v) {
                var isInput = el.is('input');
                return arguments.length > 0
                    ? (isInput ? el.val(v) : el.text(v))
                    : (isInput ? el.val() : el.text());
            },
            getMaskCharactersBeforeCount: function (index, onCleanVal) {
                for (var count = 0, i = 0, maskL = mask.length; i < maskL && i < index; i++) {
                    if (!jMask.translation[mask.charAt(i)]) {
                        index = onCleanVal ? index + 1 : index;
                        count++;
                    }
                }
                return count;
            },
            determineCaretPos: function (originalCaretPos, oldLength, newLength, maskDif) {
                var translation = jMask.translation[mask.charAt(Math.min(originalCaretPos - 1, mask.length - 1))];

                return !translation ? p.determineCaretPos(originalCaretPos + 1, oldLength, newLength, maskDif)
                    : Math.min(originalCaretPos + newLength - oldLength - maskDif, newLength);
            },
            behaviour: function (e) {
                e = e || window.event;
                var keyCode = e.keyCode || e.which;

                if ($.inArray(keyCode, jMask.byPassKeys) === -1) {

                    var caretPos = p.getCaret(),
                        currVal = p.val(),
                        currValL = currVal.length,
                        changeCaret = caretPos < currValL,
                        newVal = p.getMasked(),
                        newValL = newVal.length,
                        maskDif = p.getMaskCharactersBeforeCount(newValL - 1) - p.getMaskCharactersBeforeCount(currValL - 1);

                    if (newVal !== currVal) {
                        p.val(newVal);
                    }

                    // change caret but avoid CTRL+A
                    if (changeCaret && !(keyCode === 65 && e.ctrlKey)) {
                        // Avoid adjusting caret on backspace or delete
                        if (!(keyCode === 8 || keyCode === 46)) {
                            caretPos = p.determineCaretPos(caretPos, currValL, newValL, maskDif);
                        }
                        p.setCaret(caretPos);
                    }

                    return p.callbacks(e);
                }
            },
            getMasked: function (skipMaskChars) {
                var buf = [],
                    value = p.val(),
                    m = 0, maskLen = mask.length,
                    v = 0, valLen = value.length,
                    offset = 1, addMethod = "push",
                    resetPos = -1,
                    lastMaskChar,
                    check;

                if (options.reverse) {
                    addMethod = "unshift";
                    offset = -1;
                    lastMaskChar = 0;
                    m = maskLen - 1;
                    v = valLen - 1;
                    check = function () {
                        return m > -1 && v > -1;
                    };
                } else {
                    lastMaskChar = maskLen - 1;
                    check = function () {
                        return m < maskLen && v < valLen;
                    };
                }

                while (check()) {
                    var maskDigit = mask.charAt(m),
                        valDigit = value.charAt(v),
                        translation = jMask.translation[maskDigit];

                    if (translation) {
                        if (valDigit.match(translation.pattern)) {
                            buf[addMethod](valDigit);
                            if (translation.recursive) {
                                if (resetPos === -1) {
                                    resetPos = m;
                                } else if (m === lastMaskChar) {
                                    m = resetPos - offset;
                                }

                                if (lastMaskChar === resetPos) {
                                    m -= offset;
                                }
                            }
                            m += offset;
                        } else if (translation.optional) {
                            m += offset;
                            v -= offset;
                        }
                        v += offset;
                    } else {
                        if (!skipMaskChars) {
                            buf[addMethod](maskDigit);
                        }

                        if (valDigit === maskDigit) {
                            v += offset;
                        }

                        m += offset;
                    }
                }

                var lastMaskCharDigit = mask.charAt(lastMaskChar);
                if (maskLen === valLen + 1 && !jMask.translation[lastMaskCharDigit]) {
                    buf.push(lastMaskCharDigit);
                }

                return buf.join("");
            },
            callbacks: function (e) {
                var val = p.val(),
                    changed = p.val() !== old_value;
                if (changed === true) {
                    if (typeof options.onChange === "function") {
                        options.onChange(val, e, el, options);
                    }
                }

                if (changed === true && typeof options.onKeyPress === "function") {
                    options.onKeyPress(val, e, el, options);
                }

                if (typeof options.onComplete === "function" && val.length === mask.length) {
                    options.onComplete(val, e, el, options);
                }
            }
        };

        // public methods
        jMask.remove = function () {
            var caret = p.getCaret(),
                maskedCharacterCountBefore = p.getMaskCharactersBeforeCount(caret);

            p.destroyEvents();
            p.val(jMask.getCleanVal()).removeAttr('maxlength');
            p.setCaret(caret - maskedCharacterCountBefore);
        };

        // get value without mask
        jMask.getCleanVal = function () {
            return p.getMasked(true);
        };

        jMask.init();
    };

    $.fn.mask = function (mask, options) {
        this.unmask();
        return this.each(function () {
            $(this).data('mask', new Mask(this, mask, options));
        });
    };

    $.fn.unmask = function () {
        return this.each(function () {
            try {
                $(this).data('mask').remove();
            } catch (e) {
            }
        });
    };

    $.fn.cleanVal = function () {
        return $(this).data('mask').getCleanVal();
    };

    // looking for inputs with data-mask attribute
    $('*[data-mask]').each(function () {
        var input = $(this),
            options = {},
            prefix = "data-mask-";

        if (input.attr(prefix + 'reverse') === 'true') {
            options.reverse = true;
        }

        if (input.attr(prefix + 'maxlength') === 'false') {
            options.maxlength = false;
        }

        if (input.attr(prefix + 'clearifnotmatch') === 'true') {
            options.clearIfNotMatch = true;
        }

        input.mask(input.attr('data-mask'), options);
    });

}));
//</editor-fold>


$(function () {
    // document.head.append('<script src="ZJBPMS/select2.min.js" type="text/javascript"></script>');
    //<editor-fold desc="********** formPanel">
    let formPanels = document.getElementsByClassName('form-panel');
    for (i = 0; i < formPanels.length; i++) {
        let title = formPanels[i].getAttribute('data-title');
        let header = document.createElement('h5');

        let panel = formPanels[i];
        header.classList.add('header');
        header.innerHTML = title;
        panel.prepend(header);
        header.addEventListener('click', function () {
            $(this).parent('.form-panel').toggleClass('show');
            $(this).next().toggle();
        });


        let expanded = panel.getAttribute('data-expanded');
        if (expanded == undefined || expanded == null) {
            expanded = true;
        }

        if (expanded.toString() == 'true') {
            panel.classList.add('show');
            panel.lastElementChild.style.display = 'block';
        } else {
            panel.classList.remove('show');
            panel.lastElementChild.style.display = 'none';
        }
    }
    //</editor-fold>

    $('.form-action input').each(function (i) {
        let classes = this.className.split(' ');
        let icon = '';
        let btnClass = '';
        if (classes.length > 0) {
            btnClass = classes[0];
            if (btnClass == 'Command') {
                this.className = 'default';
                btnClass = 'default'
            }
            ;
            icon = classes[1];
            if (icon == undefined) icon = '';
        }
        $(this).replaceWith("<div class='button-area " + btnClass + "'><span class='icon fa fa-" + icon + "'></span>" + this.outerHTML + "</div>");
    });


    //checkBox Positions
    $('.form-group .CheckBoxTitle > input').each(function () {
        let label = $(this).parent('.CheckBoxTitle').context.nextSibling.textContent;
        $(this).parent('.CheckBoxTitle').parent('.form-group').html('<label>' + label + '</label><div class="checkbox-area"> ' + this.outerHTML + '</div>');
    });

    $(".button-area input[type='button']:disabled , .button-area button:disabled").each(function () {
        // console.log(this.parentElement);
        this.parentElement.className = "button-area disabled";
    });
    $(".multiple-input input[type='button']:disabled , .multiple-input button:disabled").each(function () {
        // console.log(this.parentElement);
        this.parentElement.className = "multiple-input disabled";
    });


    manageTabControl();
    manageCombobox();
    checkIfHasFocusableElement();
    hideLoading();
    manageCombobox();
    // console.log();
    document.body.className = parent.document.body.className;
});

function manageTabControl() {
    // console.log(window.parent.document.getElementsByTagName("iframe"));
    const currentFormId = parent.$("iframe").attr("id");
    let $tabButtonArea = $("<div class='tab-button-area'></div>");
    let index = 0;
    let firstTabId = null;
    $.each($(".tab-control .tab"), function (i, v) {
        let tabId = $(this).attr("tab-id");
        let tabTitle = $(this).attr("tab-title");
        console.log($(this).attr("tab-disabled"));
        let isDisabled = $(this).attr("tab-disabled") == "true" ? 'disabled' : '';
        // $tabButtonArea.append("<button type='button' " + isDisabled + " tab-id='" + tabId + "' onclick='showCurrentTab(" + currentFormId + " , " + tabId + ")' class='tab-button'>" + tabTitle + "</button>");
        $tabButtonArea.append(`<button class='tab-button' type='button' ${isDisabled} tab-id='${tabId}' onclick=showCurrentTab('${currentFormId}','${tabId}') > ${tabTitle}</button>`);
        $(this).parent(".tab-control").prepend($tabButtonArea);
        if (index == 0) {
            firstTabId = tabId;
        }
        index++;
    });

    //handle if currentTab storage has value
    let storage = localStorage.getItem("currentTabId") != null &&
    localStorage.getItem("currentTabId") != undefined ?
        JSON.parse(localStorage.getItem("currentTabId")) : null;
    if (storage != null) {
        let storage_tabId = storage.tabId;
        let storage_formId = storage.formId;
        if (storage_tabId && storage_formId == currentFormId) {
            $(".tab-control button").removeClass("selected");
            $(".tab-control .tab[tab-id='" + storage_tabId + "']").show();
            $(".tab-control button[tab-id='" + storage_tabId + "']").addClass("selected");
        } else {
            showCurrentTab(currentFormId, firstTabId);
        }
    } else {
        showCurrentTab(currentFormId, firstTabId);
    }
}

function showCurrentTab(formId, tabId) {
    localStorage.setItem("currentTabId", JSON.stringify({formId, tabId}));
    $(".tab-control .tab").hide();
    $(".tab-control button").removeClass("selected");
    $(".tab-control .tab[tab-id='" + tabId + "']").show();
    $(".tab-control button[tab-id='" + tabId + "']").addClass("selected");
}


function checkIfHasFocusableElement() {
    // get form session
    let formSessionKey = $("input[zid$='txtFormSession']").val();
    if (formSessionKey) {
        if (localStorage.getItem("form-focus-element-name") != null && localStorage.getItem("form-focus-element-name") != undefined) {
            let current = localStorage.getItem("form-focus-element-name").toString();
            if (current.length > 1) {
                let formKey = current.split("@")[0];
                let elementName = current.split("@")[1];
                let position = current.split("@")[2];
                if (formKey === formSessionKey) {
                    let id = $("[zid='" + elementName + "']").attr("id");
                    if (!id) {
                        id = elementName;
                    }
                    let element = document.getElementById(id);
                    if (element) {

                        // element.style.display="block";
                        // element.style.opacity = "0";
                        // element.style.position ="absolute";
                        // element.focus({preventScroll: false});

                        let newId = "selectator_" + id;
                        window.location.hash = '#' + newId;

                        window.scrollTo(0, Number(position));
                    }
                }
            }
        }
    }

    if (localStorage.getItem("focus-select-id") != null && localStorage.getItem("focus-select-id") != undefined) {
        let id = localStorage.getItem("focus-select-id");
        console.log(id, document.getElementById(id));
        let el = document.getElementById(localStorage.getItem("focus-select-id"));
        if (el != null && el != undefined) {
            el.focus();
        }
    }
}

function hideLoading() {
    let loading1 = window.parent.document.getElementById("isc-loading-1");
    let loading2 = window.parent.document.getElementById("isc-loading-2");
    if (loading1) {
        loading1.style.display = "none"
    }
    if (loading2) {
        loading2.style.display = "none"
    }
}


function manageCombobox() {
    $.each($('select'), function () {
        let id = $(this).attr("id");
        let count = $("#" + id + " option").length;
        let disable = $(this).attr('disabled');
        let placeHolder = count > 0 ? 'انتخاب نمایید' : 'موردی یافت نشد';
        // if (count == 0) {
        //     $($(this)).selectator({placeholder: 'مقداری وجود ندارد', label: {searchTitle: 'جستجو ...'}, useSearch: false});
        // } else if (!this.disabled) {
        //     $($(this)).selectator({placeholder: 'انتخاب نمایید', label: {searchTitle: 'جستجو ...'}});
        // } else {
        //     $($(this)).selectator({placeholder: 'انتخاب نمایید', label: {searchTitle: 'جستجو ...'}, useSearch: false});
        // }

        if (disable) {
            $("#selectator_" + id).addClass("selectator_disabled").addClass('disable_search');
            $("#selectator_" + id).unbind();
            $("#selectator_" + id).children('.selectator_input').remove();
            $("#selectator_" + id).children('.selectator_options').remove();
        }
//        $($(this)).selectator({
//            placeholder: placeHolder,
//            label: {searchTitle: 'جستجو ...'},
//            useSearch: count > 0,
//            minSearchLength: 5
//        });

    })
    // $('select').selectator({placeholder: 'انتخاب نمایید', label: {searchTitle: 'جستجو ...'}});
    // $('select').select2({placeholder: 'انتخاب نمایید'});

    $('select').on('change', function () {
        let elementName = $(this).attr("id");
        console.log("fromOnChange", elementName);
        localStorage.setItem("focus-select-id", elementName);
        let el = document.getElementById(elementName);
        if (el != null && el != undefined) {
            el.focus()
        }
    });
}
