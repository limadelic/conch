window.requirejs_config = {
    baseUrl: '/coffee/',
    paths: {
        jquery: '/js/jquery',
        cs: '/js/cs',
        'coffee-script': '/js/coffee-script',
        underscore: '/js/underscore',
        autosize: '/js/jquery.autosize-min',
        backbone: '/js/backbone'
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