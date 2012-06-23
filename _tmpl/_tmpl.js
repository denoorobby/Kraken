/*
 * This is a fast and lightweight template rendering solution built off of underscore.js.
 * Only the necessary bits of underscore are included.
 *
 * The following enhancements are included: 
 *
 *   window.UL.renderTemplate(templateId, data) 
 *     A helper method that renders a template, contained within the supplied element id, with the given data.
 *     This method also caches the compiled template in window.UL.templateCache. Subsequent calls to renderTemplate
 *     with the same templateId are rendered using the cached template.
 *
 *   Mustache templates are the default template style {{ name }}. This is because erb style conflict with Ruby erb processing.
 *   You can override this and set whatever format you want using _.templateSettings.
 *   See http://documentcloud.github.com/underscore/#template for more info.
 *
 *   See test.html for a sample usage of this code.
 *
 *
 *
 * Original Copyright and credits:
 *
 *     Underscore.js 1.3.3
 *     (c) 2009-2012 Jeremy Ashkenas, DocumentCloud Inc.
 *     Underscore is freely distributable under the MIT license.
 *     Portions of Underscore are inspired or borrowed from Prototype,
 *     Oliver Steele's Functional, and John Resig's Micro-Templating.
 *      For all details and documentation:
 *     http://documentcloud.github.com/underscore
 */
(function() {

  if (window._ == null){

    window._  = {};

   // By default, Underscore uses ERB-style template delimiters, change the
    // following template settings to use alternative delimiters.
    _.templateSettings = {
      evaluate    : /<%([\s\S]+?)%>/g,
      interpolate : /<%=([\s\S]+?)%>/g,
      escape      : /<%-([\s\S]+?)%>/g
    };

    // When customizing `templateSettings`, if you don't want to define an
    // interpolation, evaluation or escaping regex, we need one that is
    // guaranteed not to match.
    var noMatch = /.^/;

    // Certain characters need to be escaped so that they can be put into a
    // string literal.
    var escapes = {
      '\\':   '\\',
      "'":    "'",
      r:      '\r',
      n:      '\n',
      t:      '\t',
      u2028:  '\u2028',
      u2029:  '\u2029'
    };

    for (var key in escapes) escapes[escapes[key]] = key;
    var escaper = /\\|'|\r|\n|\t|\u2028|\u2029/g;
    var unescaper = /\\(\\|'|r|n|t|u2028|u2029)/g;

    // Within an interpolation, evaluation, or escaping, remove HTML escaping
    // that had been previously added.
    var unescape = function(code) {
      return code.replace(unescaper, function(match, escape) {
        return escapes[escape];
      });
    };

    // added by mattpage as a replacement for underscores _defaults method
    function merge(destination, source) {
        for (var property in source) {
            if (source.hasOwnProperty(property)) {
                destination[property] = source[property];
            }
        }
        return destination;
    };
    
    // JavaScript micro-templating, similar to John Resig's implementation.
    // Underscore templating handles arbitrary delimiters, preserves whitespace,
    // and correctly escapes quotes within interpolated code.
    _.template = function(text, data, settings) {
      settings = merge(settings || {}, _.templateSettings);

      // Compile the template source, taking care to escape characters that
      // cannot be included in a string literal and then unescape them in code
      // blocks.
      var source = "__p+='" + text
        .replace(escaper, function(match) {
          return '\\' + escapes[match];
        })
        .replace(settings.escape || noMatch, function(match, code) {
          return "'+\n((__t=(" + unescape(code) + "))==null?'':_.escape(__t))+\n'";
        })
        .replace(settings.interpolate || noMatch, function(match, code) {
          return "'+\n((__t=(" + unescape(code) + "))==null?'':__t)+\n'";
        })
        .replace(settings.evaluate || noMatch, function(match, code) {
          return "';\n" + unescape(code) + "\n__p+='";
        }) + "';\n";

      // If a variable is not specified, place data values in local scope.
      if (!settings.variable) source = 'with(obj||{}){\n' + source + '}\n';

      source = "var __t,__p='',__j=Array.prototype.join," +
        "print=function(){__p+=__j.call(arguments,'')};\n" +
        source + "return __p;\n";

      var render = new Function(settings.variable || 'obj', '_', source);
      if (data) return render(data, _);
      var template = function(data) {
        return render.call(this, data, _);
      };

      // Provide the compiled function source as a convenience for precompilation.
      template.source = 'function(' + (settings.variable || 'obj') + '){\n' + source + '}';

      return template;
    };
  }

  //change underscore templates to use mustache style as a default
  _.templateSettings = {
    interpolate : /\{\{(.+?)\}\}/g
  };

  window.UL = window.UL || {};

  var nmsp = window.UL;

  //we'll store our global templates here
  nmsp.templateCache = nmsp.templateCache || {};
  
  //render a template, contained within the supplied element id, with the given data
  nmsp.renderTemplate = function(templateElemId, data){
    
    var elem;
    var cache = nmsp.templateCache;

    if (!cache.hasOwnProperty(templateElemId)){

      elem = document.getElementById(templateElemId);
      if (elem == null){
        return null;
      }

      cache[templateElemId] = _.template(elem.innerHTML); 
    }

    return cache[templateElemId](data);
  };

}).call(this);
