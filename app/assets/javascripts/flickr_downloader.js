$(document).ready(function () {
    var box = $(".flickr-box"),
        button = box.find("button"),
        input = box.find("input[name='flickr_search']"),
        icon_serach = box.find(".glyphicon-search"),
        icon_refresh = box.find(".glyphicon-refresh"),
        images = box.find(".images");

    $("#download-from-flickr").click(function () {
        box.toggle();
        return false;
    });

    button.click(function () {
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
                images.append(anchor)
            })
        }).fail(function (xhr) {
            alert(xhr.responseJSON.error)
        }).always(function () {
            button.attr({ 'disabled': false });
            input.attr({ 'disabled': false });
            icon_refresh.hide();
            icon_serach.show()
        });
    });
});
