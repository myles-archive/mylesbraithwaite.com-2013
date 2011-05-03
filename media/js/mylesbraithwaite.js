$(document).ready(function() {
    $("a[rel*='external']").click(function() {
        _gaq.push(['_trackPageview', '/outgoing/' + $(this).attr('href')]);
    });
    
    $("div.illustration a").fancybox();
    $("div.illustrations a").fancybox();
    
    if (navigator.platform.lastIndexOf("Linux", 0) === 0) {
        var link_css = document.createElement('link');
        link_css.href = '/media/css/font-ubuntu.css';
        link_css.rel = 'stylesheet';
        $("link[rel*='stylesheet']").after(link_css);
    };
})