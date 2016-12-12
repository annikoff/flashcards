$(document).ready(function () {
    var card_image = $("#card_image"),
        flickr_box = $("#flickr-box"),
        card_remote_image_url = $("#card_remote_image_url");

    card_image.change(function () {
        card_remote_image_url.val('');
    });

    flickr_box.find("button").click(function () {
        var input = flickr_box.find("input[name='flickr_search']");
        $.ajax({
            url: "/flickr_search.json",
            data: { text: input.val() }
        }).done(function (photos) {
            var images = flickr_box.find(".images");
            images.html('');
            photos.forEach(function (photo) {
                var anchor = $('<a></a>').addClass('thumbnail');
                var image = $('<img />').attr({
                    title : photo.title,
                    src: photo.url
                });
                anchor.append(image);
                anchor.click(function () {
                    card_remote_image_url.val(image.attr('src'));
                    card_image.val('');
                });
                images.append(anchor);
            });
        });
    });
});
