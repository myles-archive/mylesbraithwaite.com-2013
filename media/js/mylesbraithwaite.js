$(document).ready(function() {
    $("a[rel*='external']").click(function() {
        _gaq.push(['_trackPageview', '/outgoing/' + $(this).attr('href')]);
    });
    
    $("div.illustration a").fancybox();
    $("div.illustrations a").fancybox();
})