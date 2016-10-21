$(function(){
    var editor = new Simditor({
        textarea: $('#Editor'),
        upload: {
            url: '/index.php/upload/do_upload_fdfs',
            params: null,
            fileKey: 'upload_file',
            connectionCount: 3,
            leaveConfirm: 'Uploading is in progress, are you sure to leave this page?'
        }
    });
});