window.faye_subscriber = new Faye.Client('/faye');

jQuery(function(){
    faye_subscriber.subscribe('/comments', function(data){
        if (data.message.length > 0) {

            var size = "<em class='number'>" + data.size + "</em>";
            $('.comments_size_heading .number').replaceWith(size);

            // if user opened any form, then close it and empty the comment textarea after submit
            var opened_id = $('body').attr('id');
            $('#comment_'+opened_id+' #comment_form_container').replaceWith("<div class='form_replace form_replace_" + opened_id + "'></div>");
            $('body').removeClass('comment_form_open');
            $('body').removeAttr('id');

            // Change only the contents
            if (data.id && data.action === 'update') {
                $('#comment_list #comment_'+ data.id + ' > .body').replaceWith("<div class='body'>"+ data.message +"</div>");
            } else {
                // Empty the comment textarea
                $('#comment_body').val('');
                if (data.parent_id) {
                    // Children comment
                    var ul_element = $('#comment_list #comment_' + data.parent_id).find('ul');
                    if ( ul_element.length ) {
                        ul_element.append(data.message);
                    } else {
                        $('#comment_list #comment_' + data.parent_id).append("<ul>"+ data.message +"</ul>");
                    }

                } else {
                    // Root comment
                    $('#comment_list').prepend(data.message);
                }

            }
        }
    });
});