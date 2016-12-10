$(document).ready(function () {
    var image_box = $(".image-box"),
        card_image = image_box.find("#card_image"),
        flickr_anchor = image_box.find("#flickr-anchor"),
        flickr_box = image_box.find(".flickr-box"),
        button = flickr_box.find("button"),
        card_remote_image_url = flickr_box.find("#card_remote_image_url"),
        input = flickr_box.find("input[name='flickr_search']"),
        icon_serach = flickr_box.find(".glyphicon-search"),
        icon_refresh = flickr_box.find(".glyphicon-refresh"),
        images = flickr_box.find(".images");

    var bindThumbnails = function (flickr_box, card_remote_image_url) {
        var thumbnails = flickr_box.find('.thumbnail');
        thumbnails.click(function () {
            card_remote_image_url.val($(this).find('img').attr('src'));
            thumbnails.removeClass('selected');
            $(this).addClass('selected');
            card_image.val('');
        });
    };

    flickr_anchor.click(function () {
        flickr_box.toggle();
        card_image.toggle();
        return false;
    });

    card_image.change(function () {
       if (card_image.val()) {
           card_remote_image_url.val('');
       }
    });

    button.click(function () {
        if (!input.val().trim()) {
            return false;
        }
        button.attr({ 'disabled': true });
        input.attr({ 'disabled': true });
        icon_refresh.css("display", "inline-block");
        icon_serach.hide();
        $.ajax({
            url: "/flickr/photos_search.json",
            data: { text: input.val() }
        }).done(function (photos) {
            images.html('');
            photos.forEach(function (photo) {
                var anchor = $('<a></a>').addClass('thumbnail');
                var image = $('<img />').attr({
                    title : photo.title,
                    src: photo.url
                });
                anchor.append(image);
                images.append(anchor);
            });
            bindThumbnails(flickr_box, card_remote_image_url);
        }).fail(function (xhr) {
            alert(xhr.responseJSON.error);
        }).always(function () {
            button.attr({ 'disabled': false });
            input.attr({ 'disabled': false });
            icon_refresh.hide();
            icon_serach.show();
        });
    });
});
