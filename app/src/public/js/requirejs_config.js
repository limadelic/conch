window.requirejs_config = {
    baseUrl: '/coffee/',
    paths: {
        jquery: '//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min',
        cs: '//cdnjs.cloudflare.com/ajax/libs/require-cs/0.4.2/cs',
        'coffee-script': '//cdnjs.cloudflare.com/ajax/libs/coffee-script/1.6.3/coffee-script.min',
        underscore: '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.1/underscore-min',
        autosize: '//cdnjs.cloudflare.com/ajax/libs/autosize.js/1.17.1/autosize-min',
        backbone: '//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone-min'
    },
    shim: {
        underscore: {
            exports: '_'
        },
        backbone: {
            deps: ['underscore', 'jquery'],
            exports: 'Backbone'
        }
    }
};