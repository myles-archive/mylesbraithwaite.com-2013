$(document).ready(function() {
    $("a[rel*='external']").click(function() {
        _gaq.push(['_trackPageview', '/outgoing/' + $(this).attr('href')]);
    });
    
    $("div.illustration a").fancybox();
    $("div.illustrations a").fancybox();
    
    // If the user is coming from a Linux based OS they should get a
    // font more suited to their OS.
    if (navigator.platform.lastIndexOf("Linux", 0) === 0) {
        var link_css = document.createElement('link');
        link_css.href = '/media/css/ubuntu.css';
        link_css.rel = 'stylesheet';
        $("link[rel*='stylesheet']").after(link_css);
    };
    
    // Still working on a Matrix style.
    if (document.location.search.split('?')[1].lastIndexOf("matrix", 0) === 0) {
        var link_css = document.createElement('link');
        link_css.href = '/media/css/matrix.css';
        link_css.rel = 'stylesheet';
        $("link[rel*='stylesheet']").after(link_css);
    };
    
    
    var d = new Date();
    
    // Add a little heart when it's Valentines Day.
    if (d.getMonth() == 1 && d.getDate() == 14) {
        var img = document.createElement('img');
        img.src = '/media/img/icons/heart.png';
        img.alt = 'Happy Valentines Day';
        img.title = img.alt;
        $("header#top h1").append(img);
    };
    
    // Add a Canadian flag when it's Canada Day.
    if (d.getMonth() == 6 && d.getDate() == 1) {
        var img = document.createElement('img');
        img.src = '/media/img/icons/ca.png';
        img.alt = 'Happy Canada Day';
        img.title = img.alt;
        $("header#top h1").append(img);
    }
    
    // Add a Cake when it's my birthday.
    if (d.getMonth() == 8 && d.getDate() == 19) {
        var img = document.createElement('img');
        img.src = '/media/img/icons/cake.png';
        img.alt = 'Today is my birthday!';
        img.title = img.alt;
        $("header#top h1").append(img);
    }
})