CKEDITOR.editorConfig = function (config) {
    config.toolbar = 'MyToolbar';
    config.toolbar_MyToolbar =
        [
            { name:'document', items:[ 'NewPage', 'Preview' ] },
            { name:'clipboard', items:[ 'Cut', 'Copy', 'Paste', 'PasteText', '-', 'Undo', 'Redo' ] },
            { name:'editing', items:[ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
            { name:'insert', items:[ 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak'
                , 'Iframe' ] },
            { name:'links', items:[ 'Link', 'Unlink', 'Anchor' ] },
            '/',
            { name:'styles', items:[ 'Styles', 'Format' ] },
            { name:'basicstyles', items:[ 'Bold', 'Italic', 'Strike', '-', 'RemoveFormat' ] },
            { name:'paragraph', items:[ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'] },
            { name:'tools', items:[ 'Maximize', '-', 'About' ] }
        ];
    config.toolbarCanCollapse = false;
    //工具栏的位置
    config.toolbarLocation = 'top';//可选：bottom
};