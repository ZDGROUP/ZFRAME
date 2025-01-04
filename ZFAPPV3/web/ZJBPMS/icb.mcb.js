const McbMessageService = function () {

    const root = this;
    const messageTypes = ['info', 'warn', 'error'];
    let messageQueue = [];
    let isOnPlay = false;

    this.push = function (message, type) {
        let typeIndex = 0;
        if (type) {
            typeIndex = messageTypes.indexOf(type.trim().toLowerCase());
        }
        if (typeIndex < 0) {
            typeIndex = 0;
        }
        messageQueue.push({
            message: message,
            type: messageTypes[typeIndex]
        });
        showWithDelay();
    }

    this.pull = function (count) {
        if (!Number.isInteger(count)) {
            count = 1;
        }
        return messageQueue.splice(0, count);
    }

    const addMessage = function (comp, m) {
        if (m && m.length > 0) {
            comp.setContent('');
            return m.forEach(v => comp.setContentAppend(`<div>${v.message}</div>`));
        }
        return '';
    }

    const showJQueryConfirm = function (messages) {
        // split message Type
        let errorList = [];
        let infoList = [];
        let warnList = [];

        $.each(messages, function (i, v) {
            if (v.type === 'warn') {
                warnList.push(v);
            } else if (v.type === 'info') {
                infoList.push(v);
            } else {
                errorList.push(v);
            }
        });

        if (errorList.length > 0) {
            $.dialog({
                icon: 'jconfirm-icon-c',
                title: 'خطایی رخ داده',
                theme: 'mcb-message mcb-error',
                rtl: true,
                content: '',
                onOpen: function () {
                    isOnPlay = true;
                },
                onContentReady: function () {
                    const self = this;
                    if (errorList.length > 0) {
                        addMessage(self, errorList);
                        self.interval = setInterval(function () {
                            errorList = root.pull(100);
                            if (errorList.length > 0) {
                                addMessage(self, errorList);
                            }
                        }, 95000);
                    }
                },
                onClose: function () {
                    clearInterval(this.interval);
                    isOnPlay = false;
                    show();
                }
            });
        }
        if (infoList.length > 0) {
            $.dialog({
                icon: 'jconfirm-icon-c',
                title: '-',
                theme: 'mcb-message mcb-info',
                rtl: true,
                content: '',
                onOpen: function () {
                    isOnPlay = true;
                },
                onContentReady: function () {
                    const self = this;
                    if (infoList.length > 0) {
                        addMessage(self, infoList);
                        self.interval = setInterval(function () {
                            infoList = root.pull(100);
                            if (infoList.length > 0) {
                                addMessage(self, infoList);
                            }
                        }, 95000);
                    }
                },
                onClose: function () {
                    clearInterval(this.interval);
                    isOnPlay = false;
                    show();
                }
            });
        }
        if (warnList.length > 0) {
            $.dialog({
                icon: 'jconfirm-icon-c',
                title: '-',
                theme: 'mcb-message mcb-warning',
                rtl: true,
                content: '',
                onOpen: function () {
                    isOnPlay = true;
                },
                onContentReady: function () {
                    const self = this;
                    if (warnList.length > 0) {
                        addMessage(self, warnList);
                        self.interval = setInterval(function () {
                            warnList = root.pull(100);
                            if (warnList.length > 0) {
                                addMessage(self, warnList);
                            }
                        }, 95000);
                    }
                },
                onClose: function () {
                    clearInterval(this.interval);
                    isOnPlay = false;
                    show();
                }
            });
        }
    }

    const showWithDelay = function () {
        setTimeout(show, 300);
    }

    const show = function () {
        if ($.dialog) {
            if (!isOnPlay) {
                let messages = root.pull(100);
                if (messages && messages.length > 0) {
                    showJQueryConfirm(messages);
                }
            }
        } else {
            console.error("jquery-confirm is not present");
        }
    }
}

window.McbServices = (function () {
    const _messageService = new McbMessageService();
    return {
        messageService: _messageService
    }
})();
