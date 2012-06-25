#Kraken

A toolkit for web development, with a penchant for mobile-related tech.

Still murky, but one idea is to create templates that use various libraries, then reverse-engineer them to be auto-generatable. We'll have to keep versioning in mind though.

##Templates

- bootstrap-iscroll: Uses Bootstrap and iScroll to create a responsive UX

##Generator
See [/generator/README.md](https://github.com/upstart/Kraken/blob/master/generator/README.md) for more info.

##_tmpl.js

This is a fast and lightweight (1.4k) template rendering solution built off of underscore.js.
Only the necessary bits of underscore are included. 
 
###The following enhancements are included: 
 
* window.UL.renderTemplate(templateId, data) 
  A helper method that renders a template, contained within the supplied element id, with the given data.
  This method also caches the compiled template in window.UL.templateCache. Subsequent calls to renderTemplate
  with the same templateId are rendered using the cached template.
* Mustache templates are the default template style {{ name }}. This is because erb style conflict with Ruby erb processing.
  You can override this and set whatever format you want using _.templateSettings.
  See http://documentcloud.github.com/underscore/#template for more info.
 
See test.html for a sample usage of this code.

Note: If you happen to have already loaded underscore, this script will defer to that instance.
      That is, it will not load its subset of underscore over an existing instance of underscore.



