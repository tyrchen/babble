(function() {
	tinymce.create('tinymce.plugins.FilePickerPlugin', {
		init : function(ed, url) {
			this.editor = ed;

			// Register commands
			ed.addCommand('mceFilePicker', function() {
                filepicker.pick({
                    container: 'modal',
                    services: ['COMPUTER'],
                    mimetype: 'image/*'
                }, function(fpfile) {
                    console.log('uploaded:', fpfile)
                    ed.setContent('<img src="' + fpfile.url + '" />');
                });
			});

			// Register buttons
			ed.addButton('filepicker', {
				title : '上传图片',
				cmd : 'mceFilePicker'
			});

			ed.addShortcut('ctrl+k', '上传图片', 'mceFilePicker');

			ed.onNodeChange.add(function(ed, cm, n, co) {
				//cm.setDisabled('link', co && n.nodeName != 'A');
				//cm.setActive('link', n.nodeName == 'A' && !n.name);
			});
		},

		getInfo : function() {
			return {
				longname : 'filepicker',
				author : 'Tyr Chen',
				authorurl : 'http://tchen.me',
				//infourl : 'http://wiki.moxiecode.com/index.php/TinyMCE:Plugins/advlink',
				version : tinymce.majorVersion + "." + tinymce.minorVersion
			};
		}
	});

	// Register plugin
	tinymce.PluginManager.add('filepicker', tinymce.plugins.FilePickerPlugin);
})();