$(document).ready(function() {
    $('.reply-button').on('click', function() {
        $(this).next('.reply-input').toggle();
    });
});